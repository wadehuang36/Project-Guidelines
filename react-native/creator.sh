#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

npx react-native-cli init $ProjectName --template typescript

cd $ProjectName

# create folders and move default files
mkdir app app/src app/src/scenes app/src/services app/src/utils app/res/ app/res/images app/res/fonts app/test
mkdir build .vscode
mv __tests__/* app/test
rm App.tsx
rm -r __tests__

# change the path of import App on index.js
sed -i "s/'\.\/App'/'.\/app\/src\/scenes\/app'/" index.js

# install packages
npm install -D eslint prettier eslint-plugin-react eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
npm install -D pre-commit

# add scripts
NPM_SCRIPTS='"build": "react-native bundle --entry-file ./index.js --bundle-output build/index.bundle",\n'
NPM_SCRIPTS=$NPM_SCRIPTS'"lint": "eslint **/*.ts **/*.tsx",\n'
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\//\\\//g')
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\"/\\\"/g')
sed -i "/\"test\": \"jest\"/ s/.*/${NPM_SCRIPTS}&/" package.json

# add pre-commit
PRECOMMIT='"pre-commit": [\n"lint",\n"test",\n"build"],\n'
PRECOMMIT=$(echo $PRECOMMIT | sed 's/\"/\\\"/g')
sed "/\"dependencies\": {/ s/.*/${PRECOMMIT}\n&/" package.json

## format package.json
npx prettier package.json --write
npx eslint index.js --fix

# download files
wget -q -o=app/src/scenes/app.tsx https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/app.tsx
wget -q -o=app/res/string-res.tsx https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/string-res.tsx
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.eslintrc.js
wget -q -o=.vscode/settings.json https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/settings.json

setup git
git init
git add .
git commit -m "initialize project"