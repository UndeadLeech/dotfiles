# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/
# Enbale 256 color mode
export TERM=konsole-256color


#####################
##### POWERLINE #####
#####################

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon background_jobs virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_HOME_ICON=""
POWERLEVEL9K_FOLDER_ICON=""
POWERLEVEL9K_HOME_SUB_ICON=""
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=""
POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=" "

shorten_username() {
    if [[ "$USER" == "root" ]]; then; echo "R"; else; echo "UL"; fi
}
POWERLEVEL9K_LINUX_ICON=$(shorten_username)
POWERLEVEL9K_OS_ICON_BACKGROUND="009"
POWERLEVEL9K_OS_ICON_FOREGROUND="000"

POWERLEVEL9K_VCS_CLEAN_BACKGROUND="002"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="000"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="009"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="000"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="004"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="000"

POWERLEVEL9K_VIRTUALENV_BACKGROUND="008"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="007"

POWERLEVEL9K_DIR_HOME_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="008"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="008"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"

POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="008"
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="007"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

####################
##### ENVSTUFF #####
####################

# Use vim for ssh instead of nvim
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
export VISUAL="nvim"

# Rust stuff
export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH
export RLS_ROOT=$HOME/.cargo/bin/rls
export LD_LIBRARY_PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib
export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# Set histfile
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000

# Set cd and ls folder colors
export LS_COLORS='ow=36:di=34:fi=32:ex=31:ln=35:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:*' menu yes select

# Colorized Manpages
man() {
    env \
        LESS_TERMCAP_md=$'\e[32m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[100;37m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[34m' \
            man "$@"
}


######################
##### ALIASSTUFF #####
######################

alias sudo="sudo "
alias vim="nvim"
alias gp="git remote | xargs -L1 git push --all"

# Automatic suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
