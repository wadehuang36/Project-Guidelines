#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

npx fulton-cli new $ProjectName

cd $ProjectName

mkdir .vscode

# install packages
npm install -D eslint prettier eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# add scripts
NPM_SCRIPTS='"lint": "eslint --ext ts --quiet src",\n'
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\//\\\//g')
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\"/\\\"/g')
sed -i "/\"test\": \".*\"/ s/.*/${NPM_SCRIPTS}&/" package.json

# add pre-commit
PRECOMMIT='"pre-commit": [\n"lint",\n"test",\n"build"],\n'
PRECOMMIT=$(echo $PRECOMMIT | sed 's/\"/\\\"/g')
sed -i "/\"dependencies\": {/ s/.*/${PRECOMMIT}\n&/" package.json

# download files
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-web-api/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-web-api/.gitignore
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-web-api/.eslintrc.js
wget -q -P .vscode https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-web-api/settings.json

# format files
npx prettier package.json --write
npm run lint -- --fix

#setup git
git init
git add .
git commit -m "initialize project"

npm install pre-commit