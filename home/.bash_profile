export PATH=~/.gem/ruby/1.8/bin:$PATH
export EDITOR=vim

# Set up git tab completion and show branch name in command prompt
source /usr/local/etc/bash_completion.d/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\u@\h:\w$(__git_ps1 "[%s]")\$ '

if [[ -s ~/.local-bash_profile ]] ; then source ~/.local-bash_profile ; fi
if [[ -s ~/.rvm/scripts/rvm    ]] ; then source ~/.rvm/scripts/rvm    ; fi
