

## Getting Started

### Requirements

- Dart: 3.0.1
- Flutter SDK: 3.10.1
- Melos: 2.8.0


### Install

- WARN: If you already installed `melos`and `make` comands, you could omit this step.

- Install melos:
    - Run `dart pub global activate melos`

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


