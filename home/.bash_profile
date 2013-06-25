if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export EDITOR=vim
export CLICOLOR=1
export P4CONFIG=".p4config"
export DJANGO_ENV=development
export PYTHONSTARTUP=~/.pythonrc

# Set up git tab completion and show branch name in command prompt
export GIT_PS1_SHOWDIRTYSTATE=1 # dirtystate can slow things down
source ~/.git-completion.bash
source ~/.hub-completion.bash
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

# django alias
alias djsrv="killpyc; django_manage_command runserver"
alias djshl="killpyc; django_manage_command shell"
alias djtst="killpyc; django_manage_command test"
alias djhrv="killpyc; django_manage_command harvest"

# svn aliases
alias svndf="svn diff | less"
alias svnaa="svn st | awk '/^\?/ { print \$2 }' | xargs svn add"

# git aliases
alias s="git st"
alias gp="git push"
alias gl="git gr"
alias gla="git smart-log" # https://github.com/geelen/git-smart#smart-log
alias gup="git smart-pull" # https://github.com/geelen/git-smart#smart-pull
alias gco="git co"
alias gci="git ci"

# pythonbrew aliases
alias pbrew="pythonbrew"
alias rmpenv="pythonbrew venv delete"
alias _mkpenv="pbrew venv create --no-site-packages $1"

mkpenv() {
  _mkpenv $1
  pbrew venv use $1
}

resetpenv() {
  deactivate
  rmpenv $1
  mkpenv $1
}

ppath() {
  python -c "import os; import $1; print os.path.dirname($1.__file__)"
}

# enable rvm
if [[ -s ~/.rvm/scripts/rvm ]]; then
    source ~/.rvm/scripts/rvm
fi

# Auto activate virtual environments when .pbrewrc files are found.
# Assumes use of pythonbrew <https://github.com/utahta/pythonbrew>
has_pbrewrc() {
    # .pbrewrc should be [version]@[env name] (e.g. 2.6.5@my_project)
    
    # check current dir and parent dir for .pbrewrc, else eject goose
    venv=`cat .pbrewrc 2>/dev/null`
    if [[ $? != 0 ]]; then
        venv=`cat ../.pbrewrc 2>/dev/null`
    fi
    if [ $? != 0 ]; then return; fi
    
    # TODO: Allow some flexibility (e.g. not specifying a virtualenv)
    
    # Bash is ugly. See "Substring Removal" section of
    # <http://tldp.org/LDP/abs/html/string-manipulation.html>
    python_version=${venv%@*} # strip everything after @ to get python version
    virtualenv=${venv#*@} # strip everything before @ to get virtualenv name
    
    pbrew use $python_version || return
    pbrew venv list | grep "^\s*$virtualenv$" >/dev/null || _mkpenv $virtualenv
    pbrew venv use $virtualenv
}

# Aliasing builtins is poopy, especially when the alias calls the builtin
# becasue when you source your bash_profile, it will create an infinite loop
cd() {
    if [[ "$*" == "" ]]; then
        builtin cd
    else
        builtin cd "$*"
    fi
    has_pbrewrc
    __rvm_project_rvmrc
}

django_manage_command() {
  cwd=${PWD##*/}
  cmd="manage.py"
  if [[ ! -s ./manage.py ]]; then
    cmd="$cwd/$cmd"
  fi
  cmd="./$cmd $*"
  $cmd
}

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

