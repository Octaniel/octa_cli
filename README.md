# Octa_Get Cli
## Descrição
A CLI flutter baseado em [**GetX**](https://pub.dev/packages/get),

### Instalação
requerido [Dart](https://dart.dev/get-dart) para rodar.
```sh
pub global activate -sgit https://github.com/Octaniel/octa_cli.git
```

### Criar Page
roda este comando em projecto Flutter
```sh
get oget criar page --nome="NomePage"
```
ou forma abreviada
```sh
get oget c p --n="NomePage"
```

### Criar Widget para um modulo
roda este comando em projecto Flutter
```sh
get oget criar wigdet nomePastaModel --name="NomeWidget"
```
ou forma abreviada
```sh
get oget c w nomePastaModel --n="NomeWidget"
```
### Criar Widget diretorio raiz
run the command in the flutter project directory
```sh
get oget criar wigdet common --n="NomeWidget"
```
ou forma abreviada
```sh
get oget c w --n="NomeWidget"
```

### Test phase feature
* ##### init
usa para criar projecto neste diretorio
```
get oget iniciar .
```

**Attention**
this command will overwrite some existing files. Do not use this command in an already started project


the next command should create a new project but at the moment it has flaws
 ``` 
getarctekko init my_fist_project
```

### Future Feature
* #### Intall
    Dependencies easy to install via the command line
* #### create binding
    generate initial binding structure
* #### init 
    generate all directories with a single command
* #### getx_pattern support
    generate code and directories basead on getx_pattern;