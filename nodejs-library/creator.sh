#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

mkdir $ProjectName

cd $ProjectName

mkdir .vscode src

echo 'console.log("hello world!")' > src/index.ts

# download files
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-library/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-library/.gitignore
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-library/.eslintrc.js
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-library/package.json
wget -q -P .vscode https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-library/settings.json

# install packages
npm install -D typescript eslint prettier eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# update project name
sed -i "s/\"name\": \".*\"/\"name\": \"$ProjectName\"/" package.json

# format files
npx prettier package.json --write

#setup git
git init
git add .
git commit -m "initialize project"

npm install pre-commit