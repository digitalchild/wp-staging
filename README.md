### WP-Staging Creator ###

This is a simple shell script that utilises WP-CLI to take a snapshot of a live database and create a completely separate staging server. This will create a new database, new database user and random password. 

This system depends on the great command line utitliy WP-CLI http://wp-cli.org

This will install into a directory called staging. This will be the webroot for the staging server. 

### USAGE ###

Usage: mysqluser mysqlpass livedb livedoman stagingdomain 

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