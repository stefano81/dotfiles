# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
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
plugins=(zsh_reload scala sbt mvn colored-man-pages brew vim themes docker)

source $ZSH/oh-my-zsh.sh

# User configuration
# for brew
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$PATH"

if [ "$(uname -s)" = "Darwin" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export PATH=$JAVA_HOME:$PATH
fi

# android
#export ANDROID_HOME="$HOME/adt-bundle-linux-x86_64-20131030"
if [ -d '/usr/local/opt/android-sdk' ]; then
    export ANDROID_HOME=/usr/local/opt/android-sdk
fi
if [ -d "$ANDROID_HOME" ]; then
    export PATH="$PATH:$ANDROID_HOME/sdk/tools:$ANDROID_HOME/platform-tools"
fi

# spark
if [ -d "/usr/local/Cellar/apache-spark@1.6" ]; then
    export SPARK_HOME="/usr/local/opt/apache-spark@1.6"
fi
export PATH="$PATH:$SPARK_HOME/bin"

export MANPATH="/usr/local/man:$MANPATH"

if [ -d "$HOME/Utilities/sbt" ]; then
    export PATH="$PATH:$HOME/Utilities/sbt/bin"
fi

if [ -d "/Library/TeX/texbin" -o ]; then
    # El Capitan trick..
    export PATH="$PATH:/Library/TeX/texbin"
fi

# You may need to manually set your language environment
export LANG=en_US.utf-8

setopt inc_append_history
setopt share_history
setopt histignoredups

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# nvm
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR=~/.nvm
    if [ -f "$NVM_DIR"/nvm.sh ]; then
      source ~/.nvm/nvm.sh
    elif [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
      source /usr/local/opt/nvm/nvm.sh
    fi
fi

# if [ -e "$HOME/Downloads/dsdriver/db2profile" ]; then
#    source $HOME/Downloads/dsdriver/db2profile
# fi

# private keys and tokens
if [ -f "$HOME/.keys" ]; then
    source $HOME/.keys
fi

autoload -U zmv

# virtualenv
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_PYTHON=$(which python)
if [ -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

export TERM="xterm-256color"
setopt interactivecomments

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh


# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

export HADOOP_HOME=$HOME/Utilities/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop


### Added by the Bluemix CLI
source /usr/local/Bluemix/bx/zsh_autocomplete

# added by travis gem
[ -f /Users/stefano/.travis/travis.sh ] && source /Users/stefano/.travis/travis.sh
