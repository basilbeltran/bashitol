#
# Script for movin around 
#
echo " CHANGE DIRECTORY TO ... "
echo " 1 webtools "
echo " 2 sites "
echo " 3 SHELL scripts "
echo " 4 BigPile-o-Docs "
echo " 5 BigPile-o-Code "
echo " 6 current proj "
echo -n "Enter your number: "
read yourch
case $yourch in
1) cd ~/sites/inc;;
2) cd ~/sites;;
3) cd $CFGHOME/bin;;
4) cd /Volumes/Server/DOCS;;
5) cd /Volumes/basil/CODE;;
6) cd $WEB_PROJ;;
esac
ls
