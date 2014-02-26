# Reset PATH to keep it from being clobbered in tmux
# See https://github.com/yyuu/pyenv/issues/85#issuecomment-29772971
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    source /etc/profile
fi

# Load .bashrc
# That's where the real stuff lives.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
