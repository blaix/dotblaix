export PATH="~/bin:~/.local/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export YOLA_SRC=$HOME/work/

if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi
