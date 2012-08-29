#!/bin/bash
#
#  EDIT FILE
#
while :
do
clear
echo " EDIT MENUS ..."
echo " 1 main menu "
echo " 2 edit menu "
echo " 3 admin menu "
echo " 4 CI menu "
echo " 5 dirs menu "
echo " 6 alias.sh "
echo " 7 functions.sh "
echo " 8 .bashrc "
echo " 0 Back "
read yourch
case $yourch in
1) vi ${CFGHOME}/bin/menu.sh;; 
2) vi ${CFGHOME}/bin/conf.sh;; 
3) vi ${CFGHOME}/bin/admin.sh;; 
4) vi ${CFGHOME}/bin/CI.sh;; 
5) vi ${CFGHOME}/bin/dirs.sh;; 
6) vi ${CFGHOME}/bin/alias.sh;; 
7) vi ${CFGHOME}/bin/functions.sh;; 
8) vi ${CFGHOME}/.bashrc;;
0) exit 0;;
*) echo "Please select valid choice";
echo "Press Enter to continue. . ." ; read ;;
esac
done
