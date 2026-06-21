# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Cache completions aggressively
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# User configuration

export EDITOR=nvim

export MONGOHOUSE_SETENV_ENABLED=1
export MONGOHOUSE_SETENV_SSO_PROFILE=adfa-dev

export ARGO_SERVER='argo-workflows.corp.mongodb.com:443'
export ARGO_HTTP1=true
export ARGO_SECURE=true
export ARGO_BASE_HREF=
export ARGO_NAMESPACE=argo-workflows-executions-mongohouse-mgmt

export KUBECONFIG="/Users/ron.sanzone/code/kube-resources/.kube/config:/Users/ron.sanzone/.kube/config"
export PATH="${PATH}:${KREW_ROOT:-$HOME/.krew}/bin"

export PATH="$HOME/bin:$PATH"
export PATH="/Users/ron.sanzone/.local/bin:$PATH"

export ASDF_DATA_DIR=/Users/ron.sanzone/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"

export ZK_NOTEBOOK_DIR=~/notes/sanzoner-mongodb-notes/

export PATH="$PATH:/Users/ron.sanzone/code/dotfiles/bin"

export PATH="$PATH:/Users/ron.sanzone/code/mongohouse/artifacts/mongod-versions/7.2.0/mongodb-macos-aarch64-enterprise-7.2.0/bin"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#eval "$(oh-my-posh init zsh)"
alias zc="nvim ~/.zshrc"
alias set-custom-agent="python3 $MMS_HOME/server/scripts/nds/set_custom_agent.py"

eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/pure.omp.json)"
#eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/mojave.omp.json)"

export PATH="$PATH:$(go env GOPATH)/bin"


source "$HOME/code/mongo-pi-extensions/sandbox-exec/shell-snippet.zsh"

## MongoDB related functions and aliases

#export ANTHROPIC_DEFAULT_OPUS_MODEL="global.anthropic.claude-opus-4-5-20251101-v1:0"
##export ANTHROPIC_DEFAULT_OPUS_MODEL="us.anthropic.claude-opus-4-1-20250805-v1:0"
#export ANTHROPIC_DEFAULT_HAIKU_MODEL="us.anthropic.claude-3-5-haiku-20241022-v1:0"
##export ANTHROPIC_DEFAULT_SONNET_MODEL="global.anthropic.claude-sonnet-4-5-20250929-v1:0"
#export ANTHROPIC_DEFAULT_SONNET_MODEL="us.anthropic.claude-sonnet-4-5-20250929-v1:0"
#export CLAUDE_CODE_SUBAGENT_MODEL="us.anthropic.claude-sonnet-4-5-20250929-v1:0"
#unset ANTHROPIC_MODEL
#export ANTHROPIC_MODEL="global.anthropic.claude-opus-4-5-20251101-v1:0"

alias tt='bunx toktrack'
alias ccusage='bunx ccusage@latest'

## Mongohouse functions and aliases 

mhtp() {
	echo "Running mhouse tests under path $1"
 	go run ./cmd/buildscript/build.go test:unit -pkg=$1/...
}

c45() {
	ANTHROPIC_DEFAULT_OPUS_MODEL=claude-opus-4-5-20251101 claude --model claude-opus-4-5-20251101 $1
}


fpath[1,0]=$HOME/.zsh/completion

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "/Users/ron.sanzone"/.zsh/cache
# . /Users/ron.sanzone/.asdf/asdf.sh
. /Users/ron.sanzone/.asdf/plugins/java/set-java-home.zsh

source  ~/.config/.jira/.env

# Source secrets file (gitignored)
[[ -f ~/.zshrc.secrets ]] && source ~/.zshrc.secrets
export MONGOHOUSE_GCP_ENABLED=true
export GOPRIVATE=github.com/10gen/*

export CM_ROOT=/Users/ron.sanzone/code/mms-automation/go_planner
export GOROOT=$(brew --prefix golang)/libexec

# export GOPATH=$CM_ROOT  # was causing mongohouse lint to fail; use default ~/go

# bun completions
[ -s "/Users/ron.sanzone/.bun/_bun" ] && source "/Users/ron.sanzone/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/Users/ron.sanzone/.opencode/bin:$PATH

ulimit -n 61440 61440
ulimit -f unlimited


# Pi
export PATH="/Users/ron.sanzone/.asdf/installs/nodejs/22.11.0/bin:$PATH"
alias kanopy-oidc=/Applications/kanopy-oidc-macos-arm64-v0.5.5

# herdr
export PATH="/Users/sanzoner/.local/bin:$PATH"

# opencode
export PATH=/Users/sanzoner/.opencode/bin:$PATH
