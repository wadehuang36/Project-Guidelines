# SWARM React Guidelines

## Development Requirements:
- [nodejs](https://nodejs.org/en/download/current/)

## Initialize a new project
we create a creator.sh to help creating and setting a new react project. 
Use this command to initialize a new project.
``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/react/creator.sh)"
```

## File Structure
- src: the source code folder
  - res: the resource folder
    - images: the images folder
    - fonts: the fonts folder
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
    - api-service.ts

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
// ./src/res/string-res.ts
export const StringRes = {
  app: {
    title: "Edit <code>src/App.tsx</code> and save to reload.",
    linkUrl: "https://reactjs.org",
    linkText: "Learn React"
  }
}
```

## Environments
We recommend using [env-cmd](https://github.com/toddbluhm/env-cmd) to manage the environmental variables. These is a example how we use.

- Put environmental variables on **.env-cmdrc** file.
```json
    "default": {
        "REACT_APP_GOOGLE_CLIENT_KEY": "GOOGLE_CLIENT_KEY"
    },
    "local": {
        "REACT_APP_API_URL": "http://localhost:4200"
    },
    "qa": {
        "REACT_APP_API_URL": "https://qa.api.com"
    },
    "prod": {
        "REACT_APP_API_URL": "https://api.com"
    }
```

> **react-scripts** only passes environmental variables to the app if the prefix is **REACT_APP_**

- Use the environmental variables
``` ts
// put all environmental variables in one object.
export const Env = {
    apiUrl: process.env["REACT_APP_API_URL"],
    googleClientKey: process.env["REACT_APP_GOOGLE_CLIENT_KEY"]
}

// so it makes accessing environmental variables easier
export class ApiService {
  baseUrl = Env.apiUrl;
}

export class GoogleMapService {
  clientKey = Env.googleClientKey;
}
```

## Pre commit
We use the package [pre-commit](https://github.com/observing/pre-commit) to add a git pre-commit hook to check the code quality before commit. The hook executes these commands
- npm run lint: use eslint to check code pass the rules
- npm run test: check project pass the tests
- npm run build: check project can build

If one of three commands fails, the commit fails. If you want to temporarily force commit. you can use `git commit` with `--no-verify` or `-n` option to the skip hook. However, the build server will run these three commands again when a new pull request is created.

## Sample Projects
- [Incident Wall (Private)](https://gitlab.com/swarmnyc/incident-code-wall)

## VS Code Extensions
- [eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)