" Kiki - Kakoune-inspired Shell Integration for Vim
" Author: Alexander Maricich
" License: MIT

if exists('g:loaded_kiki') || &compatible
    finish
endif
let g:loaded_kiki = 1

" Default configuration options
if !exists('g:kiki_prefix')
    let g:kiki_prefix = "kiki "
endif

if !exists('g:kiki_scratch')
    let g:kiki_scratch = "~/.config/vim/kiki/scratchpad.kiki"
endif

if !exists('g:kiki_topics')
    let g:kiki_topics = "~/.config/vim/kiki/"
endif

" Initialize Kiki mode
command! KikiEnter call kiki#enter_mode()
command! KikiExit call kiki#exit_mode()

" Set up default key mappings for Kiki mode
function! s:setup_default_mappings()
    " Map the default keys for Kiki operations
    nnoremap <buffer> i :call kiki#execute_inline()<CR>
    nnoremap <buffer> s :call kiki#execute_scratch()<CR>
    nnoremap <buffer> b :call kiki#execute_background()<CR>
    nnoremap <buffer> l :call kiki#filesystem_ls_current()<CR>
    nnoremap <buffer> e :call kiki#filesystem_edit_current()<CR>
    nnoremap <buffer> t :call kiki#topics_open()<CR>
    nnoremap <buffer> , :call kiki#scratchpad_open()<CR>

    " Quick command insertion
    nnoremap <buffer> c :call kiki#insert_prefix()<CR>
    nnoremap <buffer> C :call kiki#insert_prefix_on_line()<CR>
endfunction

" Enter Kiki mode function
function! kiki#enter_mode()
    echo "Entering Kiki mode. Use <Esc> to exit."
    call s:setup_default_mappings()
endfunction

" Exit Kiki mode function
function! kiki#exit_mode()
    echo "Exiting Kiki mode."
    " Remove the mappings when exiting
    silent! nunmap <buffer> i
    silent! nunmap <buffer> s
    silent! nunmap <buffer> b
    silent! nunmap <buffer> l
    silent! nunmap <buffer> e
    silent! nunmap <buffer> t
    silent! nunmap <buffer> ,
    silent! nunmap <buffer> c
    silent! nunmap <buffer> C
endfunction

" Insert kiki prefix at cursor position
function! kiki#insert_prefix()
    " Get current line content and cursor position (1-based)
    let line_content = getline('.')
    let cursor_pos = col('.')  " col() returns 1-based position
    
    " Insert prefix at current cursor position using string replacement
    let prefix = g:kiki_prefix
    let new_line = strpart(line_content, 0, cursor_pos - 1) . prefix . strpart(line_content, cursor_pos - 1)
    
    " Replace the line with the modified content
    call setline('.', new_line)
    
    " Move cursor to after the inserted prefix (cursor position + length of prefix)
    call cursor(line('.'), cursor_pos + len(prefix))
endfunction

" Insert kiki prefix on current line
function! kiki#insert_prefix_on_line()
    " Simply prepend the prefix at the beginning of current line
    let prefix = g:kiki_prefix
    let line_content = getline('.')
    call setline('.', prefix . line_content)
    
    " Move cursor to end of prefix (1-based position)
    call cursor(line('.'), len(prefix) + 1)
endfunction

" Select text after the kiki prefix
function! kiki#select_after_prefix()
    let line = getline('.')
    let prefix = g:kiki_prefix

    " Find the position of the prefix
    let pos = stridx(line, prefix)
    if pos >= 0
        let command = strpart(line, pos + len(prefix))
        return command
    endif
    
    " If no prefix found, try to detect file paths anywhere in the line (simple approach)
    " Just look for simple path patterns without complex regex matching
    let words = split(line, '\s\+')
    for word in words
        " Check if it looks like a file path (has an extension or relative/absolute path structure)
        if word =~ '^\./' || word =~ '^../' || word =~ '^/' || word =~ '^[^/]\+\.\w\+$'
            return word
        endif
    endfor
    
    " If no path found at all, return empty string as before
    return ''
endfunction

" Execute command inline - direct implementation
function! kiki#execute_inline()
    let command = kiki#select_after_prefix()
    if command != ''
        " Direct implementation instead of autoload to avoid issues
        let output = system(command)
        
        " Move cursor to end of current line and get the line content
        normal! $
        
        " Add a newline for clean separation
        normal! o
        
        " Insert the output directly without using feedkeys (which can be problematic)
        call append(line('.'), split(output, '\n'))
    else
        echo "No command found after prefix"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

" Execute command to scratch buffer - direct implementation
function! kiki#execute_scratch()
    let command = kiki#select_after_prefix()
    if command != ''
        " Direct implementation instead of autoload to avoid issues
        execute 'new'
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        setlocal readonly

        let output = system(command)
        normal! G
        call append(line('.'), split(output, '\n'))

        execute 'file [Kiki Scratch]'
    else
        echo "No command found after prefix"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

" Execute command in background - direct implementation
function! kiki#execute_background()
    let command = kiki#select_after_prefix()
    if command != ''
        " Direct implementation instead of autoload to avoid issues
        echo "Background execution not fully implemented yet"
        " In a real implementation, this would use jobstart()
    else
        echo "No command found after prefix"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

" File system operations - using the function names that match file structure
function! kiki#filesystem_ls_current()
    " Direct implementation instead of autoload to avoid issues
    let path = kiki#select_after_prefix()
    if path != ''
        execute 'new'
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        setlocal readonly

        let command = 'ls -alh ' . shellescape(path)
        let output = system(command)
        normal! G
        call append(line('.'), split(output, '\n'))

        execute 'file [Kiki ls -alh]'
    else
        echo "No path detected"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

function! kiki#filesystem_edit_current()
    " Direct implementation instead of autoload to avoid issues
    let path = kiki#select_after_prefix()
    if path != ''
        " Resolve relative paths properly using expand() and fnamemodify()
        let resolved_path = expand(path, 1)
        if !filereadable(resolved_path) && !isdirectory(resolved_path)
            echo "File not found: " . path
            return
        endif
        execute 'edit' resolved_path
    else
        echo "No path detected"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

" Scratchpad operations - direct implementation
function! kiki#scratchpad_open()
    " Direct implementation instead of autoload to avoid issues
    let scratch_path = expand(g:kiki_scratch)
    let dir = fnamemodify(scratch_path, ':h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
    " Create the file if it doesn't exist yet (this will allow editing even when the file doesn't exist)
    if !filereadable(scratch_path)
        " Create empty file for editing
        execute 'edit' scratch_path
    else
        execute 'edit' scratch_path
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction

" Topic operations - direct implementation
function! kiki#topics_open()
    " Direct implementation instead of autoload to avoid issues
    let command = kiki#select_after_prefix()
    if command != ''
        let topic_file = g:kiki_topics . command . '.kiki'
        let topic_path = expand(topic_file)
        let dir = fnamemodify(topic_path, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
        execute 'edit' topic_path
    else
        echo "No topic specified"
    endif
    " Exit Kiki mode after execution
    call kiki#exit_mode()
endfunction