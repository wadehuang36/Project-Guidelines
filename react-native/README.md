# SWARM React Native Guidelines

## Initial the project
``` bash
# use react native CLI to create a new project with typescript
npx react-native init <ProjectName> --template typescript
cd <ProjectName>

# create folders and move default files
mkdir app app/src app/src/scenes app/src/services app/src/models app/src/utils app/res/ app/res/images app/res/fonts
mv __tests__ app
mv App.tsx app/src ## need to change the path of import App on index.js

# download the files for editors like VS code
wget https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/ReactNative/.editorconfig
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
    - tests: the test code folder
       
## Naming Styles
- For File Names and Folder Names use kebab-case, for example, `the-file-name.tsx`
- For Class Names, use PascalCase, for example, `class User { }`

## Code Styles

## Resource Styles


## Libraries
