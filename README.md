# Vim profile

## Installation

### Windows

Start `cmd` as Administrator and run (assuming the repository is cloned at `C:\code\vim-profile`):

```
cd %LOCALAPPDATA%
mklink /D nvim C:\code\vim-profile
```

Install dependencies:

```
scoop install bat
```

## Initial configuration

- Install plugins (vim-plug):

  ```
  :PlugInstall
  ```

- Install coc extensions:

  ```
  :CocInstall coc-rust-analyzer
  ```
