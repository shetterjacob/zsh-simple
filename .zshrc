# .zshrc
# Enable Powerlevel 10k instant prompt. Only code that requires console input should go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.CACHE}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.CACHE}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DEFAULT_USER=$USER

# set zsh theme
ZSH_THEME="cloud"

# set zsh options
set extended_glob

# setup vars similar to oh-my-zsh
ZSH=${ZSH:-${ZDOTDIR:-$HOME/.config/zsh}}
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}

# use antidote.lite - a zsh micro plugin manager based on zsdh_unplugged
if [[ ! -e $ZSH_CUSTOM/antidote.lite/antidote.zsh ]]; then
  mkdir -p $ZSH/lib
  curl -fsSL -o $ZSH/lib/antidote.zsh \
  https://raw.githubusercontent.com/mattmc3/zsh_unplugged/main/antidote.lite.zsh
fi

# load any files in your lib directory
for zlib in $ZSH/lib/*.zsh(N); source $zlib
unset zlib

# util (path) plugins
myutils=(
  romkatv/zsh-bench
)

# prompt (fpath) plugins
myprompts=(
  sindresorhus/pure
  romkatv/powerlevel10k
)

# regular zsh plugins
myplugins=(

  # core plugins
  mattmc3/zephyr/plugins/color
  mattmc3/zephyr/plugins/directory
  mattmc3/zephyr/plugins/editor
  mattmc3/zephyr/plugins/environment
  mattmc3/zephyr/plugins/history
  mattmc3/zephyr/plugins/prompt
  mattmc3/zephyr/plugins/utility

  # oh-my-zsh plugins
  ohmyzsh/ohmyzsh/lib/clipboard.zsh
  ohmyzsh/ohmyzsh/plugins/colored-man-pages
  ohmyzsh/ohmyzsh/plugins/magic-enter
  
  #completion plugins
  zsh-users/zsh-completions
  mattmc3/zephyr/plugins/completion

  #fish like plugins
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search

)

# set up history
HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
export HISTTIMEFORMAT="%d/%m/%Y %H:%M] "

# clone and load plugins
plugin-clone $myplugins $myprompts $myutils
plugin-load --kind path $myutils
plugin-load --kind fpath $myprompts
plugin-load $myplugins

# pick your prompt (pure/powerlevel10k/starship)
autoload -Uz promptinit
promptinit
prompt powerlevel10k

# to customize prompt run "p10k configure" or edit $HOME/.zsh/.p10k.zsh
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# set default editor
export EDITOR='vim'
export VISUAL='vim'
