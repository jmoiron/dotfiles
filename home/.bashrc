# ~/.bashrc: executed by bash(1) for non-login shells.

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export LANGUAGE=en
export G_FILENAME_ENCODING="UTF8"

# plenty of terminals say they are xterm but aren't;  attempt to see if we're
# using a terminal which supports 256 color and set TERM to ~256color if we are
if [ "$TERM" = "xterm" ]; then
    if [ -z "$COLORTERM" ]; then
        case "$XTERM_VERSION" in
            "XTerm(256)") TERM="xterm=256color" ;;
            "XTerm(88)") TERM="xterm-88color" ;;
            "XTerm") ;;
            "") ;;
            *)
                echo "Unrecognized XTERM_VERSION: $XTERM_VERSION"
                ;;
        esac
    else
        case "$COLORTERM" in
            "mate-terminal") TERM="xterm-256color" ;;
            "gnome-terminal") TERM="xterm-256color" ;;
            *)
                echo "Unrecognized COLORTERM: $COLORTERM"
                ;;
        esac
    fi
fi

# save our current operating system in the OS variable for quick use elsewhere
case $(uname) in
    Darwin)
        OS="OSX"
        ;;
    *)
        OS="Linux"
        ;;
esac

# add some crap to the path;  some things in ~/.local/bin may be used for PS1
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.gem/ruby/1.8/bin

# add homebrew python path in OSX
if [ "$OS" = "OSX" ]; then
    source $HOME/.bashrc.osx
else
    alias open="xdg-open"
fi


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# HH:MM:SS user@hostname:path$
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\t\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\t\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]$(pctilde $(pwd))\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '



# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if [ "$OS" != "OSX" ]; then
        [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
        [ -e "$DIR_COLORS" ] || DIR_COLORS=""
        eval "`dircolors -b $DIR_COLORS`"
        alias ls='ls --color=auto -F'
    fi
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features 
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# if we're using brew's newer installed bash completion script, it unsets
# "have" but installs a ton of symlinks to ~/.bash_completion.  Since it
# handles sourcing ~/bash_completion.d/* then we just sidestep it on osx.
if [ -n "$(which brew)" ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
    if [ -d $(brew --prefix)/etc/bash_completion.d/ ]; then
        for i in $(brew --prefix)/etc/bash_completion.d/*; do
            source "$i"
        done
    fi
else
    if [ -d ~/.bash_completion.d ]; then
        for i in ~/.bash_completion.d/*; do
            source $i
        done
    fi
fi

# git junk
function follow {
    git config --add branch.$1.remote origin
    git config --add branch.$1.merge refs/heads/$1
}

function gcp {
    git commit -am "$@" && git push
}

function gup {
    current=$(git branch |grep '*' |awk '{print $2}')
    git co $1 && git pull && git co $current
}

function gci {
    git pull --rebase && git push
}

function md5 {
    md5sum $1 |cut -f1 -d' '
    return $?
}

function github-clone() {
    git clone git@github.com:jmoiron/$1
}

function vd { 
    git diff $* |gvim - 
}

function ssh_export {
    # export the current machine's id_rsa to foreign server in $1
    cat ~/.ssh/id_rsa.pub | ssh "$1" "cat - >> ~/.ssh/authorized_keys"
}

export EDITOR=vim

# virtualenv & python setup
export WORKON_HOME=$HOME/.ve
export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME"
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
export PIP_RESPECT_VIRTUALENV=true

if [ -d $HOME/.pythonbrew ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi


# colorize diff aliases for hg and svn
alias hgcd="hg diff |pygmentize -ldiff"
alias svncd="svn diff |pygmentize -ldiff"

# miscellaneous rubbish
export NODE_PATH="/usr/local/lib/node"
export BLOCKSIZE=1024
WINEARCH=win32
WINEPREFIX=~/.wine


# configuration management
export CM_CONFIG_PATH="$HOME/dotfiles/home"
export CM_UNSAFE_SYNC=true
export CM_CONFIG_ROOT="$HOME"
alias cm="~/dotfiles/bin/cm"
function cmup {
    pushd ~/dotfiles > /dev/null
    git pull
    popd > /dev/null
}

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

ns() {
    python -c "import humanize; print humanize.naturalsize($1)"
}

pathclean() {
    export PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
}

eval "$(gimme 1.8.3)"
export PATH=$GOPATH/bin:$PATH
pathclean

