# Color PS1
export KEYTIMEOUT=20
export _PS1="$PS1"

set_insert_colors() {
    if [[ $__prompt_status == 0 ]]; then
        PS1="[44m[34m$_PS1[0m"
    else
        PS1="[41m[31m$_PS1[0m"
    fi
    print -n -- "\033[6 q"
}

zle-keymap-select() {
    if [[ "$KEYMAP" = "vicmd" ]] ; then
        # Green, block cursor
        PS1="[42m[32m$_PS1[0m"
        print -n -- "\033[2 q"
    else
        set_insert_colors
    fi
    zle reset-prompt
}

if [[ ! -v precmd_functions ]]; then
    precmd_functions=()
fi
precmd_setup_colors() {
    typeset -g __prompt_status="$?"
    set_insert_colors
}
precmd_functions+=precmd_setup_colors

zle -N zle-keymap-select
