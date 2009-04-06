
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export EDITOR="nfgvim"
export PATH="${PATH}:/usr/local/git/bin"

# e environment
if [ -d ~/.e ]; then
	eval "$(~/.e/e.py init)"
fi

# git/cvs/svn
export GIT_EDITOR="nfgvim"
export CVS_RSH=ssh
export SVN_EDITOR=/usr/bin/vim

#aliases
alias ls='ls -pG $*'
alias top="/usr/bin/top -o cpu"
alias shit="sudo shutdown -r now"
alias vim="nfgvim"

# checks the exit status of the previous command and prints out a  if it errored
export PS1="\[\033[01;32m\]\u@\h(\$EPROJECT) \$(parse_git_branch) \[\033[01;36m\]\w \`if [ \$? != 0 ]; then echo -e '\[\e[01;31m\]:('; fi\`\[\033[01;34m\] \$ \[\033[00m\]"
