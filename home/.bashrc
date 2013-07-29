# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# this used to be necessary due to some bugs for japanese input support
#export LANG="ja_JP.UTF-8"
#export LC_ALL="ja_JP.UTF-8"

export LANGUAGE=en

export G_FILENAME_ENCODING="UTF8"

# this is old stuff I used to need running startx/xfce by hand
#export GTK_IM_MODULE="scim"
#export XIM_PROGRAM="scim -d"
#export XMODIFIERS="@im=scim"

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

# plenty of terminals say they are xterm but aren't;  attempt to see if we're
# using a terminal which supports 256 color and set TERM to ~256color if we are
if [ "$TERM" = "xterm" ]; then
    if [ -z "$COLORTERM" ]; then
        case "$XTERM_VERSION" in
            "XTerm(256)") TERM="xterm=256color" ;;
            "XTerm(88)") TERM="xterm-88color" ;;
            "XTerm") ;;
            *)
                echo "Unrecognized XTERM_VERSION: $XTERM_VERSION"
                ;;
        esac
    else
        case "$COLORTERM" in
            gnome-terminal)
                # identify as xterm-256color because too many things don't know gnome-256color
                TERM="xterm-256color"
                ;;
            *)
                echo "Unrecognized COLORTERM: $COLORTERM"
                ;;
        esac
    fi
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

case $(uname) in
    Darwin)
        OS="OSX"
        ;;
    *)
        OS="Linux"
        ;;
esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\t\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if [ "$OS" != "OSX" ]; then
        [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
        [ -e "$DIR_COLORS" ] || DIR_COLORS=""
        eval "`dircolors -b $DIR_COLORS`"
        alias ls='ls --color=auto -F'
    else
        alias ls="ls -GF"
    fi
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

if [ -d $HOME/.pythonbrew ]; then
    source $HOME/.pythonbrew/etc/bashrc
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -d ~/.bash_completion.d ]; then
    for i in ~/.bash_completion.d/*; do
        . $i
    done
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
    $VC diff $* |gvim - 
}

function ssh_export {
    # export the current machine's id_rsa to foreign server in $1
    cat ~/.ssh/id_rsa.pub | ssh "$1" "cat - >> ~/.ssh/authorized_keys"
}

# add some crap to the path
export PATH=$PATH:/opt/bin/:$HOME/.local/bin:$GOROOT/bin
export PATH=$PATH:$HOME/.gem/ruby/1.8/bin
export PATH=$PATH:$HOME/devel/android/eclipse
export PATH=$PATH:$GOROOT/pkg/tool/linux_amd64/
export PATH=$PATH:$HOME/godevel/lib/bin

# add homebrew python path in OSX
if [ "$OS" = "OSX" ]; then
    export PATH="/usr/local/Cellar/python/2.7.1/bin:$PATH"
    export PATH="/usr/local/share/python/:$PATH"
    export PATH="`brew --prefix`/bin:$PATH"
    export PATH="$PATH:/usr/local/sbin"
else
    alias open="xdg-open"
fi

export EDITOR=vim

# virtualenv & python setup
export WORKON_HOME=$HOME/.ve
export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME"
source $HOME/.ve/virtualenvwrapper_bashrc
export PIP_RESPECT_VIRTUALENV=true

alias hgcd="hg diff |pygmentize -ldiff"
alias svncd="svn diff |pygmentize -ldiff"

export NODE_PATH="/usr/local/lib/node"

export BLOCKSIZE=1024

WINEARCH=win32
WINEPREFIX=~/.wine

# go development
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
gvm use go1.1.1 > /dev/null

# configuration management
export CM_CONFIG_PATH="$HOME/dotfiles/home"
export CM_UNSAFE_SYNC=true
export CM_CONFIG_ROOT="$HOME"

