# Adapted from: http://blog.vagmim.com/2009/04/git-branch-on-command-prompt.html
function git_branch
{
  git branch 2> /dev/null | grep \* | python -c "print '['+raw_input()[2:]+']'" 2> /dev/null
}

export PS1='\u@\h:\w$(git_branch)\$ '
