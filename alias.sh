#!/bin/bash

alias p=". ~/.bash_profile"               # refresh profile
alias m="  ${CFGHOME}/bin/menu.sh 2>&1"   # enter menu system
alias c=" . ${CFGHOME}/bin/dirs.sh"       # quickly change to essential dirs
alias t="top"
alias h="history | grep $1"
alias l="locate $1"
alias cls="clear"
alias ap="echo PATH='\${PATH}':$PWD >> $CFGHOME/bin/paths.sh; p "   # ADD DIR TO PATH
 
alias gi="git init"
alias ga="git add *"
alias gs="git status -s"
alias gd="git diff"
alias gc="git commit -am $1 "
alias go="git remote add origin $1"
alias gp="git push -u origin master"
alias awr="${CFGHOME}/bin/eb/AWSDevTools/Linux/AWSDevTools-RepositorySetup.sh"
alias awc="git aws.config"
alias awp="git aws.push"
alias ta="tail -f /private/var/log/apache2/acc* "
alias tc="tail -f /private/var/log/apache2/*.php  "
alias mc=" sudo /Users/kandinski/Sites/inc/DBs/memcached-1.4.14/scripts/memcached-tool localhost:11211 dump  "
alias mcd="sudo /Users/kandinski/Sites/inc/DBs/memcached-1.4.14/scripts/memcached-tool localhost:11211 display  "
alias mcs="sudo /Users/kandinski/Sites/inc/DBs/memcached-1.4.14/scripts/memcached-tool localhost:11211 stats  "
alias n="netstat -an | grep $1"
alias s="ps -ef | grep $1"
