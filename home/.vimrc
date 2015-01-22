" jmoiron's vimrc
" ideas, etc pulled from all over the internets
"

" use vim settings
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set number
" no backup files
set nobackup
set history=50      
" show the cursor position all the time
set ruler
set showcmd
set incsearch

set noswapfile
set nowritebackup

" don't redraw the screen so much during macros
set lazyredraw

" show matching [{()}]
" set showmatch

" don't use Ex mode, use Q for formatting
map Q gq

" switch syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  filetype plugin indent on
  
  augroup vimrcEx
  au!
      " for all text files set 'textwidth' to 78 characters.
      autocmd FileType text setlocal textwidth=78
      " when editing a file, always jump to the last known cursor position.
      autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
  augroup END
endif " has("autocmd")

" open a buffer in a new window; close it first
function! OpenBufNewGvim()
  let w:obng_filename = bufname("%")
  bd! 
  silent exe "!gvim " w:obng_filename
endfun

map gn :call OpenBufNewGvim()<CR>

set autoindent

" smart auto-selection of filetypes for '*.htm[l]' files
" via armin ronacher, modified to (mostly) work for mako
fun! s:SelectHTML()
  let n = 1
  while n < 50 && n < line("$")
    " check for mako
    if getline(n) =~ '<%\s*\(doc\|inherit\|def\)\>'
       set ft=mako
       return 
    endif
    " check for jinja
    if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=htmljinja
      return
    endif
    " check for django (prioritize jinja over django)
    if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\|blocktrans\)\>'
      set ft=htmldjango
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.less setlocal ft=less
autocmd BufNewFile,BufRead *.jinja setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.html,*.htm call s:SelectHTML()
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" use 4 space tabs (these are overriden for Makefiles)
set tabstop=4
set shiftwidth=4
set wm=4
set expandtab

" set extra python highlight syntax to on
let python_highlight_all = 1
set smarttab
set formatoptions=1
set nolbr

" ~~ buftabs extention ~~
" do not display full path in buftabs
:let g:buftabs_only_basename=1
" display the buffers in the status bar
set laststatus=2
:let g:buftabs_in_statusline=1
:let g:buftabs_ordinal=1
:let g:fuzzy_roots=["."]
" fuzzy file finder uses File.fnmatch underneath
" http://www.ruby-doc.org/core-2.0/File.html#method-c-fnmatch
:let g:fuzzy_ignore="*.pyc;*.swp;*.gif;*.png;**node_modules**;**lib/bootstrap**;**/migrations/**"

" ctrl-h to kill the search highlight
nmap <silent> <C-H> :silent noh<CR>
" ctrl-n to toggle line numbers
nmap <silent> <C-N> :set invnumber<CR>
nmap <leader>t :FuzzyFinderTextmateRefreshFiles<CR>

" ~~ screen style keymapping ~~
set hidden
noremap <C-TAB> :bnext!<CR>
noremap <C-S-TAB> :bprev!<CR>
noremap <C-\> :b#<CR>
noremap <C-A>n :bn!<CR>
noremap <C-A>p :bprev!<CR>
noremap <C-A>c :new\|only<CR>
noremap <C-A>x :BD!<CR>


" use utf-8 at all times
set enc=utf-8

" set cmdheight=1
" set laststatus=2
" set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w

" map old fuzzy finder textmate keys to ctrlp
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:15,results:15'
let g:ctrlp_working_path_mode = 0
set wildignore +=*.pyc,*.zip,.git,.hg,.svn,node_modules,_workspace
map <F3> :CtrlP<CR>

set ofu=syntaxcomplete#Complete
set completeopt=longest,menuone

" make enter just select the current completion choice
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" make c-n behave a bit nicer
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" simulate omni-complete with M-space
"inoremap <expr> <C-space> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" gvim only options:
" gruvbox only behaves when jellybeans has been loaded..
" colo gruvbox
colo jellybeans
set cursorline

if has("gui_running")
    " colo summerfruit
    " colo github
    " colo Tomorrow-Night-Blue
    " colo railscasts " dark
    " colorscheme ir_black " dark
    " colo fruidle " light 
    " set guifont=Consolas\ 10
    " set guifont=Menlo\ 9
    " set guifont=Droid\ Sans\ Mono\ 9
    " set guifont=Inconsolata\ 11
    " set linespacing to 0
    if has("gui_macvim")
        set guifont=Consolas:h14
    else
        "set guifont=Droid\ Sans\ Mono\ 9
        set guifont=Consolas\ 11.5
    endif

    set lsp=0
    " remove menus, toolbars
    set guioptions-=m
    set guioptions-=T
    " set the default size to something respectable
    au GUIEnter * set lines=45 columns=130
    " ~~ taglist plugin ~~
    " map <F12> <ESC>:Tlist<CR>
    colo flattr
endif

map <F2> <ESC>oimport ipdb; ipdb.set_trace();<ESC>:w<CR>
map <F4> <ESC>i#!/usr/bin/env python<CR># -*- coding: utf-8 -*-<CR><CR>""" """<CR><ESC>

" svn blame lines selected in visual mode with 'gl'
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap gk :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

set mouse=a
set ttymouse=xterm2

if filereadable($HOME .  "/.vimrc.local")
    exec ':so ' . $HOME . "/.vimrc.local"
endif

let g:rehash256 = 1

if !empty($VIM_COLO)
    colo $VIM_COLO
endif

execute pathogen#infect()
" set runtimepath^=~/.vim/bundle/ctrlp.vim


