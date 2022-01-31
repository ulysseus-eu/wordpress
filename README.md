# Wordpress composition
This is a docker compose for wordpress with secrets handling and 2 configurations, one that embed a database, the otherone relying on an external database
## Hosting a standalone instance
Clone the Git repository for docker-compose install: https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
```bash
git clone https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
cd internal_db_setup
sh first_install.sh
docker-compose up -d
```
### Modify Apache main configuration to access test website
```bash
sudo nano /etc/apache2/sites-available/wp-ulysseus.conf
```
## Hosting of a Test instance (external DB setup) starting from an existing site
Clone the Git repository for docker-compose install: https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
```bash
git clone https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
```
### Copy the data from production wordpress 
```bash
cd external_db_setup
mkdir wp_data/data 
docker inspect wp_ulysseus_eu 
sudo cp -r /var/lib/docker/volumes/9ac1369bb492b99c419424c70d6d8c6a46ae42f19b09bbc7c78d662b0326d8bc/_data/* wp_data/data 
sudo chown -R www-data:www-data wp_data/data 
``` 
### Export the database content 
-C is for compress, -f is to force on errors, -p is to request password 
Password can be found from the origin website as per its configuration and deployment 
```bash
mkdir db_backup 
mysqldump -h bdd.ulysseus.eu -u root -C -f -p wordpress > db_backup/wp_backup_all_tables.sql 
``` 
### Patch the database content with new domain 
```bash
cat db_backup/wp_backup_all_tables.sql | perl -ne 's|([^@])ulysseus.eu(?!/test)|$1ulysseus.eu/test|g;print;' >  db_backup/wp_backup_all_tables_test.sql 
``` 
To test the regex for further modification 
```bash
> echo "lol:ulysseus.eu/test,ulysseus.eu,jaime,jlo@ulysseus.eu" | perl -ne 's|([^@])ulysseus.eu(?!/test)|$1ulysseus.eu/test|g;print;' 
lol:ulysseus.eu/test,ulysseus.eu/test,jaime,jlo@ulysseus.eu 
``` 
### Create new database in existing host (or host a completely new MySQL instance)
```bash
mysql -h bdd.ulysseus.eu -u root -p
```
```sql
create database wordpress_test;
```
### Import database content 
```bash
mysql -h bdd.ulysseus.eu -u root -C -f -p wordpress_test < db_backup/wp_backup_all_tables_test.sql 
``` 
### Patch the database to correct multisite folders for test instance
```bash
mysql -h bdd.ulysseus.eu -u root -p
```
```sql
update wp_site set domain='ulysseus.eu', path='/test/' where id=1;
update wp_blogs set domain='ulysseus.eu', path='/test/' where blog_id=1;
update wp_blogs set domain='d2s.ulysseus.eu', path='/test/' where blog_id=2;
update wp_blogs set domain='mob4all.ulysseus.eu', path='/test/' where blog_id=3;
```
# Create .env and secrets by running first install
```bash
sh first_install.sh
docker-compose up -d
```
### Modify Apache main configuration to access test website
```bash
sudo nano /etc/apache2/sites-available/wp-ulysseus.conf
```
