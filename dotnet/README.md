# .Net Guideline

## Development Requirements:
- [dotnet core sdk](https://dotnet.microsoft.com/download/dotnet-core)
- [dotnet format](https://github.com/dotnet/format)
- [dotnet script](https://github.com/filipw/dotnet-script) (Optional)

## Initialize a new project
we create a creator.sh to help creating and setting a new dotnet project. 
Use this command to initialize a new project.
``` bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swarmnyc/SWARM-Project-Guidelines/master/dotnet/creator.sh)"
```
> For windows users, use WSL to run the creator.sh.

## Styles
when you use creator.sh to create the project, the project applied FxCop and StyleCop and downloaded the .editorconfig. Therefore, when you use VS or VS Code. Tools will format the code and tell you where are wrongs.

We use the styles more like Java and JavaScript in C# such as "braces in the same line" and "2 space indent". For others, we follow the [C# conventions](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/). 

These is the example for styles.
``` CS
// Good
namespace Test {
  public static class Program {
    public static void Main() {
      Console.WriteLine("Hello World!");
    }
  }
}

// Bad
namespace Test 
{
    class program 
    {
        static void main(String[] args) 
        {
            Console.WriteLine("Hello World!");
        }
    }
}

/*
Errors:
1. Start-brace should be after statements.
2. Use 2 spaces indent instead of 4.
3. Class name and Function Name should be PascalCasing.
4. Class and Function should have a access modifier.
5. If a class only contain static functions and properties, it should be static as well.
6. Should use built-in type alias like "string" instead of "String".
7. Parameter "args" never be used in function body which should be removed.
*/
```

### Suppress the style and analysis errors
if you want to suppress the errors temporarily, you can use this command 
``` bash
dotnet build -p:TreatWarningsAsErrors=false; dotnet run --no-build
```

## Before create a pull request
Before you create a pull request, running format to make all code well format and building and testing to make sure no any errors. Because our CI server will run these commands. The pull request will be rejected, if there is a file change or a error.

``` bash
dotnet format
dotnet build
dotnet test
```
> NOTE: we treat warning as error

## Sample projects
- [Swarm.TaskRunner](https://github.com/swarmnyc/Swarm.TaskRunner)

