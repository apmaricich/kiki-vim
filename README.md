# Kiki - Kakoune-inspired Shell Integration for Vim

[![GitHub](https://img.shields.io/github/license/apmaricich/kiki-vim)](https://github.com/apmaricich/kiki-vim/blob/main/LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/apmaricich/kiki-vim)](https://github.com/apmaricich/kiki-vim/commits/main)

Kiki is a Vim plugin that provides advanced shell integration, bringing the power of Kakoune's multi-cursor editing to Vim. It enables seamless interaction with your native shell without leaving the comfort of your editor, reducing context switching and improving workflow efficiency.

## Features

- **Shell Command Execution**: Execute shell commands directly from within Vim
  - Output can be displayed inline (in current document)
  - Output can be saved to scratch buffers
  - Commands can run in background threads
- **Executable Documentation**: Save shell commands and their output to files for creating executable documentation
- **Path Detection**: Automatic file and directory path detection
- **File Operations**: 
  - `ls -alh` the current detected path
  - `:edit` files at current detected paths
- **Persistent Storage**: 
  - Create and manage persistent topic files for storing generic information
  - Access to a persistent scratchpad with simple keyboard shortcuts

## Installation

### Using vim-plug (Recommended)

Add the following line to your `.vimrc`:

```vim
Plug 'apmaricich/kiki-vim'
```

Then run `:PlugInstall` in Vim.

### Manual Installation

Link or copy the plugin file to Vim's autoload directory:

```bash
ln -s /path/to/kiki-vim/plugin/kiki.vim ~/.vim/plugin/
```

## Getting Started

1. Install the plugin using one of the methods above
2. Add the following key binding to your `.vimrc`:
   ```vim
   " Enter kiki mode when you press \k
   map \k :KikiEnter<CR>
   ```
3. Start using Kiki by placing a command on a line with the prefix (default: `kiki `):
   ```
   kiki echo $PATH
   ```

## Usage

### Command Execution

Kiki works by identifying shell commands on the current line using a configurable prefix (default: `kiki `).

**Execute a command** by placing your cursor on a line containing:
```
kiki echo $PATH
```

Then use one of the following key mappings (after entering Kiki mode with `\k`):

- `<i>`: Execute and return inline
- `<s>`: Execute and return in scratch buffer  
- `<b>`: Execute in background
- `<l>`: `ls -alh` current path
- `<e>`: Edit file at current path
- `<t>`: Open topic file with name
- `<,>`: Open scratchpad

### Quick Command Insertion

- `<c>`: Insert prefix and enter insert mode for a new command
- `<C>`: Insert prefix on existing line

## Configuration

Customize Kiki behavior by setting these variables in your `.vimrc`:

```vim
" Change the kiki prefix (must be unique to avoid conflicts)
let g:kiki_prefix = "kiki "

" Set scratchpad file location
let g:kiki_scratch = "~/.config/vim/kiki/scratchpad.kiki"

" Set topics directory location  
let g:kiki_topics = "~/.config/vim/kiki/"
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.