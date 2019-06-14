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
        - home-main-component
        - home-search-component
        - home-list-component
      - detail:
        - detail-main-component
        - detail-xxx-component
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

## Pre commit
We use the package [pre-commit](https://github.com/observing/pre-commit) 

## VS Code Extensions
- [eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

## Libraries

## Sample Projects
- [Incident Go (Private)](https://gitlab.com/swarmnyc/incident-code-app)