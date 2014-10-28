#!/bin/bash
# Create staging server from live database 

# Generate a Password 
genpasswd() {
	local l=$1
       	[ "$l" == "" ] && l=16
      	openssl rand -base64 $l
}

#check that wordpress-cli is installed 
# asssumes you have installed wp-cli into your path and renamed it to wp
checkwpcli() {
    if hash wp 2>/dev/null; then
        echo 'wp-cli installed.'; 
    else
        echo 'wp-cli is required. Download and install available from http://wp-cli.org/'; 
    fi
}

# Generate a database name or user 
gendbdetails(){ 
local l=$1
       	[ "$l" == "" ] && l='staging'
	DATE=`date +"%Y-%m-%d"`
	echo $l'-'$DATE
}

# Create the database and user, grant privileges. 
createdb() { 
	MYSQL=`which mysql`
	Q1="CREATE DATABASE IF NOT EXISTS  \`$1\`;"
	Q2="GRANT USAGE ON *.* TO \`$2\`@localhost IDENTIFIED BY '$3';"
	Q3="GRANT ALL PRIVILEGES ON \`$1\`.* TO \`$2\`@localhost;"
	Q4="FLUSH PRIVILEGES;"
	SQL="${Q1}${Q2}${Q3}${Q4}"
	$MYSQL -u$4 -p$5 -e "$SQL"
}

EXPECTED_ARGS=8
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 mysqluser mysqlpass livedb gitrepo dbprefix livedoman stagingdomain installdir"
  exit $E_BADARGS
fi

# Set the Variables 
MYSQLUSER=$1
MYSQLPASS=$2
LIVEDB=$3 
GITREPO=$4
DBUSER=`gendbdetails user`
DBPASS=`genpasswd 8`
DBNAME=`gendbdetails`
DBPREFIX=$5
OLDDOMAIN=$6
NEWDOMAIN=$7
INSTALLDIR=$8

echo '---------------------------------------------'
echo 'WP Staging - The simple staging server script'
echo '---------------------------------------------'
echo 'Checking if WP-CLI is installed....'
checkwpcli 
echo '---------------------------------------------'
echo 'Creating staging server.....'
echo '---------------------------------------------'
echo 'Creating staging web-root'
mkdir $INSTALLDIR;  cd $INSTALLDIR; 
createdb $DBNAME $DBUSER $DBPASS $MYSQLUSER $MYSQLPASS
echo 'Database created....'
wp core download
rm -rf license.txt readme.html wp-config-sample.php
echo 'WP clean up complete...'
wp core config --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DBPASS --dbhost=localhost --dbprefix=$DBPREFIX --extra-php <<PHP
define( 'WP_MEMORY_LIMIT', '256M' );
PHP
# These details don't matter as they will be overridden as soon as the import is done. 
wp core install --url='$NEWDOMAIN' --title='Test' --admin_user='admin' --admin_password='password' --admin_email='test@test.com'
echo 'Base Wordpress configuration completed....'
echo 'Dumping live database...'
mysqldump -u$MYSQLUSER -p$MYSQLPASS $LIVEDB > import.sql
echo 'Importing live database into staging database .....'
wp db import import.sql
echo 'Removing database dump now that it has been imported....'
rm -f import.sql
echo 'Updating domain name....'
wp search-replace $OLDDOMAIN $NEWDOMAIN
mv wp-content wp-content.orig
git clone $GITREPO wp-content
echo '---------------------------------------------'
echo 'Staging server created.'
echo '---------------------------------------------'