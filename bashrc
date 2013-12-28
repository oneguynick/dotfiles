#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vi="vim"
alias nano="nano -w"
alias diff='colordiff'
alias ll="ls --color -lh"
alias la="ls --color -a"
alias pacs="pacsearch"
alias yaourt-upgrade="yaourt -Sbu --aur"
alias boxsync="unison -ui text box"
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias dmesg='dmesg -HL'
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias google-earth=' while ! google-earth; do echo RESTARTING; done'

alias vpnus='/usr/bin/openvpn /etc/openvpn/us-east.ovpn'
alias vpnnl='/usr/bin/openvpn /etc/openvpn/netherlands.ovpn'

# Privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
    alias update='sudo pacman -Su'
    alias netctl='sudo netctl'
fi

# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rs \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

calc() {
    echo "scale=3;$@" | bc -l
}

# Extract all things!
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c='bsdtar xvf';;
            *.7z)  c='7z x';;
            *.Z)   c='uncompress';;
            *.bz2) c='bunzip2';;
            *.exe) c='cabextract';;
            *.gz)  c='gunzip';;
            *.rar) c='unrar x';;
            *.xz)  c='unxz';;
            *.zip) c='unzip';;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}

# Pidgin Lync Fix
export NSS_SSL_CBC_RANDOM_IV=0

# Wine improvements
export WINEDEBUG=-all

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# auto CD when entering just a path
shopt -s autocd

# Oracle Font Fix
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
export JAVA_FONTS=/usr/share/fonts/TTF

PATH=$(cope_path):$PATH:/opt/android-sdk/platform-tools:/home/nickers/.bin:/usr/lib/ccache/bin/

PS1="\[\e[1m\][\h:\w] \u\[\e[31;1m\]%\[\e[0m\] "
