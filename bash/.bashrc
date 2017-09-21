#
# ~/.bashrc
#
# Inspiration:
# http://tldp.org/LDP/abs/html/sample-bashrc.html

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='\w/. '
TERM=rxvt
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# Exported variables
export EDITOR=vim
export VISUAL=vim
export SUDO_EDITOR=vim
export PYTHONPATH=~/.local/lib/python3.6/site-packages
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Personnal Aliases
alias h='history'
alias j='jobs-l'
alias df='df -kTh'
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'
alias mini='sudo minicom -D /dev/ttyUSB0'
alias which='type -a'
alias mkdir='mkdir -p'
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
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

# Personnal Aliases within functions
git() {
  if [[ $@ == "log" ]]; then
    command git log --pretty=oneline --abbrev-commit
  elif [[ $@ == "graph" ]]; then
    command git log --graph --all --date=short --pretty=format':%C(yellow)%h%Cblue%d%Creset %s %Cgreen %aN, %aD%Creset'
  else
    command git "$@"
  fi
}
