#!/bin/bash -x

#Get all your path info from this file, keeping it all here is a mess.
source $CFGHOME/bin/paths.sh
# But include this line because some installs think they should write to your .bashrc file and add themselves to $PATH
export PATH
PATH=$PATH

export AWS_CREDENTIAL_FILE=~/.awscreds
export WEB_SITES=~/sites
export WEB_PROJ
export ELASTICBEANSTALK_URL=us-east-1a
parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'; }
export PS1="\n\t \w \$(parse_git_branch) \n \$ "
set -o vi

source $CFGHOME/bin/alias.sh
source $CFGHOME/bin/functions.sh

if [ -f .drushrc ] ; then
    . .drushrc
fi
