# .Net Guideline

## Install DotNet Core SDK
https://dotnet.microsoft.com/download/dotnet-core

## Install useful dotnet tools
``` bash
dotnet tool install dotnet-format
dotnet tool install dotnet-scripts
```

## Initialize a Project
use creator.sh
``` bash
curl -sL https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/creator.sh | bash -
```

## Styles
when you use creator.sh to create the project, the project applied FxCop and StyleCop and downloaded the .editorconfig. Therefore, when you use VS or VS Code. Tools will format the code and tell you where is wrong


### Suppress the style and analysis errors
if you want to suppress the errors temporarily, you can use this command 
``` bash
dotnet build -p:TreatWarningsAsErrors=false; dotnet run --no-build
```

## Before Push
run format to see it is well format and run build to see any errors.
``` bash
dotnet format
dotnet build
```
> NOTE: we treat warning as error