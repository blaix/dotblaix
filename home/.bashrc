export EDITOR=vim
export CLICOLOR=1
export P4CONFIG=".p4config"
export DJANGO_ENV=development
export PYTHONSTARTUP=~/.pythonrc
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Set up git tab completion and show branch name in command prompt
export GIT_PS1_SHOWDIRTYSTATE=1 # dirtystate can slow things down
# ubuntu: git stuff should work with a normal apt-get install git
# osx/homebrew: git completion/prompt stuff is sourced in .bash_profile.osx
source ~/.hub-completion.bash # stored in homesick castle
# with colors...
export PS1="\[\033[01;34m\]\u@\h:\[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \"[%s]\")\[\033[01;36m\]\$\[\033[00m\] "
# without colors...
#export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '
# with rvm info...
#export PS1="($(~/.rvm/bin/rvm-prompt))$PS1"

alias tree="tree -C | less -R"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias temp="cd ~/temp"
alias ebp="vim ~/.bash_profile"
alias rbp="source ~/.bash_profile"
alias ntst=nosetests
alias killpyc="find . -name '*.pyc' -delete"
alias git=hub # https://github.com/defunkt/hub
alias grep="grep --color=always"
alias less="less -R"
alias watch="watchr watch.rb"

# common pattern for work stuff:
alias ve="source virtualenv/bin/activate"

# rails aliases
alias be="bundle exec"
alias br="be rake"
alias prails="pry -r ./config/environment"

# run binary from project's node_modules/.bin dir
# ex: ne coffee
# see http://stackoverflow.com/a/15157360/193813
# alias ne="PATH=$(npm bin):$PATH"
# above alias not working for me, using function instead:
ne() {
    $(npm bin)/$*
}

# django alias
alias djshl="killpyc; django_manage_command shell"
alias djtst="killpyc; django_manage_command test"
alias djhrv="killpyc; django_manage_command harvest"
djsrv() { # djsrv [port number]
    if [ -z "$1" ]; then
        port=8000
    else
        port=$1
    fi
    killpyc
    django_manage_command runserver 0.0.0.0:$port
}

# svn aliases
alias svndf="svn diff | less"
alias svnaa="svn st | awk '/^\?/ { print \$2 }' | xargs svn add"

# git aliases
alias s="git st"
alias gfo="git fetch origin"

ppath() {
  python -c "import os; import $1; print os.path.dirname($1.__file__)"
}

django_manage_command() {
  cwd=${PWD##*/}
  cmd="manage.py"
  if [[ ! -s ./manage.py ]]; then
    cmd="$cwd/$cmd"
  fi
  cmd="./$cmd $*"
  cd . # activate local virtualenv
  $cmd
}
alias djm=django_manage_command

railz() {
  rails new $1 -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb
}
  
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENV_USE_DISTRIBUTE=true

# mac specific stuff
if [[ `uname` == 'Darwin' && -s ~/.bash_profile.osx ]]; then
  source ~/.bash_profile.osx
fi

# linux specific stuff
if [[ `uname` == 'Linux' && -s ~/.bash_profile.linux ]]; then
  source ~/.bash_profile.linux
fi

# machine specific stuff
if [[ -s ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

# run locally install npm binaries
ne() {
    $(npm bin)/$*
}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
my_pyenv_version() {
    current_version=`pyenv version`
    current_version="${current_version%% *}"
    echo $current_version
}
my_pyenv_prompt() {
    current_version=`my_pyenv_version`
    if [[ $current_version == "system" || $current_version =~ ^[0-9] ]]; then
        echo ""
    else
        echo "($current_version)"
    fi
}
PS1="\$(my_pyenv_prompt)"$PS1
create_and_use_venv() {
    if [ -z "$1" ]; then
        # no args, use current version
        use_version=`my_pyenv_version`
        echo $use_version
    else
        # version specified as first arg
        use_version=$1
    fi
    # install version if needed:
    if ! pyenv versions | grep -q $use_version; then
        pyenv install $use_version
    fi
    # create and use the venv "dir_name-version"
    venv_name="${PWD##*/}-$use_version"
    pyenv virtualenv $use_version $venv_name
    pyenv local $venv_name
    # for now, install the latest M2Crypto. The one that gets installed as a
    # dependency to our yola stuff has a bug in Ubuntu 12.04, but I don't want
    # to explcitly add it as a requirement because I don't know the details.
    pip install M2Crypto
}
alias venv=create_and_use_venv

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
