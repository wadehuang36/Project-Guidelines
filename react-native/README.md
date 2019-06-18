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