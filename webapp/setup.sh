sudo yum update -y

mkdir webapp
cd webapp

# Install node version manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
#Close and reopen your terminal to start using nvm or run the following to use it now:
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Activate nvm
. ~/.nvm/nvm.sh
# Use nvm to install the latest version of Node.js
nvm install node
# Test that Node.js is installed and running correctly
node -e "console.log('Running Node.js ' + process.version)"
