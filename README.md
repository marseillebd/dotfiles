I have not been able to set up a CI system, which is unfortunate.
The problems are:
- each upscript needs to run its own test(s), so they each needs their own dockerfile(s)
- each upscript may have dependencies (git, curl, wget) which are most easily installed from root (or sudo)

What I have instead is a top-level dockerfile for developement.
It is based on the ubuntu distro I currently have on this computer.
The root user installs some commands as dependencies; change these to be minimal so that you can see what your script actually needs.
Once that edit is made, run it with the following, and try to use the upscript.
```
upup.sh profiles/testing && docker build --tag tmp-dotfiles-ubuntu2004 . && docker run --rm -it tmp-dotfiles-ubuntu2004
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
- [x] script (nushell) that combines several upscripts into a single upscript

# How does it work?

There's the `upup.sh` script, which combines scripts from a profile.
TODO: I think it'd be just as easy (if not better) to jsut have upup interpret the profile rather than compile it.
The profile just lists upscripts of the form `<name>-<method>`, and reference `upscripts/<name>/<name>-<method>.sh`.
All upscripts should run under `sh` (not `bash` or some other shell).
The combined script will go through each one in order and
- run it's upscript
- run its `config.sh`
- run its `activate.sh`
All that happens in a subshell so the variables don't leak (between scripts or to the user's shell).
The one exception is the `activate.sh` scripts, whose actions are visible to later scripts,
and will also be run in the top-level shell at the end of installation...? FIXME or does it? I prolly need to go back to a separate activate script.

There's a special `uputils` upscript which defines some useful functions and variables.
It is recommended to define a function here rather than try to template install scripts.
All definitions in `uputils/activate.sh` wills tart with `UPUP_`.
There's one upscript, `sh` which should likely run before `uputils`, since `sh` sets xdg base dir variables that `uputils` then uses.
