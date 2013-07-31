These are my dotfiles.

Git keeps track of them and serves as a centralized point for distribution,
but the day to day maintenance is done with [cm](http://github.com/jmoiron/cm),
which is provided as a static binary for both amd64 Linux and OSX in `bin`.

The basic bootstrap process is:

```bash
git clone git@github.com:jmoiron/dotfiles.git ~/dotfiles`
alias cm="~/dotfiles/bin/cm"
export CM_CONFIG_PATH="$HOME/dotfiles/home"
export CM_CONFIG_ROOT="$HOME"
cm pull
```

Although cm is meant to be a general purpose tool which can store simple system
configuration, it is particularly well suited to this task of dotfile
maintenance and distribution.

