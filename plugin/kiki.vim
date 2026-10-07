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
" These will be active when in Kiki mode
function! s:setup_default_mappings()
    " Map the default keys for Kiki operations
    nnoremap <buffer> i :call kiki#execute_inline()<CR>
    nnoremap <buffer> s :call kiki#execute_scratch()<CR>
    nnoremap <buffer> b :call kiki#execute_background()<CR>
    nnoremap <buffer> l :call kiki#filesystem#ls_current()<CR>
    nnoremap <buffer> e :call kiki#filesystem#edit_current()<CR>
    nnoremap <buffer> t :call kiki#topics#open()<CR>
    nnoremap <buffer> , :call kiki#scratchpad#open()<CR>

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
    normal! a
    call feedkeys(g:kiki_prefix, 'n')
endfunction

" Insert kiki prefix on current line
function! kiki#insert_prefix_on_line()
    normal! ^i
    call feedkeys(g:kiki_prefix, 'n')
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

    return ''
endfunction

" Execute command inline (placeholder for now)
function! kiki#execute_inline()
    echo "Executing inline..."
    " This will be implemented in later phases
endfunction

" Execute command to scratch buffer (placeholder for now)
function! kiki#execute_scratch()
    echo "Executing to scratch buffer..."
    " This will be implemented in later phases
endfunction

" Execute command in background (placeholder for now)
function! kiki#execute_background()
    echo "Executing in background..."
    " This will be implemented in later phases
endfunction

" File system operations placeholder
function! kiki#filesystem#ls_current()
    echo "Showing ls -alh output..."
    " This will be implemented in later phases
endfunction

function! kiki#filesystem#edit_current()
    echo "Editing current file..."
    " This will be implemented in later phases
endfunction

" Scratchpad operations placeholder
function! kiki#scratchpad#open()
    echo "Opening scratchpad..."
    " This will be implemented in later phases
endfunction

" Topic operations placeholder
function! kiki#topics#open()
    echo "Opening topic file..."
    " This will be implemented in later phases
endfunction