#!/usr/bin/env bash
sudo apt-get update

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

sudo apt-get install nodejs -y
sudo apt-get install npm -y

npm init -y
# Use the express-generator that creates an application skeleton
npm install express-generator -g

# Create a the Vibrato Tech Assessment (vtc) app  with express-generator
express -v ejs -c sass vtcapp

# Install MySQL
echo mysql-server mysql-server/root_password select root | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again select root | sudo debconf-set-selections
sudo apt-get install -y mysql-server
sudo apt-get install mysql-client -y

# Start the MySQL service
sudo systemctl start mysql
# Launch at reboot
sudo systemctl enable mysql

mysql -uroot -proot -e "create database if not exists mywebsite;"
mysql -uroot -proot -e "use mywebsite; create table chat (textline varchar(20))"
mysql -uroot -proot -e "use mywebsite; insert into chat (textline) values('Hello\ World');"

echo "cd to project directory vtcapp"
cd vtcapp
mv /tmp/app.js ./app.js
npm install
npm install mysql

# Redirect port 80 to port 3001
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3001
echo "iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3001" | sudo tee -a /etc/rc.local

# Start node server in forever
echo "npm start"
sudo npm install forever --global
sudo forever start app.js
 ps axl | grep node
