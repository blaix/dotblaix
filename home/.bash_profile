if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export PATH="~/bin:~/.gem/ruby/1.8/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export EDITOR=vim
export CLICOLOR=1
export AUTOFEATURE=true # always run cucumber features with autotest

# Set up git tab completion and show branch name in command prompt
#export GIT_PS1_SHOWDIRTYSTATE=1 # dirtystate slows things down
source ~/.git-completion.bash
export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '

alias tree="tree -C"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias ffopen="open -a Firefox.app"
alias bpreload="source ~/.bash_profile"

if [[ `uname` == 'Darwin' && -s ~/.bash_profile.osx ]]; then
  source ~/.bash_profile.osx
fi

if [[ -s ~/.rvm/scripts/rvm ]]; then
  source ~/.rvm/scripts/rvm;
fi
