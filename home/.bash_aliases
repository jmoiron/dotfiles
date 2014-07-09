# vim: set filetype=sh:

# ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# old bt aliases
#alias btdl='btdownloadcurses --max_upload_rate 3 --minport 6000'
#alias btdlfast='btdownloadcurses --minport 11000'

# auto-sudo aliases 
alias apt-get='sudo apt-get'
alias dpkg='sudo dpkg'
alias modprobe='sudo modprobe'

# mplayer helpers, mostly for ac3 volume correction
alias mplayer-ac3='mplayer -af volume=25'
alias mplayer-15='mplayer -af volume=15'

# django/development aliases
alias dsh='python manage.py shell'
alias dbsh='python manage.py dbshell'
alias rs='python manage.py runserver 0.0.0.0:8000'
alias ds='python manage.py runserver_plus 0.0.0.0:8000'
alias dt='python manage.py test'
alias mpy='python manage.py'

# fix gvim issues in ubuntu 9.10
alias gvim='gvim 2>/dev/null'

# 'serve' simple webserver
alias serve='python -m SimpleHTTPServer'

# chrome shortcut
alias chrome="google-chrome"

if [ "$OS" == "OSX" ]; then
    alias gvim="/Applications/MacVim.app/Contents/MacOS/Vim -g"
    alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

alias t="t --task-dir ~/tasks --list tasks"

function go-link {
    version=`go version |cut -d" " -f 3`
    name=`basename $1`
    dirpath=`dirname $1`/$name
    pkg_path="$HOME/.gvm/pkgsets/$version/global/src/github.com/jmoiron"
    mkdir -p $pkg_path
    if [ -d "$pkg_path/$name" ]; then
        rm -rf $pkg_path/$name
    fi
    if [ -h "$pkg_path/$name" ]; then
        rm $pkg_path/$name
    fi
    ln -s $dirpath $pkg_path/
}

