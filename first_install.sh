sudo apt update
sudo apt install docker.io -y
sudo apt install docker-compose -y
cp sample.env .env
mkdir wp_data
mkdir db_data
mkdir secrets
echo "What should be your database root password?"
read db_root_pw
echo $db_root_pw > secrets/db_root_pw
echo "What should be your wordpress database password?"
read wp_db_pw
echo $wp_db_pw > secrets/wp_db_pw
echo "You're done, you can run docker-compose up !"
