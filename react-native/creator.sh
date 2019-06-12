#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

npx react-native init $ProjectName --template typescript

cd $ProjectName

# create folders and move default files
mkdir app app/src app/src/scenes app/src/services app/src/models app/src/utils app/res/ app/res/images app/res/fonts
mv __tests__ app
mv App.tsx app/src 

## need to change the path of import App on index.js

npm install -D eslint prettier eslint-plugin-react eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# add script
# "lint": "eslint src/**/*.ts src/**/*.tsx"

# download files for formatter and analyzers
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.editorconfig

# setup git
# wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/.gitignore
# git init
# git add .
# git commit -m "initialize the project"