# Start SSH Agent for git
#
# Note: ~/.ssh/environment should not be used, as it already has a different purpose in SSH,
#       if the file `agent.env` does not exist it will be created and populated
SSH_ENV=~/.ssh/agent.env
 
agent_is_running() {
  if [ "$SSH_AUTH_SOCK" ]; then
    # ssh-add returns:
    #   0 = agent running, has keys
    #   1 = agent running, no keys
    #   2 = agent not running
    ssh-add -l > /dev/null 2>&1 || [ $? -eq 1 ]
  else
    false
  fi
}
 
agent_has_keys() {
  ssh-add -l > /dev/null 2>&1
}
 
agent_load_env() {
  . "$SSH_ENV" > /dev/null 2>&1
}
 
agent_start() {
  (umask 077; ssh-agent > "$SSH_ENV")
  . "$SSH_ENV" > /dev/null
}
 
if ! agent_is_running; then
  agent_load_env
fi
 
if ! agent_is_running; then
  agent_start
  ssh-add ~/.ssh/id_rsa
elif ! agent_has_keys; then
  ssh-add ~/.ssh/id_rsa
fi
 
unset SSH_ENV
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
setopt appendhistory autocd extendedglob nomatch complete_aliases
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# https://stegosaurusdormant.com/bare-git-repo/
alias dotgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'



export JAVA_14_HOME=$(/usr/libexec/java_home -v14)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

# PowerLevel10k configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_CUSTOM_SFDX_SETTINGS="sfdx_settings"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir custom_sfdx_settings vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)


source ~/.config/.aliases
# default to Java 11
java11

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
SFDX_AC_ZSH_SETUP_PATH=/Users/sspiegel/Library/Caches/sfdx/autocomplete/zsh_setup && test -f $SFDX_AC_ZSH_SETUP_PATH && source $SFDX_AC_ZSH_SETUP_PATH;

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
zinit light romkatv/powerlevel10k

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
