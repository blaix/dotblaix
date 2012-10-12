if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export EDITOR=vim
export CLICOLOR=1
export P4CONFIG=".p4config"
export DJANGO_ENV=development

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

alias tree="tree -C"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias temp="cd ~/temp"
alias ebp="vim ~/.bash_profile"
alias ntst=nosetests
alias killpyc="find . -name '*.pyc' -delete"
alias git=hub # https://github.com/defunkt/hub
alias grep="grep --color"

# rails aliases
alias be="bundle exec"
alias br="be rake"
alias prails="pry -r ./config/environment"

# django alias
alias djsrv="killpyc; ./manage.py runserver 0.0.0.0:8000"
alias djshl="killpyc; ./manage.py shell"
alias djtst="killpyc; ./manage.py test"
alias djhrv="killpyc; ./manage.py harvest"

# svn aliases
alias svndf="svn diff | less"
alias svnaa="svn st | awk '/^\?/ { print \$2 }' | xargs svn add"

# enable rvm
if [[ -s ~/.rvm/scripts/rvm ]]; then
    source ~/.rvm/scripts/rvm
fi

# pythonbrew aliases
alias pvm="pythonbrew"
alias lspenv="pythonbrew venv list"
alias rmpenv="pythonbrew venv delete"
alias _mkpenv="pvm venv create --no-site-packages"
mkpenv() {
  _mkpenv $1
  pvm venv use $1
}

resetpenv() {
  deactivate
  rmpenv $1
  mkpenv $1
}

ppath() {
  python -c "import os; import $1; print os.path.dirname($1.__file__)"
}

# mac specific stuff
if [[ `uname` == 'Darwin' && -s ~/.bash_profile.osx ]]; then
  source ~/.bash_profile.osx
fi

# machine specific stuff
if [[ -s ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

# Auto activate virtual environments when .pvmrc files are found.
# Assumes use of pythonbrew <https://github.com/utahta/pythonbrew>
has_pvmrc() {
  if [ -e .pvmrc ]; then
    # .pvmrc should be [version]@[env name] (e.g. 2.6@my_project)
    venv=`cat .pvmrc`
    # TODO: Allow some flexibility (e.g. not specifying a virtualenv)
    
    # Bash is ugly. See "Substring Removal" section of
    # <http://tldp.org/LDP/abs/html/string-manipulation.html>
    python_version=${venv%@*} # strip everything after @ to get python version
    virtualenv=${venv#*@} # strip everything before @ to get virtualenv name
    
    pvm use $python_version
    lspenv | grep ^$virtualenv$ >/dev/null || _mkpenv $virtualenv
    pvm venv use $virtualenv
  fi
}
pvm_cd() {
  cd "$@" && has_pvmrc
}
alias cd=pvm_cd

export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
export VIRTUALENV_USE_DISTRIBUTE=true
