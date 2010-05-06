export PATH="~/.gem/ruby/1.8/bin:/usr/local/bin:$PATH"
export EDITOR=vim

# Set up git tab completion and show branch name in command prompt
source /usr/local/etc/bash_completion.d/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '

alias tree="tree -C"

if [[ -s ~/.bash_profile.local ]] ; then source ~/.bash_profile.local ; fi
if [[ -s ~/.rvm/scripts/rvm    ]] ; then source ~/.rvm/scripts/rvm    ; fi
