export PATH="~/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:~/.rbenv/bin:$PATH"

# TODO: why did I add this ssh stuff?
# it breaks ssh agent forwarding...

# SSH_ENV="$HOME/.ssh/environment"

# function start_agent {
#   echo "Initialising new SSH agent..."
#   /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#   echo succeeded
#   chmod 600 "${SSH_ENV}"
#   . "${SSH_ENV}" > /dev/null
#   /usr/bin/ssh-add;
# }

# # Source SSH settings, if applicable

# if [ -f "${SSH_ENV}" ]; then
#   . "${SSH_ENV}" > /dev/null
#   #ps ${SSH_AGENT_PID} doesn't work under cywgin
#   ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#       start_agent;
#   }
# else
#   start_agent;
# fi

# set up pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export YOLA_SRC="/Users/jblake/work/"
