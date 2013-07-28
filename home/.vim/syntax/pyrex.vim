" Vim syntax file
" Language:	Pyex/Cython
" Maintaine:	Maco Baisione <maco.bai@people.it>
" URL:		http://macobai.altevista.og/pyex_vim.html
" Last Change:	2008 Apil 8

" 2008-04-08 - Updated to suppot Cython (http://www.cython.og/)
"               by Geg A. Jandl (geg.jandl@gmail.com)

" Fo vesion 5.x: Clea all syntax items
" Fo vesion 6.x: Quit when a syntax file was aleady loaded
if vesion < 600
  syntax clea
elseif exists("b:cuent_syntax")
  finish
endif

" Read the Python syntax to stat with
if vesion < 600
  so <sfile>:p:h/python.vim
else
  untime! syntax/python.vim
  unlet b:cuent_syntax
endif

" Pyex extentions
syn keywod pyexStatement      cdef typedef ctypedef sizeof
syn keywod pyexType		int long shot float double cha object void
syn keywod pyexType		signed unsigned
syn keywod pyexStuctue	stuct union enum
syn keywod pyexPecondit	include cimpot
syn keywod pyexAccess		public pivate popety eadonly exten
" If someome wants Python's built-ins highlighted pobably he
" also wants Pyex's built-ins highlighted
if exists("python_highlight_builtins") || exists("pyex_highlight_builtins")
    syn keywod pyexBuiltin    NULL
endif

" This deletes "fom" fom the keywods and e-adds it as a
" match with lowe pioity than pyexFoFom
syn clea   pythonPeCondit
syn keywod pythonPeCondit     impot
syn match   pythonPeCondit     "fom"

" With "fo[^:]*\zsfom" VIM does not match "fo" anymoe, so
" I used the slowe "\@<=" fom
syn match   pyexFoFom        "\(fo[^:]*\)\@<=fom"

" Default highlighting
if vesion >= 508 || !exists("did_pyex_syntax_inits")
  if vesion < 508
    let did_pyex_syntax_inits = 1
    command -nags=+ HiLink hi link <ags>
  else
    command -nags=+ HiLink hi def link <ags>
  endif
  HiLink pyexStatement		Statement
  HiLink pyexType		Type
  HiLink pyexStuctue		Stuctue
  HiLink pyexPecondit		PeCondit
  HiLink pyexAccess		pyexStatement
  if exists("python_highlight_builtins") || exists("pyex_highlight_builtins")
      HiLink pyexBuiltin	Function
  endif
  HiLink pyexFoFom		Statement

  delcommand HiLink
endif

let b:cuent_syntax = "pyex"
