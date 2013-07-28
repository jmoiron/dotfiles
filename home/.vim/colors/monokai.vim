" Vim color file
" Maintainer:  Damien Gombault <desintegr@gmail.com>
" Last Change: 2008 Feb 09
" Version:     0.1

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "monokai"

hi Normal       guifg=#F8F8F2 guibg=#272822

" Highlight groups
hi Cursor       guibg=fg
"hi CursorIM
"hi CursorColumn
"hi CursorLine
hi Directory    guifg=#66D9EF gui=none
hi DiffAdd      guifg=bg guibg=#A6E22E
hi DiffChange   guifg=bg guibg=#E6DB74
hi DiffDelete   guifg=bg guibg=#F92672
hi DiffText     guifg=bg guibg=#E6DB74
hi ErrorMsg     guifg=#F92672 guibg=bg gui=none
hi VertSplit    guifg=bg guibg=bg gui=none
hi Folded       guifg=#75715E guibg=bg gui=none
hi FoldColumn   guifg=#75715E guibg=#3E3D32 gui=none
hi SignColum    guifg=#75715E guibg=#3E3D32 gui=none
hi IncSearch    guifg=bg guibg=#E6DB74 gui=none
hi LineNr       guifg=#75715E guibg=#3E3D32 gui=none
hi MatchParen   guifg=bg guibg=fg gui=bold
hi ModeMsg      gui=none
hi MoreMsg      guifg=#66D9EF gui=none
hi NonText      guifg=#3B3A32 gui=none
hi Pmenu        guifg=fg guibg=#3E3D32
hi PmenuSel     guifg=fg guibg=bg
hi PmenuSbar    guibg=bg
hi PmenuThumb   guifg=fg
hi Question     guifg=#A6E22E gui=none
hi Search       guifg=bg guibg=#E6DB74 gui=none
hi SpecialKey   guifg=#3B3A32 gui=none
"hi SpellBad
"hi SpellCap
"hi SpellLocal
"hi SpellRare
hi StatusLine   guifg=fg guibg=#3E3D32 gui=none
hi StatusLineNC guifg=#75715E guibg=#3E3D32 gui=none
hi TabLine      guifg=#75715E guibg=#3E3D32 gui=none
hi TabLineFill  guifg=fg guibg=#3E3D32 gui=none
hi TabLineSel   guifg=fg guibg=#3E3D32 gui=none
hi Title        guifg=#F92672 gui=none
hi Visual       guibg=#49483E gui=none
"hi VisualNOS
hi WarningMsg   guifg=#F92672 gui=none
"hi WildMenu

"hi Menu
"hi ScrollBar
"hi Tooltip

" Syntax highlighting groups
hi Comment      guifg=#75715E gui=none
"
hi Constant     guifg=#66D9EF gui=none
hi String       guifg=#E6DB74 gui=none
hi Character    guifg=#E6DB74 gui=none
"hi Number
"hi Boolean
"hi Float
"
hi Identifier   guifg=#A6E22E gui=none
hi link Function Identifier
"
hi Statement    guifg=#F92672 gui=none
"hi Conditional
"hi Repeat
"hi Label
"hi Operator
"hi Keyword
"hi Exception
"
hi PreProc      guifg=#FD971F gui=none
"hi Include
"hi Define
"hi Macro
"hi PreCondit
"
hi Type         guifg=#F92672 gui=none
"hi StorageClass
"hi Structure
"hi Typedef
"
"hi Special      guifg=#75715E gui=none
hi link Special Type
"hi SpecialChar
"hi Tag
"hi Delimiter
"hi SpecialComment
"hi Debug
"
hi Underlined   guifg=#65D9EF gui=underline
"hi Ignore
hi Error        guifg=fg guibg=#F92672 gui=none
hi Todo         guifg=fg guibg=#FD971F gui=none
