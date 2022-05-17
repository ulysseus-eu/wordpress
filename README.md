# Wordpress composition
This is a docker compose for wordpress with secrets handling and 2 configurations, one that embed a database, the otherone relying on an external database
## Host wordpress with database as part of the composition
Clone the Git repository for docker-compose install: https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
```bash
git clone https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
cd internal_db_setup
sh first_install.sh
docker-compose up -d
```
# Host wordpress with external database
```bash
git clone https://git.univ-cotedazur.fr/ulysseus/config/wordpress.git
cd external_db_setup
sh first_install.sh
docker-compose up -d
```
