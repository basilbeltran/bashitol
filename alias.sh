#!/bin/bash
alias p=". ~/.bash_profile"
alias m="  ${CFGHOME}/bin/menu.sh 2>&1"
alias c=" . ${CFGHOME}/bin/dirs.sh"
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
alias awr="${CFGHOME}/bin/eb/AWSDevTools/Linux/AWSDevTools-RepositorySetup.sh"
alias awc="git aws.config"
alias awp="git aws.push"
