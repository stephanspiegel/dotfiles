# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000

setopt autocd
setopt complete_aliases
setopt correct_all # autocorrect commands
setopt extendedglob
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history
setopt nomatch
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
unsetopt beep

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stephan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

alias watch='watch --color ' # hack to enable alias expansion using watch


function startledger() {
    if ! grep -qs '/home/stephan/ledger ' /proc/mounts; then
        cryfs /home/stephan/Dropbox/ledger/ /home/stephan/ledger
    fi
    cd /home/stephan/ledger/personal
    source /home/stephan/ledger-scripts/alias
}

function killledger() {
    fusermount -u "/home/stephan/ledger"
}

function reportbudget() {
    join -e 0 -a 1 -o auto -t $'\t' <(reportUsedBudget) <(reportInitialBudget) | xclip -selection clipboard
    echo Report copied to clipboard.
}

function reportUsedBudget(){
    firstDayOfNextMonth=$(date -d "`date +%Y%m01` +1 month" +%Y-%m-%d)
    ledger -f main.ledger --market balance budget --flat --no-total --balance-format '%A\t%T\n' --empty --end $firstDayOfNextMonth | sed 's/^Assets:Budget\t.*//'|sed 's/^Assets:Budget://' |sed '/AvailableNextMonth/d'|sed '/PortlandSweetery/d'|sed '/Unbudgeted/d'| sed 's/ USD$//' | sed 's/://' | sort
}

function reportInitialBudget(){
    firstDayOfCurrentMonth=$(date -d "`date +%Y%m01`" +%Y-%m-%d)
    secondDayOfCurrentMonth=$(date -d "`date +%Y%m02`" +%Y-%m-%d)
    ledger -f main.ledger --market register --limit 'payee=~/Monthly Budget/' --flat --no-total --register-format '%A\t%t\n' --empty --begin $firstDayOfCurrentMonth --end $secondDayOfCurrentMonth | sed 's/^Assets:Budget\t.*//'|sed 's/^Assets:Budget://' |sed '/AvailableNextMonth/d'|sed '/PortlandSweetery/d'|sed '/Unbudgeted/d'| sed 's/ USD$//' | sed 's/://' | sort
}

function find_sfdx_project_root() {
    sfdx_root=$(pwd -P 2>/dev/null || command pwd)
    while [ ! -e "$sfdx_root/.sfdx" ]; do
        sfdx_root=${sfdx_root%/*}
        if [ "$sfdx_root" = "" ]; then break; fi
    done
    echo $sfdx_root
}

function prompt_sfdx() {
    globalConfig="$(cat ~/.sfdx/sfdx-config.json)";
    sfdx_root=$(find_sfdx_project_root)
    if [ ! $sfdx_root = "" ] && [ ! $sfdx_root = $HOME ]
    then
        localconfig="$(cat $sfdx_root/.sfdx/sfdx-config.json)"    
        defaultusername="u:%B$(echo ${localconfig} | jq -r .defaultusername)%b"
        defaultdevhubusername="d:$(echo ${localconfig} | jq -r .defaultdevhubusername)"
    fi
    if [ -z "$defaultusername" ] || [ "$defaultusername" = "null" ]
    then
        defaultusername="U:%B$(echo ${globalConfig} | jq -r .defaultusername)%b"
    fi
    if [ -z "$defaultdevhubusername" ] || [ "$defaultdevhubusername" = "null" ]
    then
        defaultdevhubusername="D:$(echo ${globalConfig} | jq -r .defaultdevhubusername)"
    fi
    p10k segment -i '' -b white -f blue -t "$defaultdevhubusername $defaultusername"
}
alias ls='lsd -al'

# Internet radio stations
alias playoe1="mplayer 'https://orf-live.ors-shoutcast.at/oe1-q2a' -cache 4096" # Oesterreich 1
alias playoe3="mplayer 'https://orf-live.ors-shoutcast.at/oe3-q2a' -cache 4096" # Oesterreich 3
alias playoe2="mplayer 'https://orf-live.ors-shoutcast.at/vbg-q2a' -cache 4096" # Radio Vorarlberg

alias playmainepublic="" # Maine Public Radio
alias playmaineclassical="" # Maine Public Classical
alias playgroovesalad="mplayer -playlist http://somafm.com/groovesalad130.pls" # Soma FM Groove Salad
alias playsecretagent="mplayer -playlist https://somafm.com/secretagent130.pls" # Soma FM Secret Agent
alias playfolk="mplayer -playlist https://somafm.com/folkfwd130.pls" # Soma FM Folk Forward
alias playdubstep="mplayer -playlist https://somafm.com/dubstep130.pls" # Soma FM Dub Step Beyond
alias playspace="mplayer -playlist https://somafm.com/spacestation130.pls" # Soma FM Space Station Soma
alias playdefcon="mplayer -playlist https://somafm.com/defcon130.pls" # Soma FM DEF CON Radio

export EDITOR=vim
bindkey -v
# sfdx autocomplete setup
SFDX_AC_ZSH_SETUP_PATH=/home/stephan/.cache/sfdx/autocomplete/zsh_setup && test -f $SFDX_AC_ZSH_SETUP_PATH && source $SFDX_AC_ZSH_SETUP_PATH;

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1

# zplug "modules/history-substring-search", from:prezto, defer:2

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light djui/alias-tips
zinit light urbainvaes/fzf-marks
zinit light zuxfoucault/colored-man-pages_mod
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit light Aloxaf/fzf-tab
zinit light aperezdc/zsh-fzy
bindkey '^R'  fzy-history-widget
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
