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

echo $TERM > ~/test
case "$TERM" in
        (linux|screen)
                bindkey "^[[1~" beginning-of-line       # Pos1
                bindkey "^[[4~" end-of-line             # End
                echo "2" > ~/test
        ;;
        (*xterm*|(dt|k)term)
                bindkey "^[[H"  beginning-of-line       # Pos1
                bindkey "^[[F"  end-of-line             # End
                bindkey "^[[7~" beginning-of-line       # Pos1
                bindkey "^[[8~" end-of-line             # End
                echo "1" > ~/test 
        ;;
        (rxvt|Eterm)
                bindkey "^[[7~" beginning-of-line       # Pos1
                bindkey "^[[8~" end-of-line             # End
                echo "3" > ~/test
        ;;
esac

# http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
#defaults
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

zstyle ':completion:*' menu select completer _complete _ignored _correct _approximate rehash true list-colors ""
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

setopt INC_APPEND_HISTORY
#one history

#[dir] as [cd dir]
setopt autocd 

#pushd instead of cd, use popd to go back to the folder you came from
setopt AUTO_PUSHD
alias cdb=popd

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
      dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
        [[ -d $dirstack[1] ]] && cd $dirstack[1]
    fi
    chpwd() {
          print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
      }

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups

### This reverts the +/- operators.
setopt pushdminus

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

cowfortune
export EDITOR="vim"
