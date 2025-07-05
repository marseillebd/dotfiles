
## user

> Commands to configure my user.
> E.g. desktop environment, shell environment, editor, devtool configurations &c.

### user shell

```sh
cd via-stow
stow -v profile \
        shell \
        bash
```

### user desktop

```sh
#!/bin sh
stow -v --adopt xfce
echo >&2 '[ATTENTION] check git diff, and commit if the changes look right'
```

### user editors

```sh
cd via-stow
stow -v vim \
        vim-commentary \
        vim-easyjump \
        vim-fzf \
        vim-lsp \
        vim-sandwich \
        vim-vindent
```

### user utils

```sh
cd via-stow
stow -v fzf \
        git \
        lolcat \
        tree
```

### user rice

```sh
cd via-stow
stow -v fonts
```

## system

### system switch

> Rebuild the system after changing nix configuration

```sh
cd via-nixos
sudo nixos-rebuild -v switch --flake .
```

### system gc

TODO
