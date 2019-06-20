#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

npx react-native-cli init $ProjectName --template typescript

cd $ProjectName

# create folders and move default files
mkdir app app/src app/src/core app/src/scenes app/src/services app/src/utils app/res/ app/res/images app/res/fonts app/test
mkdir build .vscode
mv __tests__/App-test.tsx app/test/app.test.tsx
rm App.tsx
rm -r __tests__

# change the path of import App on index.js and app.test.tsx
sed -i "s/'\.\/App'/'.\/app\/src\/scenes\/app'/" index.js
sed -i "s/'\..\/App'/'..\/src\/scenes\/app'/" app/test/app.test.tsx

# install packages
npm install -D eslint prettier eslint-plugin-react eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser

# add scripts
NPM_SCRIPTS='"build": "react-native bundle --entry-file ./index.js --bundle-output build/index.bundle",\n'
NPM_SCRIPTS=$NPM_SCRIPTS'"lint": "eslint --ext ts --ext tsx --quiet app",\n'
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\//\\\//g')
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\"/\\\"/g')
sed -i "/\"test\": \"jest\"/ s/.*/${NPM_SCRIPTS}&/" package.json

# add pre-commit
PRECOMMIT='"pre-commit": [\n"lint",\n"test",\n"build"],\n'
PRECOMMIT=$(echo $PRECOMMIT | sed 's/\"/\\\"/g')
sed -i "/\"dependencies\": {/ s/.*/${PRECOMMIT}\n&/" package.json

# download files
wget -q -P app/src/scenes https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/app.tsx
wget -q -P app/res https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/string-res.ts
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/.eslintrc.js
wget -q -P .vscode https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/settings.json

# format files
npx prettier package.json --write
npx eslint index.js --fix
npm run lint -- --fix

#setup git
git init
git add .
git commit -m "initialize project"

npm install -D pre-commit