# The following lines were added by compinstall

# key bindings
# entf
bindkey "\e[3~" delete-char
# einfg/insrt
bindkey "\e[2~" insert-mode 
# Ctrl+r stays history search!
bindkey '^R' history-incremental-search-backward
#vim mode pleaseeee
bindkey -v

#complete the "/" in dirs

case "$TERM" in
        linux|screen)
                bindkey "^[[1~" beginning-of-line       # Pos1
                bindkey "^[[4~" end-of-line             # End
        ;;
        *xterm*|(dt|k)term)
                bindkey "^[[H"  beginning-of-line       # Pos1
                bindkey "^[[F"  end-of-line             # End
                bindkey "^[[7~" beginning-of-line       # Pos1
                bindkey "^[[8~" end-of-line             # End
        ;;
        rxvt|Eterm)
                bindkey "^[[7~" beginning-of-line       # Pos1
                bindkey "^[[8~" end-of-line             # End
        ;;
esac

setopt INC_APPEND_HISTORY
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle :compinstall filename '/home/bahmrockk/.zshrc'

autoload -U compinit zcalc promptinit
compinit
promptinit
prompt adam2 blue blue blue white


# End of lines added by compinstall
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#one history
setopt appendhistory 

#[dir] as [cd dir]
setopt autocd 

#pushd instead of cd, use popd to go back to the folder you came from
setopt AUTO_PUSHD
alias cdb=popd

setopt extendedglob 

setopt notify

unsetopt beep 
#setopt beep
#
set editing-mode vi
set blink-matching-paren on


alias ls='ls --color=auto --group-directories-first'
alias sl='ls --color=auto --group-directories-first'
alias la='ls --color=auto -la --group-directories-first'
alias vi='vim'

ColorCursor=#0f0f49499999
ColorForeground=#838394949696
ColorBackground=#00002b2b3636
ColorPalette1=#070736364242
ColorPalette2=#dcdc32322f2f
ColorPalette3=#858599990000
ColorPalette4=#b5b589890000
ColorPalette5=#26268b8bd2d2
ColorPalette6=#d3d336368282
ColorPalette7=#2a2aa1a19898
ColorPalette8=#eeeee8e8d5d5
ColorPalette9=#00002b2b3636
ColorPalette10=#cbcb4b4b1616
ColorPalette11=#58586e6e7575
ColorPalette12=#65657b7b8383
ColorPalette13=#838394949696
ColorPalette14=#6c6c7171c4c4
ColorPalette15=#9393a1a1a1a1
ColorPalette16=#fdfdf6f6e3e3
Term=xterm-color

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

# prepend_colon(val, var)
prepend_colon() {
  if [ -z "$2" ]; then
    echo $1
  else
    echo $1:$2
  fi
}

# unshift_path(path)
unshift_path() {
  if [ -d $1/sbin ]; then
    export PATH=$(prepend_colon "$1/sbin" $PATH)
  fi
  if [ -d $1/bin ]; then
    export PATH=$(prepend_colon "$1/bin" $PATH)
  fi

  if [ -d $1/share/man ]; then
    export MANPATH=$(prepend_colon "$1/share/man" $MANPATH)
  fi
}

# TABULA RASA
export PATH=""
export MANPATH=""

unshift_path "/usr/X11"
unshift_path ""
unshift_path "/usr"
unshift_path "/usr/local"
unshift_path "/opt/local"
unshift_path "$HOME/local"
unshift_path "$HOME/etc"

export PATH=$(prepend_colon ".local" $PATH)
export PATH=~/.cabal/bin:$PATH

[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh
