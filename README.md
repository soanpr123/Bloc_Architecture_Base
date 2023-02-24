

#Clean Architecture

Flutter project using clean architecture and bloc pattern.

![Architecture](images/project_architecture.png?raw=true)


## Getting Started

### Requirements

- Dart: 2.19.1
- Flutter SDK: 3.7.1
- Melos: 2.8.0


### Install

- WARN: If you already installed `melos`and `make` comands, you could omit this step.

- Install melos:
    - Run `dart pub global activate melos 2.8.0`

- Export paths:
    - Add to `.zshrc` or `.bashrc` file
```    
export PATH="$PATH:<path to flutter>/flutter/bin"
export PATH="$PATH:<path to flutter>/flutter/bin/cache/dart-sdk/bin"
export PATH="$PATH:~/.pub-cache/bin"
export PATH="$PATH:~/.gem/gems/lefthook-0.7.7/bin"
```
    - Save file `.zshrc`
    - Run `source ~/.zshrc`

### Config and run app

- cd to root folder of project
- Run `make gen_env`
- Run `make sync`
- Run & Enjoy!


