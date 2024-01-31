I have not been able to set up a CI system, which is unfortunate.
The problems are:
- each upscript needs to run its own test(s), so they each needs their own dockerfile(s)
- each upscript may have dependencies (git, curl, wget) which are most easily installed from root (or sudo)

What I have instead is a top-level dockerfile for developement.
It is based on the ubuntu distro I currently have on this computer.
The root user installs some commands as dependencies; change these to be minimal so that you can see what your script actually needs.
Once that edit is made, run it with the following, and try to use the upscript.
```
upup.sh profiles/testing && docker build --tag tmp . && docker run --rm -it tmp
```

Here's a nice way to run specific setup scripts:
```
./upup.sh <(echo somePkg)
```

# Upscripts

Upscripts are stored under the `upscripts/` directory.
Each one should go in its own folder.
This allows for more than one method of installation.
It also makes for a good place to put other information, such as documentation.

- `upscripts/`
  - `foo/`
    - `README.md`
    - `foo-user.sh`
    - `foo-system.sh`
    - `integrations`
      - `bash/` same structure as an upscript dir
      - `other-util/`
    - `dotfiles`
      - 'foorc'

- utils to manage the upscripts, in nushell
  - [ ] check that every upscript has a (serious) readme
  - [ ] check that every upscript has appropriate sections
  - [ ] check that the upscripts pass shellcheck
  - [ ] script to extract dependencies from the section

# How does it work?

There's the `upup.sh` script, which combines scripts from a profile.
It first defines a few variables and utility functions that can be used in the scripts it invokes:
- `UPUP_BINDIR`: for executables (scripts and binaries) which should go in the `PATH`, is `${HOME}/.local/bin`
- `UPUP_CONFIGDIR`: for configuration files, is `${XDG_CONFIG_HOME:-${HOME}/.config}`
- `UPUP_BUILDDIR`: for intermediate files like source code (though they may stick around), is `${HOME}/.local/.build`
- `UPUP_ln`: like `ln`, but sets flags for backups and whatnot
- `UPUP_sudo`: tries to install via the system's package manager
It then scans the lines of a "profile" file, which just lists upscripts you want installed.

First it runs thouse matching `<name>(-<method>)?` by:
- running `upscripts/<name>/<name>-<method>.sh`
- running `upscripts/<name>/config.sh`, if it exists
- running `upscripts/<name>/activate.sh`, if it exists
All upscripts should run under `sh` (not `bash` or some other shell), because they are actually sourced.
Only `activate.sh` is not sourced in a sub-shell, so any variables defined in the install/config scripts are undefiend once they complete.

Then, any scripts with a slash in their name `<name>/<subname>` are treated as integrations.
They are run via the same method, except the scripts are found under the `upscripts/<name>/integrations/<subname>/` directory.
