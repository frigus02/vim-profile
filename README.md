# Vim profile

## Installation

Create init.vim:

```
cp init.vim.sample init.vim
```

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

In WSL, download and add [win32yank.exe](https://github.com/equalsraf/win32yank) to the PATH to enable system clipboard integration. See also [Neovim Wiki](https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl).

## Initial configuration

- Configure fzf default command to respect .gitignore. For this set the following environment variable:

  ```
  export FZF_DEFAULT_COMMAND='rg --files --hidden --iglob !.git'
  ```

- Install minpac package manager:

  ```sh
  git clone https://github.com/k-takata/minpac.git pack/minpac/opt/minpac
  ```

- Install plugins (minpac):

  ```
  call minpac#update()
  ```

- Install language servers, e.g.:

  ```
  # tsserver
  npm install -g typescript typescript-language-server

  # rust_analyzer
  curl -LO https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-x86_64-unknown-linux-gnu.gz
  gunzip rust-analyzer-*
  chmod +x rust-analyzer-*
  mv rust-analyzer-* ~/.local/bin/rust-analyzer
  ```
