# Vim profile

## Installation

### macOS

Symlink config directory (assuming the repository is cloned at `$HOME/Projects/vim-profile`):

```sh
ln -s "$HOME/Projects/vim-profile" "$HOME/.config/nvim"
```

Install dependencies:

```sh
brew install bat node ripgrep
```

### Windows

Start `cmd` as Administrator and run (assuming the repository is cloned at `C:\code\vim-profile`):

```
cd %LOCALAPPDATA%
mklink /D nvim C:\code\vim-profile
```

Install dependencies:

```
scoop install bat ripgrep
```

## Initial configuration

- Install plugins (vim-plug):

  ```
  :PlugInstall
  ```

- Install coc extensions:

  ```
  :CocInstall coc-rust-analyzer coc-tsserver
  ```

- Configure fzf default command to respect .gitignore. For this set the following environment variable:

  ```
  export FZF_DEFAULT_COMMAND='rg --files'
  ```
