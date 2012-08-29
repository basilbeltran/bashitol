#!/bin/bash
#
# Script to edit frequently edited files
#
while :
do
clear
echo " EDIT CI CONFIGS ..."
echo " 1 config "
echo " 2 routes "
echo " 3 database "
echo " 4 autoload "
echo " 5 index "
echo " 0 exit "
read yourch
case $yourch in
1) vi application/config/config.php;; 
2) vi application/config/routes.php;; 
3) vi application/config/database.php;; 
4) vi application/config/autoload.php;; 
5) vi index.php;; 
0) exit 0;;
*) echo "Please select valid choice";
echo "Press Enter to continue. . ." ; read ;;
esac
done
