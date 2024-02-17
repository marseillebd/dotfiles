It's all well and good to have a system package manager, but
- My own development environment often relies on programs that either have not been packaged for my system, or have only old versions packaged, or have quirks in their packaging.
- System package managers install default configuration files, but I use _my_ configuration.
- It is sometimes useful to be able to install programs without admin priveledges.

Thus, I have written this (poor approximation of a) package manager.
It's just for me, uses only my configuration, targets only my systems, includes only my tools.
If you find some value in it, then I am glad for you, but the primary audience is my future self.
I just want to use this system to get going on a fresh install, and I want to keep it up to date.
To that end, I have these design philosophies:
- Make it easy to read and modify all the scripts. (Keep them small! Avoid conditionals!)
- Write documentation explaining why it all works, so I don't always have to read the code. (Keep those docs close to the code!)
- Make it easy to test if the script will work. (Use Docker to test scripts on a clean system.)
- [ ] TODO Make it easy to check code quality. (Use lint scripts!)

# Terminology

A "package" is just a folder (under the `upscripts/`) directory, with a particular structure.
It primarily holds scripts to install and configure tools.

A package may have multiple installation "methods", such as installing via a system package manager vs installing from source.

An integration is just a particular sort of package that configures one tool to use another.
They are stored underneath another package, but otherwise share the same structure as a regular package.

A profile is just a list of packages (with install method) and integrations.

# Usage

Run scripts for a package:
```sh
./upup.sh profiles/someProfile
```

Run one particular package's scripts:
```sh
./upup.sh <(echo somePkg)
```

Generate documentation from package scripts:
```sh
./updoc.sh
```

Generate documentation and "upload" to Obsidian (on lazarenko):
```sh
./upobsidian.sh
```

# Maintenance

## Package Structure

- `foo/` the name of the package
  - `foo.md` contains information for humans
  - [ ] `foo.yaml` TODO: yaml frontmatter for Obsidian
  - [ ] `check.sh` TODO: a script to check if the tool is installed (and has the right version/compiletime flags/&c)
  - `foo.sh` a "default" install method
  - `foo-meh.sh` alternate install methods have the method name appended after a dash
  - `foo-bar.sh` many alternate methods are possible
  - `config.sh` a config script; configuration should be the same regardless of the install method
  - `dotfiles/` a directory for configuration files that `config.sh` installs
    - `foorc.foo` files that are hidden on install should not be hidden here, and should probably have a file extension
  - `activate.sh` source any configs that might be relevant to later installs (e.g. an install added an entry to the `PATH`)
  - `integrations/`
    - `bash` each integration is another package, named after the program the main tool integrates into
    - `zsh` you can have as many integrations as you like, but integrations do not themselves contain integrations
    - `csh` the name of the integration should be the same as the name of the package it integrates with
- `fooPlugin/` plugins are themselves just packages; I recommend camelCase for plugins

## Testing

I have not been able to set up a CI system, which is unfortunate.
The problems are:
- each upscript needs to run its own test(s), so they each needs their own dockerfile(s)
- each upscript may have dependencies (git, curl, wget) which are most easily installed from root (or sudo)

What I have instead is a top-level dockerfile for developement.
It is based on the ubuntu distro I currently have on this computer.
The root user installs some commands as dependencies; change these to be minimal so that you can see what your script actually needs.
Once that edit is made, run it with the following, and try to use the upscript.
```
docker build --tag tmp . && docker run --rm -it tmp
```

## The `upup` script

There's the `upup.sh` script, which combines scripts from a profile.
It first defines a few variables and utility functions that can be used in the scripts it invokes:
- `UPUP_BINDIR`: for executables (scripts and binaries) which should go in the `PATH`, is `${HOME}/.local/bin`
- `UPUP_CONFIGDIR`: for configuration files, is `${XDG_CONFIG_HOME:-${HOME}/.config}`
- `UPUP_BUILDDIR`: for intermediate files like source code (though they may stick around), is `${HOME}/.local/.build`
- `UPUP_ln`: like `ln`, but sets flags for backups and whatnot
- `UPUP_sudo`: tries to install via the system's package manager
It then scans the lines of a "profile" file, which just lists upscripts you want installed.

First it runs thouse matching `<name>(-<method>)?` by:
- [ ] TODO: run `upscripts/<name>/check.sh` to see if the package is isntalled
  - if the installation is good (`exit 0`), then the install step is skipped (but not condigure/activate)
- running `upscripts/<name>/<name>-<method>.sh`
- running `upscripts/<name>/config.sh`, if it exists
- running `upscripts/<name>/activate.sh`, if it exists
All upscripts should run under `sh` (not `bash` or some other shell), because they are actually sourced.
Only `activate.sh` is not sourced in a sub-shell, so any variables defined in the install/config scripts are undefiend once they complete.

Then, any scripts with a slash in their name `<name>/<subname>` are treated as integrations.
They are run via the same method, except the scripts are found under the `upscripts/<name>/integrations/<subname>/` directory.

## Known Issues

- [ ] if an install method is missing, the error message is terrible
- [ ] there needs to be a way to compare and synchronize installed configs with the package dotfiles

- utils to manage the upscripts are missing (write these in nushell, probably)
  - [ ] check that every upscript has a (serious) readme
  - [ ] check that every upscript has appropriate sections
  - [ ] check that the upscripts pass shellcheck
  - [ ] script to extract dependencies from the section

