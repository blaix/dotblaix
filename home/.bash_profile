if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export EDITOR=vim
export CLICOLOR=1
export P4CONFIG=".p4config"
export DJANGO_ENV=development

# Set up git tab completion and show branch name in command prompt
export GIT_PS1_SHOWDIRTYSTATE=1 # dirtystate can slow things down
source ~/.git-completion.bash
source ~/.hub-completion.bash
export PS1="\[\033[01;34m\]\u@\h:\[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \"[%s]\")\[\033[01;36m\]\$\[\033[00m\] "
# without colors...
#export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '
# with rvm info...
#export PS1="\[\033[01;34m\]\$(~/.rvm/bin/rvm-prompt):\[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \"(%s)\")\[\033[01;36m\]\$\[\033[00m\] "

alias tree="tree -C"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias temp="cd ~/temp"
alias ebp="vim ~/.bash_profile"
alias ntst=nosetests
alias killpyc="find . -name '*.pyc' -delete"
alias git=hub # https://github.com/defunkt/hub

# rails aliases
alias be="bundle exec"
alias bm="bundle && be rake db:migrate"
alias prails="pry -r ./config/environment"

# django alias
alias djsrv="killpyc; ./manage.py runserver 0.0.0.0:8000"
alias djshl="killpyc; ./manage.py shell"
alias djtst="killpyc; ./manage.py test"
alias djhrv="killpyc; ./manage.py harvest"

# svn aliases
alias svndf="svn diff | less"
alias svnaa="svn st | awk '/^\?/ { print \$2 }' | xargs svn add"

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

# mac specific stuff
if [[ `uname` == 'Darwin' && -s ~/.bash_profile.osx ]]; then
  source ~/.bash_profile.osx
fi

# machine specific stuff
if [[ -s ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

# enable rbenv shims and autocompletion
# see: <https://github.com/sstephenson/rbenv>
eval "$(rbenv init -)"

# virtualenv setup
source /usr/local/bin/virtualenvwrapper.sh

# Auto activate virtual environments when .venv files are found.
# Assumes use of pythonbrew <https://github.com/utahta/pythonbrew>
has_pvmrc() {
  if [ -e .pvmrc ]; then
    # .venv should be [version]@[env name] (e.g. 2.6@my_project)
    venv=`cat .pvmrc`
    # TODO: Allow some flexibility (e.g. not specifying a virtualenv)
    
    # Bash is ugly. See "Substring Removal" section of
    # <http://tldp.org/LDP/abs/html/string-manipulation.html>
    python_version=${venv%@*} # strip everything after @ to get python version
    virtualenv=${venv#*@} # strip everything before @ to get virtualenv name
    
    pvm use $python_version
    lspenv | grep $virtualenv >/dev/null || _mkpenv $virtualenv
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
