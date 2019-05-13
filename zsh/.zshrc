# re-use ssh-agent and/or gpg-agent between logins
eval $(keychain --eval --quiet id_rsa id_rsa)

# Exported variables
export TERM=xterm-color
export EDITOR=vim
export VISUAL=vim
export SUDO_EDITOR=vim

# aliases
alias df='df -kTh'
alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'
alias which='type -a'
alias mini='sudo minicom -D /dev/ttyUSB0'
alias pdf='xpdf'
alias debian='docker run -it -h debian debian:latest'
alias centos='docker run -it -h centos centos:latest'

# The 'ls' family
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh' #  Nice alternative to 'recursive ls' ...
