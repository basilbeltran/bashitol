#!/bin/bash
# The main menu is available through an alias of the "m" key in .bashrc
while :
do
clear
echo " 1 edit env"
echo " 2 SSH "
echo " 3 admin "
echo " 4 CI "
echo " 0 EXIT "
read yourch
case $yourch in
1)  ${CFGHOME}/bin/conf.sh;;
2)  ${CFGHOME}/bin/ssh.sh;;
3)  ${CFGHOME}/bin/admin.sh;break;;
4)  ${CFGHOME}/bin/CI.sh;;
0) exit 0;;
*) echo "Please select valid choice";
echo "Press Enter to continue. . ." ; read ;;
esac
done
