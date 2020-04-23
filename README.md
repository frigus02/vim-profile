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

- Configure fzf default command to respect .gitignore. For this set the following environment variable:

  ```
  export FZF_DEFAULT_COMMAND='rg --files'
  ```

- Install minpac package manager:

  ```sh
  git clone https://github.com/k-takata/minpac.git pack/minpac/opt/minpac
  ```

- Install plugins (minpac):

  ```
  call minpac#update()
  ```

- Install coc extensions:

  ```
  :CocInstall coc-rust-analyzer coc-tsserver
  ```
