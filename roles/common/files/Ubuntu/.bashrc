# .bashrc

############################################################
# Source global definitions
############################################################
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


############################################################
# User specific aliases and functions
############################################################

# Disable SELinux on our home
if [ -x "$(command -v restorecon)" ]; then
    restorecon -R -v "$HOME"
fi

if [ -x "$(command -v scl_source)" ]; then
    source scl_source enable devtoolset-8
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

alias cls="clear"
alias ls="ls --color"
alias ll="ls -alh --color"
alias grep="grep --color"

export PS1="\[\e[0;31m\]\u\[\e[m\]@\[\e[0;35m\]\h\[\e[m\]:\[\e[0;32m\]\W >\[\e[m\]"
export LS_COLORS="di=1;34:st=1;34:ow=1;34:tw=1;34:fi=0:ex=32:mi=0:or=31:ln=31:pi=5:so=5:bd=5:cd=5:*.sh=32"
export HISTCONTROL=ignorespace:ignoredups
export EDITOR="vim"
export PYTHONDONTWRITEBYTECODE=1

export ANSIBLE_INSTALL_PATH="/usr/local"
export PATH="$ANSIBLE_INSTALL_PATH/bin:$ANSIBLE_INSTALL_PATH/sbin:$PATH:$HOME"
export LD_LIBRARY_PATH="$ANSIBLE_INSTALL_PATH/lib64:$ANSIBLE_INSTALL_PATH/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$ANSIBLE_INSTALL_PATH/lib/pkgconfig/:$PKG_CONFIG_PATH"



csvview()
{
    local file="$1"
    cat "$file" | sed -e "s/,,/, ,/g" | column -s, -t | less -#5 -N -S
}
