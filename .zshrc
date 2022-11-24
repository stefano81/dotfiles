# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded
#ZSH_THEME="robbyrussell"
#ZSH_THEME="stefano"
#ZSH_THEME="fox"
ZSH_THEME="kphoen" # my default
#ZSH_THEME="agnoster"
#ZSH_THEME="rkj-repos" # not bad
#ZSH_THEME="random"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMP="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
#plugins=(zsh_reload scala sbt mvn colored-man-pages brew vim themes docker)

# to enable vscode plugin
VSCODE="code"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

#plugins=(colored-man-pages gradle brew docker vscode jenv kubectl pyenv)
plugins=(colored-man-pages gradle brew docker vscode kubectl python helm)

source $ZSH/oh-my-zsh.sh

# User configuration
# for brew
#export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"

if [ "$(uname -s)" = "Darwin" ]; then
    #export JAVA_HOME=$(/usr/libexec/java_home -v 11)
    # export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    # export PATH=$JAVA_HOME:$PATH
fi

export MANPATH="/usr/local/man:$MANPATH"

if [ -d "/Library/TeX/texbin" -o ]; then
    # El Capitan trick..
    export PATH="$PATH:/Library/TeX/texbin"
fi

# You may need to manually set your language environment
export LANG=en_US.utf-8

setopt inc_append_history
setopt share_history
setopt histignoredups
setopt interactivecomments

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# alias docker=podman
#
# nvm
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
    if [ -f "$NVM_DIR"/nvm.sh ]; then
      source ~/.nvm/nvm.sh
    elif [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
      [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
    fi
fi

# private keys and tokens
if [ -f "$HOME/.keys" ]; then
    source $HOME/.keys
fi

autoload -U zmv
autoload -Uz vcs_info

# export PATH="/usr/local/opt/python/libexec/bin:$PATH"

export TERM="xterm-256color"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

#export HADOOP_HOME=/usr/local/Cellar/hadoop/3.2.1/libexec
#export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# spark
# readonly SPARK_HOME=$(brew info apache-spark | grep '*' | cut -f1 -d\ )
# ${SPARK_HOME}/bin/load-spark-env.sh

# go stuff
# export GOPATH=$(go env GOPATH)
# export PATH=$PATH:$GOPATH/bin
#export PATH="/usr/local/opt/openssl/bin:$PATH"

#export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/sqlite/lib -L/opt/homebrew/opt/libpq/lib"
#export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/sqlite/include -I/opt/homebrew/opt/libpq/include"

#export PATH="/usr/local/opt/sqlite/bin:$PATH"
#export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/$(ruby --version | cut -f2 -d\ | cut -f1,2 -d.)/bin:$PATH"

#export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

if [ -e "$HOME/.cargo/env" ]; then
  source $HOME/.cargo/env
fi

#export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
#export PATH="/opt/homebrew/bin:$PATH"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/stefano/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/stefano/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/stefano/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/stefano/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

