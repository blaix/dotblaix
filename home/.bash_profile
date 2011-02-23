if [[ -f ~/.bashrc ]]; then source ~/.bashrc; fi

export PATH="~/bin:~/.gem/ruby/1.8/bin:/usr/local/bin:$PATH"
export EDITOR=vim
export CLICOLOR=1
export AUTOFEATURE=true # always run cucumber features with autotest

# Set up git tab completion and show branch name in command prompt
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '

alias tree="tree -C"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias ffopen="open -a Firefox.app"
alias bpreload="source ~/.bash_profile"
alias vlc="/Applications/VLC.app/Contents/MacOS/VLC -I ncurses"

if [[ -s ~/.bash_profile.local ]] ; then source ~/.bash_profile.local ; fi
if [[ -s ~/.rvm/scripts/rvm    ]] ; then source ~/.rvm/scripts/rvm    ; fi
