### WP-Staging Creator ###

This is a simple shell script that utilises WP-CLI to take a snapshot of a live database and create a completely separate staging server. This will create a new database, new database user and random password. 

This system depends on the great command line utitliy WP-CLI http://wp-cli.org 

This assumes that the script is run on the same host that the live database is. The mysql user must have the ability to create users and databases. You are required to keep your wp-content in a git repository. This will keep your theme and plugins sync'd. You will need to copy / rysnc the live wp-content/uploads directory to the new staging server. 

Tip: To run this locally export the live db and import it into your local mysql database. Rsync a copy of the wp-content/* onto your localhost and replace the wp-content created by the script. 

### USAGE ###

Usage: mysqluser mysqlpass livedb gitrepo dbprefix livedoman stagingdomain installdir

- mysqluser = admin username
- mysqlpass = admin pass
- livedb = live database name 
- gitrepo = url to your git repository 
- dbprefx = wordpres database prefix 
- livedomain = current live domain name
- stagingdomain = staging domain name 
- installdir = directory to install the staging server to 

./wp-staging.sh mysqluser mysqlpass livedb https://github.com/username/wp-content dbprefix_ http://www.livedomain.com http://devdomain.dev installdir 


### TESTED ON ###

This has been tested with MAMP Pro and MAMP on OS X 10.9.5 following the WP-CLI install instructions. 


### TO DO  

 - Change how parameters are used 
 - Allow to pass database script as argument 
 - Make it work on cpanel systems 
 - Make creating database and user optional 
 - Option to remove all other users but specified ids (good for testing ecommerce features)