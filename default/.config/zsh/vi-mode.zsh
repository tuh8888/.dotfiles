bindkey -v
# Don't prevent me from editing text I entered before going into command mode
zle -A kill-whole-line vi-kill-line
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char

visual-mode-eol () {
    zle visual-mode;
    CURSOR=${#BUFFER};
}

zle -N visual-mode-eol

#todo: find a good binding for spell-word
#todo: find a good binding for quote-region
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^K'    insert-last-word
bindkey -M viins '^a'    beginning-of-line
bindkey -M viins '^[[H'  beginning-of-line
bindkey -M viins '^e'    end-of-line
bindkey -M viins '^[[F'  end-of-line
bindkey -M vicmd 'gg'    beginning-of-buffer-or-history
bindkey -M vicmd 'g~'    vi-oper-swap-case
bindkey -M vicmd 'G'     end-of-buffer-or-history
bindkey -M vicmd 'Y'     vi-yank-eol
bindkey -M vicmd 'vv'    visual-line-mode
bindkey -M vicmd 'V'     visual-mode-eol
bindkey -M vicmd 'u'     undo
bindkey -M vicmd 'U'     redo
bindkey -M vicmd 'H'     run-help
# ^[[3~ is the "del" key
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char
# ^[[Z is Shift-Tab
bindkey -M viins '^[[Z'  reverse-menu-complete
# Quotes/brackets text objects
autoload -U select-bracketed
autoload -U select-quoted
zle -N select-bracketed
zle -N select-quoted
for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;-=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..):-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done
