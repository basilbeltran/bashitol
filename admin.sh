#
# admin current box 
#
echo " ADMIN ..."
echo " 2  get local space "
echo " 3  refresh locateDb "
echo " 4  php.ini "
echo " 5  http.conf "
echo " 6  restart apache "
echo " 7  start mysql "
echo " 8  start mongo "
echo " 9  start redis "
echo " 10  monitor USB "
read yourch
case $yourch in
2) find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn;;
3) /usr/libexec/locate.updatedb;; 
4) vi /private/etc/php.ini;;
5) vi /etc/apache2/httpd.conf;;
6) sudo apachectl restart;;
7) sudo /usr/local/mysql/support-files/mysql.server start;;
8) /Users/kandinski/sites/inc/DBs/mongod 1>&2 & ;;
9) /usr/local/bin/redis-server ;;
10) python /usr/local/bin/miniterm.py /dev/tty.usbserial-A4001tlk 9600  2>&1 ;; 
esac
