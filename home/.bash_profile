if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export EDITOR=vim
export CLICOLOR=1
export AUTOFEATURE=true # always run cucumber features with autotest

# Set up git tab completion and show branch name in command prompt
#export GIT_PS1_SHOWDIRTYSTATE=1 # dirtystate slows things down
source ~/.git-completion.bash
export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '
# git AND rvm... too much info?
# export PS1="\[\033[01;34m\]\$(~/.rvm/bin/rvm-prompt):\[\033[01;32m\]\w\[\033[00;33m\]\$(__git_ps1 \"(%s)\")\[\033[01;36m\]\$\[\033[00m\] "

alias tree="tree -C"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias ffopen="open -a Firefox.app"
alias bpreload="source ~/.bash_profile"
alias be="bundle exec"
alias prails="pry -r ./config/environment"

if [[ `uname` == 'Darwin' && -s ~/.bash_profile.osx ]]; then
  source ~/.bash_profile.osx
fi

if [[ -s ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

if [[ -s ~/.rvm/scripts/rvm ]]; then
  source ~/.rvm/scripts/rvm;
fi

eval "$(rbenv init -)"
