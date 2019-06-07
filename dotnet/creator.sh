#!/bin/bash
set -e

ProjectRoot="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Enter the project info:"
read -p "Project Name: " ProjectName
read -p "Project Type(like console, webapi): " ProjectTemplate

mkdir $ProjectName
ProjectRoot="$ProjectRoot/$ProjectName"

cd $ProjectRoot
dotnet new sln
dotnet new $ProjectTemplate -o $ProjectName
dotnet new nunit -o $ProjectName.Tests

## run `dotnet new --help` to see the available templates

dotnet sln add $ProjectName
dotnet sln add $ProjectName.Tests

# download files for formatter and analyzers
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/.editorconfig

wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/omnisharp.json

wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/project.ruleset

# setup the project
cd $ProjectRoot/$ProjectName
dotnet add package --no-restore Microsoft.CodeAnalysis.FxCopAnalyzers
dotnet add package --no-restore StyleCop.Analyzers
mkdir src
mv *.cs src

# setup the test project
cd $ProjectRoot/$ProjectName.Tests 
dotnet add reference ../$ProjectName/
dotnet add package --no-restore Microsoft.CodeAnalysis.FxCopAnalyzers
dotnet add package --no-restore StyleCop.Analyzers
mkdir src
mv *.cs src

cd $ProjectRoot

# add analyzers config
AnalysisRule="\t<PropertyGroup>\n\t\t<TreatWarningsAsErrors>true</TreatWarningsAsErrors>\n\t\t<CodeAnalysisRuleSet>../project.ruleset</CodeAnalysisRuleSet>\n\t</PropertyGroup>\n"
AnalysisRule=$(echo $AnalysisRule | sed 's/\//\\\//g')
sed -i "/<\/Project>/ s/.*/${AnalysisRule}\n&/" $ProjectName/$ProjectName.csproj
sed -i "/<\/Project>/ s/.*/${AnalysisRule}\n&/" $ProjectName.Tests/$ProjectName.Tests.csproj

dotnet format

# setup git
wget -q https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/.gitignore
git init
git add .
git commit -m "initialize the project"