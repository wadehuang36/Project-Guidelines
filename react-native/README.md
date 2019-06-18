# SWARM React Native Guidelines

## Development Requirements:
- [nodejs](https://nodejs.org/en/download/current/)

## Initialize a new project
we create a creator.sh to help creating and setting a new react-native project. 
Use this command to initialize a new project.
``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react-native/creator.sh)"
```

## File Structure
- android: the folder for native android
- ios: the folder for native ios 
- app: the folder for react native
  - res: the resource folder
    - images: the images folder
    - fonts: the fonts folder
  - src: the source code folder
    - core: the folder for core code
    - scenes: the folder for different scenes, for example,
      - home:
        - home-main.tsx
        - home-search.tsx
        - home-list.tsx
      - detail:
        - detail-main.tsx
        - detail-xxx.tsx
    - services: the folder for service code, for example,
      - api-service
  - test: the test code folder

## Typescript
We build react native apps with [typescript](https://www.typescriptlang.org/index.html) to help projects more readable and debugging easier.

## Naming Styles
- For File Names and Folder Names use KebabCase, for example, `the-file-name.tsx`. the main reason for KebabCase is for the convention of module name. for example, `import { SomeThing } from "./some-thing"`
- For Type Names like class, interface, use PascalCase, for example, `class User { }`
- For variables, function, use CamelCase, for example, `var userName: string`

## Code Styles
- No semicolon. Nowadays new languages such as Kotlin, Swift recommend no semicolon on the end of statements.
- Double-Quote. We use double-quote instead of single-quote. 

We use eslint and prettier to check the styles. IDE like vscode detect the errors if you installed the extensions. Or you can run `npm run lint` to check manually.

## Resource Styles
We would like centralize resources under `res` folder and put to objects for using easily. 

For example,
``` ts
// ./app/res/string-res.ts
export const StringRes = {
  app: {
    // if resources are only belong to one scene, we group in one object
    welcome: "Welcome to React Native!",
    instruction: "To get started, edit app/src/scenes/app.tsx",
    instructions: Platform.select({
      ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
      android:
        'Double tap R on your keyboard to reload,\n' +
        'Shake or press menu button for dev menu'
    })
  },
  login: "Login",
  logout: "Logout"
}

// ./app/res/image-res.ts
export const ImageRes = {
  // using ic, bg or others prefix for icon and background for better identifying
  icAdd: require("./images/ic-add.png"),
  icDelete: require("./images/ic-delete.png")
}
```

## App Version
Unlike other projects, Android and iOS app has two version options:
- Version Code: a number that can only be increased. fails if uploading the same number to stores
- Version Name: a string that can be every string, stores accepts the same string.

We recommends use git commit count for version code, so the number can automatically increase for every commit. Also, manually change version name on package.json, so we just need to change one place.

On Android, adding the script is very easy. Change app.grade like below
``` gradle
def APP_VERSION_CODE = Integer.parseInt(System.getenv("APP_VERSION_CODE") ?: 'git rev-list --count HEAD'.execute().text.trim())
def APP_VERSION_NAME = System.getenv("APP_VERSION_NAME") ?: (new groovy.json.JsonSlurper().parseText(file("../../package.json").text)).version

android {
  defaultConfig {
    versionCode APP_VERSION_CODE
    versionName APP_VERSION_NAME
  }
```

On iOS, adding the script needs more steps.
1. create scripts/set_version.sh
``` sh
#!/bin/bash

if [ -z "$APP_VERSION_CODE" ]; then
  APP_VERSION_CODE=$(git rev-list HEAD --count)
fi

if [ -z "$APP_VERSION_NAME" ]; then
  APP_VERSION_NAME=$(node -p -e "require('./package.json').version")
fi

target_plist="$TARGET_BUILD_DIR/$INFOPLIST_PATH"
dsym_plist="$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Info.plist"

for plist in "$target_plist" "$dsym_plist"; do
  if [ -f "$plist" ]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $APP_VERSION_CODE" "$plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${APP_VERSION_CODE#*v}" "$plist"
  fi
done
```
2. change Build Phases to execute the script, you can follow this article [Automated Xcode version and build numbering via Git](https://www.mokacoding.com/blog/automatic-xcode-versioning-with-git/) to set up.

## Pre commit
We use the package [pre-commit](https://github.com/observing/pre-commit) to add a git pre-commit hook to check quality before commit. The hook executes there other commands
- npm run lint: use eslint to check code pass the rules
- npm run test: check project pass the tests
- npm run build: check project can build

If one of three commands fails, the commit fails. If you want to temporarily force commit. you can use commit with `--no-verify` option to skip hook. However, the build server will run these three commands again when a new pull request is created.

## Sample Projects
- [Incident Go (Private)](https://gitlab.com/swarmnyc/incident-code-app)

## VS Code Extensions
- [eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

## Developing Tools
- [React Native Debugger](https://github.com/jhen0409/react-native-debugger)