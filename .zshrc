# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stephan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug bobsoppe/zsh-ssh-agent, use:ssh-agent.zsh, from:github

zplug "djui/alias-tips"
zplug "michaelxmcbride/zsh-dircycle"
zplug "modules/command-not-found", from:prezto, defer:2
zplug "modules/history-substring-search", from:prezto, defer:2
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "urbainvaes/fzf-marks"
zplug "zuxfoucault/colored-man-pages_mod"
zplug romkatv/powerlevel10k, use:powerlevel10k.zsh-theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose


alias watch='watch ' # hack to enable alias expansion using watch
alias sl='cd ~/ledger && source ~/ledger-scripts/alias' # Start ledger

# https://stegosaurusdormant.com/bare-git-repo/
alias dotgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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
    ledger -f main.ledger --market bal budget --flat --no-total --balance-format '%A\t%T\n' -E --current | sed 's/^Assets:Budget\t.*//'|sed 's/^Assets:Budget://' |sed '/AvailableNextMonth/d'|sed '/PortlandSweetery/d'|sed '/Unbudgeted/d'| sed 's/ USD$//'
}
function reportexpenses() {
    ledger -f main.ledger --market bal expenses --period 'this month' --flat --no-total --balance-format '%A\t%T\n' -E --current | sed '/^Expenses\t.*/d' | sed 's/^Expenses:Payroll.*//' | sed '/^House:Insurance.*/d' | sed '/^Expenses:Taxes.*/d' | sed '/^Expenses:House:Insurance/d' | sed 's/ USD$//' | sed 's/Expenses://' | sed '/^$/d'
}

function find_sfdx_project_root() {
    sfdx_root=$(pwd -P 2>/dev/null || command pwd)
    while [ ! -e "$sfdx_root/.sfdx" ]; do
        sfdx_root=${sfdx_root%/*}
        if [ "$sfdx_root" = "" ]; then break; fi
    done
    echo $sfdx_root
}

function sfdx_settings() {
    globalConfig="$(cat ~/.sfdx/sfdx-config.json)";
    sfdx_root=$(find_sfdx_project_root)
    if [ ! $sfdx_root = "" ] && [ ! $sfdx_root = $HOME ]
    then
        localconfig="$(cat $sfdx_root/.sfdx/sfdx-config.json)"    
        defaultusername="$(echo ${localconfig} | jq -r .defaultusername)"
        defaultdevhubusername="$(echo ${localconfig} | jq -r .defaultdevhubusername)"
    fi
    if [ -z "$defaultusername" ] || [ "$defaultusername" = "null" ]
    then
        defaultusername="U:$(echo ${globalConfig} | jq -r .defaultusername)"
    else
        defaultusername="u:"$defaultusername
    fi
    if [ -z "$defaultdevhubusername" ] || [ "$defaultdevhubusername" = "null" ]
    then
        defaultdevhubusername="D:$(echo ${globalConfig} | jq -r .defaultdevhubusername)"
    else
        defaultdevhubusername="d:"$defaultdevhubusername
    fi
    echo "\uf0c2 "$defaultdevhubusername" "$defaultusername
}

# PowerLevel10k configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_CUSTOM_SFDX_SETTINGS="sfdx_settings"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir custom_sfdx_settings vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

alias ls='lsd -al'

# Internet radio stations
alias playoe1="mplayer http://oe1shoutcast.sf.apa.at:8000" # Oesterreich 1
alias playoe3="mplayer http://oe3shoutcast.sf.apa.at:8000" # Oesterreich 3
alias playoe2="mplayer http://oe2vshoutcast.sf.apa.at" # Radio Vorarlberg
alias playmainepublic="" # Maine Public Radio
alias playmaineclassical="" # Maine Public Classical
alias playgroovesalad="mplayer -playlist http://somafm.com/groovesalad130.pls" # Soma FM Groove Salad
alias playsecretagent="mplayer -playlist https://somafm.com/secretagent130.pls" # Soma FM Secret Agent
alias playfolk="mplayer -playlist https://somafm.com/folkfwd130.pls" # Soma FM Folk Forward
alias playdubstep="mplayer -playlist https://somafm.com/dubstep130.pls" # Soma FM Dub Step Beyond
alias playspace="mplayer -playlist https://somafm.com/spacestation130.pls" # Soma FM Space Station Soma
alias playdefcon="mplayer -playlist https://somafm.com/defcon130.pls" # Soma FM DEF CON Radio

export EDITOR=vim
export NVIM_GTK_NO_HEADERBAR=1
export NVIM_GTK_NO_WINDOW_DECORATION=1
PATH="/home/stephan/.gem/ruby/2.6.0/bin":$PATH
PATH="/home/stephan/.local/bin":$PATH

eval $(thefuck --alias oops)

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

PATH="/home/stephan/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/stephan/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/stephan/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/stephan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/stephan/perl5"; export PERL_MM_OPT;
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
