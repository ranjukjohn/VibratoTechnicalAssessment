#!/usr/bin/env bash
# Update all packages
sudo yum update -y

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

# Use the express-generator that creates an application skeleton
npm install express-generator -g

# Create a the Vibrato Tech Assessment (vtc) app  with express-generator
express -v ejs -c sass vtcapp

cd vtcapp
npm install

# Start the node server
npm start &
