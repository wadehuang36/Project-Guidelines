# SWARM React Guidelines

## Development Requirements:
- [nodejs](https://nodejs.org/en/download/current/)

## Initialize a new project
we create a creator.sh to help creating and setting a new nodejs project. 
Use this command to initialize a new project.
``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/nodejs-web-api/creator.sh)"
```

## Fulton
[Fulton](https://github.com/swarmnyc/fulton) is a web-api library that we created to help our company to build web api. The 
- [express](https://expressjs.com/) 
- [inversify](http://inversify.io/)
- [passport](http://www.passportjs.org/)
- [typeorm](http://typeorm.io)
- [swagger](http://swagger.io)
- [winston](https://github.com/winstonjs/winston)

## Typescript
We build react native apps with [typescript](https://www.typescriptlang.org/index.html) to help projects more readable and debugging easier.

## Naming Styles
- For File Names and Folder Names use KebabCase, for example, `the-file-name.ts`. the main reason for KebabCase is for the convention of module name. for example, `import { SomeThing } from "./some-thing"`
- For Type Names like class, interface, use PascalCase, for example, `class User { }`
- For variables, function, use CamelCase, for example, `var userName: string`

## Code Styles
- No semicolon. Nowadays new languages such as Kotlin, Swift recommend no semicolon on the end of statements.
- Double-Quote. We use double-quote instead of single-quote. 

We use eslint and prettier to check the styles. IDE like vscode detect the errors if you installed the extensions. Or you can run `npm run lint` to check manually.

## Pre commit
We use the package [pre-commit](https://github.com/observing/pre-commit) to add a git pre-commit hook to check quality before commit. The hook executes there other commands
- npm run lint: use eslint to check code pass the rules
- npm run test: check project pass the tests
- npm run build: check project can build

If one of three commands fails, the commit fails. If you want to temporarily force commit. you can use commit with `--no-verify` option to skip hook. However, the build server will run these three commands again when a new pull request is created.

## Sample Projects
- [Incident API (Private)](https://gitlab.com/swarmnyc/incident-code-api)

## VS Code Extensions
- [eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)