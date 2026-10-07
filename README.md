# Kiki - Kakoune-inspired Shell Integration for Vim

Kiki is a Vim plugin that provides advanced interactions with your native shell without leaving the comfort of your editor. It was designed to lessen the number of times you need to switch between your text editor and your terminal, as well as provide a simple workflow for getting things done.

**Kiki provides the following functionality:**
 - Execution of shell commands from within the editor. Output can be saved to:
   - Inline (in current document)
   - Scratch buffer
   - Background thread
 - Shell commands & output can be saved to any file allowing the creation of:
   - Documentation that is executable.
 - File and directory path detection.
 - `ls -al` the current detected path.
 - `:edit` the current detected path.
 - Allows the creation and storage of persistent topic files that can be used
   to store generic information.
 - Access to a persistent scratchpad that can be opened with a simple shortcut.

## Installing the plugin:

To install the plugin, link or copy the file to Vim's autoload directory:
```
$ ln -s /path/to/kiki-vim/plugin/kiki.vim ~/.vim/plugin/
```

Or using a plugin manager like vim-plug:
```
Plug 'path/to/kiki-vim'
```

Once installed, you can optionally bind the kiki mode to a key combination in your .vimrc:
```
" Enter kiki mode when you press \k
map \k :KikiEnter<CR>
```

## Usage

Kiki works by identifying shell commands on the current line using a configurable prefix (default: `kiki `).

### Executing a command:

To execute a command, place your cursor on a line containing:
```
kiki echo $PATH
```

Then use one of the following key mappings (after entering Kiki mode with `\k`):

- `<i>`: Execute and return inline
- `<s>`: Execute and return in scratch buffer  
- `<b>`: Execute in background
- `<l>`: ls -alh current path
- `<e>`: Edit file at current path
- `<t>`: Open topic file with name
- `<,>`: Open scratchpad

### Quick command insertion:

- `<c>`: Insert prefix and enter insert mode for a new command
- `<C>`: Insert prefix on existing line

## Configuration

You can configure Kiki by setting these variables in your .vimrc:

```vim
" Change the kiki prefix (must be unique to avoid conflicts)
let g:kiki_prefix = "kiki "

" Set scratchpad file location
let g:kiki_scratch = "~/.config/vim/kiki/scratchpad.kiki"

" Set topics directory location  
let g:kiki_topics = "~/.config/vim/kiki/"
```