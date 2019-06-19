#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName

npx create-react-app $ProjectName --typescript

cd $ProjectName

# create folders and move default files
mkdir src/core src/scenes src/services src/utils src/res/ src/res/images src/res/fonts test test/scenes
mkdir build .vscode
mv ./src/App.css ./src/scenes/app.css
mv ./src/App.test.tsx ./test/scenes/app.test.tsx
mv ./src/logo.svg ./src/res/images/logo.svg

rm ./src/App.tsx

# change the paths
sed -i "s/'\.\/App'/'.\/scenes\/app'/" src/index.tsx
sed -i "s/'\.\/App'/'..\/..\/src\/scenes\/app.css'/" test/scenes/app.test.tsx

## add return types
sed -i "s/function \w*(.*)/&: void/" src/serviceWorker.ts

# install packages
npm install -D eslint prettier eslint-plugin-react eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
npm install -D pre-commit

# add scripts
NPM_SCRIPTS='"lint": "eslint --ext ts --ext tsx --quiet src test",\n'
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\//\\\//g')
NPM_SCRIPTS=$(echo $NPM_SCRIPTS | sed 's/\"/\\\"/g')
sed -i "/\"test\": \"react-scripts test\"/ s/.*/${NPM_SCRIPTS}&/" package.json

# add pre-commit
PRECOMMIT='"pre-commit": [\n"lint",\n"test",\n"build"],\n'
PRECOMMIT=$(echo $PRECOMMIT | sed 's/\"/\\\"/g')
sed -i "/\"devDependencies\": {/ s/.*/${PRECOMMIT}\n&/" package.json

# download files
wget -q -P src/scenes https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/app.tsx
wget -q -P src/res https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/string-res.ts
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/.editorconfig
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/.eslintrc.js
wget -q -P .vscode https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/settings.json

# format package.json
npx prettier package.json --write
npm run lint -- --fix

#setup git
git init
git add .
git commit -m "initialize project"