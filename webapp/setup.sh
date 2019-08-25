#!/usr/bin/env bash
# Update all packages
# sudo yum update -y
# sudo yum install mysql -y
sudo apt-get update
# Install MySQL

# Install node version manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Close and reopen your terminal to start using nvm or run the following to use it now:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Activate nvm
. ~/.nvm/nvm.sh

# Use nvm to install the latest version of Node.js
nvm install node

# Test that Node.js is installed and running correctly
node -e "console.log('Running Node.js ' + process.version)"

sleep 10;
# Use the express-generator that creates an application skeleton
npm install express-generator -g

# Create a the Vibrato Tech Assessment (vtc) app  with express-generator
express -v ejs -c sass vtcapp

echo mysql-server mysql-server/root_password select root | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again select root | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo apt-get install mysql-client -y

# Start the MySQL service
sudo systemctl start mysql
# Launch at reboot
sudo systemctl enable mysql
#sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';"
#sudo /usr/bin/mysql --defaults-file=/etc/mysql/debian.cnf

mysql -uroot -proot -e "create database if not exists mywebsite;"
mysql -uroot -proot -e "use mywebsite; create table chat (textline varchar(20))"
mysql -uroot -proot -e "use mywebsite; insert into chat (textline) values('Hello\ World');"


cd vtcapp
mv /tmp/app.js ./app.js
npm install
npm install mysql

# Start the node server
npm start &
