## Control ls command behavior
alias ls="/bin/ls $LS_OPTIONS"
alias ll='ls -l'
alias lsd='ls -ld'
alias la='ls -a'
alias lf='ls -F'
alias lr='ls -alFRt'
alias lx='ls -xF'
alias llar='ls -laFR'
alias lt='ls -lartF'
alias lrt='ls -lrt'

## Control cd command behavior
alias up='cd ..'
alias up2='cd ../..'
alias up3='cd ../../..'
alias up4='cd ../../../..'
alias up5='cd ../../../../..'
alias pe='printenv'
alias senv='env | sort'
alias pu='pushd'
alias po='popd'
alias pud='pushd .'
alias rot='pushd +1'
alias jobs='jobs -l'
alias mroe=more
alias lses=less
alias lsse=less
alias l=ls
alias f=file
alias c=cat
alias m=more
alias j=jobs
alias k=kill
alias d=dirs
alias h=history
alias his=history
alias hm='history | less'
alias sy3='sync; sync; sync; echo "sync 3 times ..."'
alias del='rm -i'
alias bye=exit
alias ciao=exit

alias o='open -a TextEdit'
alias open='open -a TextEdit'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# App aliases
alias kill='kill $(lsof -ti $2)'

# Docker
alias d='docker'

