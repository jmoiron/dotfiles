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
set modeline

" don't redraw the screen so much during macros
set lazyredraw

" show matching [{()}]
" set showmatch

" don't use Ex mode, use Q for formatting
map Q gq

execute pathogen#infect()

" switch syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  syntax enable
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  autocmd FileType yaml setlocal sw=2 ts=2
  filetype plugin indent on

  " run black on save for python
  autocmd BufWritePost *.py silent! execute ':Black'
  
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


" ctrl-p

" put the ctrl-p window on the top, ordering top-to-bottom, 15 results
" let g:ctrlp_match_window = 'top,order:ttb,min:1,max:15,results:15'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_user_command = ['.git']

" map <leader>p :CtrlPBufTagAll<cr>

set wildignore +=*.pyc,*.zip,.git,.hg,.svn,node_modules,_workspace

" set ofu=syntaxcomplete#Complete
" set completeopt=longest,menuone
set completeopt=menuone,noinsert

" make enter just select the current completion choice
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" make c-n behave a bit nicer
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" simulate omni-complete with M-space
"inoremap <expr> <C-space> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

set cursorline
" disable visual bell
set novisualbell
set noerrorbells
set vb t_vb=
autocmd! GUIEnter * set vb t_vb=


if has("gui_running")
    " set guifont=Consolas\ 10
    " set guifont=Menlo\ 9
    " set guifont=Droid\ Sans\ Mono\ 9
    " set guifont=Inconsolata\ 11
    " set linespacing to 0
    if has("gui_macvim")
        set guifont=Consolas:h14
    else
        "set guifont=Droid\ Sans\ Mono\ 9
        "set guifont=Office\ Code\ Pro\ 11
        set guifont=Consolas\ 10.5
    endif

    set lsp=0
    " remove menus, toolbars
    set guioptions-=m
    set guioptions-=T
    " set the default size to something respectable
    au GUIEnter * set lines=45 columns=130
    " ~~ taglist plugin ~~
    " map <F12> <ESC>:Tlist<CR>
endif

" TODO: use real snippets
map <F2> <ESC>oimport ipdb; ipdb.set_trace();<ESC>:w<CR>
map <F4> <ESC>i#!/usr/bin/env python<CR># -*- coding: utf-8 -*-<CR><CR>""" """<CR><ESC>

" blame lines selected in visual mode
vmap gk :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
set mouse=a
set ttymouse=xterm2

if filereadable($HOME .  "/.vimrc.local")
    exec ':so ' . $HOME . "/.vimrc.local"
endif

" disable bracketed paste
set t_BE=

let g:rehash256 = 1
set novb

" vim-go stuff
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = 'quickfix'
let g:go_jump_to_error = 0
let g:go_auto_type_info = 1

map <leader>c :GoCoverageToggle<cr>
map <leader>t :GoTest!<cr>
map <leader>x :ccl<cr>
map <leader>s :Pt<cr>
map <leader>b :Buffers<cr>

autocmd Syntax * syntax keyword Todo DEPRECATED containedin=.*Comment

if has("gui_running")
    "let mycolors = ['peel', 'tribal', 'peacock', 'juicy', 'super', 'flattr',
    "               \'snappy-contrast', 'rainbow', 'frontier-contrast',
    "               \'darkside', 'tonic', 'gloom-contrast']
    "let choice = mycolors[localtime() % len(mycolors)]
    "exe 'colo ' . choice
    "unlet mycolors
    "unlet choice
    " colo muon
    " colo flattr
    colo palenight
else
    colo seoul256
endif

if !empty($VIM_COLO)
    colo $VIM_COLO
endif

call togglebg#map("<F6>")

" fzf and pt
nmap <silent> <C-p> :FZF<CR>
let g:fzf_layout = { 'down': '~30%' }

if executable('pt')
    let g:ackprg = 'pt --nogroup --nocolor'
    set grepprg=pt\ --nogroup\ --nocolor
endif

command! -bang -nargs=* Pt
  \ call fzf#vim#grep(
  \   'pt --column --numbers --color --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

noremap <leader># :Pt <c-r><c-w><cr>

" coc.vim settings

let g:black_linelength = 120

