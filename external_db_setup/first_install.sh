sudo apt update
sudo apt install docker.io -y
sudo apt install docker-compose -y
mkdir secrets
echo "What is your database host?"
read db_host
echo "What is your database port?"
read db_port
echo "What is your database name?"
read db_name
echo "What is your database user?"
read db_user
cat .env.sample | sed 's|<your-wp-data-dir>|../wp_data|' | sed 's|<your-wp-db-host>|'${db_host}'|' | sed 's|<your-wp-db-port>|'${db_port}'|' | sed 's|<your-wp-db-name>|'${db_name}'|' | sed 's|<your-wp-db-user>|'${db_user}'|' > .env
echo "What is your wordpress database password?"
read wp_db_pw
echo $wp_db_pw > secrets/wp_db_pw
echo "You're done, you can run docker-compose up !"
