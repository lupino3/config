" .vimrc
" by Andrea Spadaccini <andrea.spadaccini@gmail.com>
"
" Based on an old vimrc.example.

" Vim Settings
" -----------------------------------------------------------------------------

" Remove compatibility with vi.
set nocompatible
set grepprg=grep\ -nH\ $*

" Set up Vundle plugins. Instructions to bootstrap this at
" https://github.com/gmarik/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle must manage itself.
Plugin 'gmarik/Vundle.vim'

" Syntax checking plugin.
Bundle 'scrooloose/syntastic'

" Cool and lightweight status line.
Plugin 'bling/vim-airline'

" Git integration.
Plugin 'tpope/vim-fugitive'

" Sensible defaults.
Plugin 'tpope/vim-sensible'

" Toggle, display and navigate marks.
Plugin 'kshenoy/vim-signature'

" Align text in tabular format.
Plugin 'godlygeek/tabular'

" Markdown plugin.
Plugin 'plasticboy/vim-markdown'

" Diff from VCS
Plugin 'mhinz/vim-signify'

" Color scheme
Plugin 'nanotech/jellybeans.vim'

" JS beautifiers.
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'
call vundle#end()
filetype plugin indent on
" Done setting up Vundle.

" Mapping for jsbeautify
map <c-f> :call JsBeautify()<CR>

" Airline configuration.
set t_Co=256
let g:airline_powerline_fonts = 1

" Syntastic configuration.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1

" Dark background color. Leads to brighter fonts.
set background=dark

" Colorscheme
colo jellybeans

" Line numbers
set number

" Tabs become 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2

" History of 10000 commands
set history=10000

" Display commands as you type them
set showcmd

" Set ignorecase and smartcase (ignore case in searches, except if I
" explicitly use uppercase characters).
set ignorecase
set smartcase

" Window minimum height set to zero, so that when you have multiple windows you
" are not forced to see one row for each file.
set wmh=0

" Max text width: 78 columns.
set textwidth=78

" When inserting a closing parenthesis, briefly flash the closed one
set showmatch

" Used to open quickfix errors in new windows
set switchbuf=split

" Backup in /tmp
set bdir=/tmp,.

" Fix for pyflakes, that screws the quickfix window.
let g:pyflakes_use_quickfix = 0

" Persistent undo
if v:version >= 703
    set undofile
endif

" Key mappings
" -----------------------------------------------------------------------------

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Call man for the word under the cursor
map <F1> :exe ":!man ".expand("<cword>")<CR>

" Move to the directory of the file in the current buffer
map <F4> :cd %:p:h<CR>

" Run make
map <F5> :make<CR>

" Toggle color column
function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=+1
  endif
endfunction

" Toggle folding with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Temporary hack
map <silent> <F10> :SyntasticCheck<CR>

map <F9> :call g:ToggleColorColumn()<CR>

" Toggle spell checking
map <F12> :setlocal spell! spelllang=en_us<CR>

" Use <C-J> (resp. <C-K>) to move one window up (resp. down) and maximize the
" new window
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
imap <C-J> <Esc><C-J>a
imap <C-K> <Esc><C-K>a

" Use <C-L> (resp. <C-H>) to move to the next (resp. previous) tab.
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>

" Lets the backspace key start a new undo sequence
inoremap <C-H> <C-G>u<C-H>

" Allows j and k keys to move even inside wrapped lines
map j gj
map k gk

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Functions
" -----------------------------------------------------------------------------
function! s:LookupPythonModule()
    let l:module_name = expand("<cword>")
    let l:cmd = "/usr/bin/python -c 'import " . l:module_name . "; print " .  l:module_name . ".__file__[:-1]'"
    let l:module = system(l:cmd)
    try
        exe "sp " . l:module
    catch /E172:/
        echo "Not a module, or maybe a builtin module. Couldn't reach it, sorry."
    endtry
endfunction

" Autocommands
" -----------------------------------------------------------------------------

if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    " Forced file types for some extensions
    au BufNewFile,BufRead *.thtml setfiletype php
    au BufNewFile,BufRead *.tex setfiletype tex
    au BufNewFile,BufRead *.as setfiletype actionscript
    au BufNewFile,BufRead *.todo setfiletype mkd

    " Filetype-dependent autocommands
    au FileType java set makeprg=ant\ -emacs
    au FileType python match errorMsg /^\t+/
    au FileType python set makeprg=pep8\ --repeat\ %

    au FileType python command! LookupPythonModule :call <SID>LookupPythonModule()
    au Filetype python map <F7> :LookupPythonModule<CR>
    " If there is a local .lvimrc file, source it (useful for project-related vim
    " settings)
    au BufRead,BufNewFile * let x=expand('%:p:h')."/.lvimrc" | if filereadable(x) | exe "source ".substitute(x, ' ', '\\ ', 'g') | endif
    let x=expand('%:p:h')."/.lvimrc" | if filereadable(x) | exe "source ".substitute(x, ' ', '\\ ', 'g') | endif
endif

" Read a local .local_vimrc, if it exists.
if filereadable(expand("~/.local_vimrc"))
  exe "source ".expand("~/.local_vimrc")
endif

" Have % match angle brackets as well.
set matchpairs+=<:>

" Move home row fingers to the standard typing position.
noremap ; l
noremap l k
noremap k j
noremap j h
