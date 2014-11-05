### WP-Staging Creator ###

This is a simple shell script that utilises WP-CLI to take a snapshot of a live database and create a completely separate staging server. This will create a new database, new database user and random password. 

This system depends on the great command line utitliy WP-CLI http://wp-cli.org 

This assumes that the script is run on the same host that the live database is. The mysql user must have the ability to create users and databases. 

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


### TESTED ON ###

This has been tested with MAMP Pro and MAMP on OS X 10.9.5 following the WP-CLI install instructions. 


### TO DO ### 

 - Change how parameters are used 
 - Allow to pass database script as argument 
 - Make it work on cpanel systems 
 - Make creating database and user optional 