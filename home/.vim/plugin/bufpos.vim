" BufPos:  Activate a buffer by its position number in the buffers
"          list
" Author:  Michele Campeotto <michele@campeotto.net>
" Date:    2007-04-25
" Version: 1.0
"
" This script provides a function to activate a vim buffer by passing it the
" position in the buffers list and maps it to <M-number> to easily switch
" between open buffers.
"
" This is best used togheter with the buftabs plugin:
"   http://www.vim.org/scripts/script.php?script_id=1664
" Modified for OSX 4/2/2010 by Jason Moiron (jmoiron@jmoiron.net)

" map to command in osx instead of alt

if has("gui_macvim")
    let s:modifier = "<D-"
else
    let s:modifier = "<M-"
endif

function! BufPos_ActivateBuffer(num)
    let l:count = 1
    for i in range(1, bufnr("$"))
        if buflisted(i) && getbufvar(i, "&modifiable") 
            if l:count == a:num
                exe "buffer " . i
                return 
            endif
            let l:count = l:count + 1
        endif
    endfor
    echo "No buffer!"
endfunction

function! BufPos_Initialize()
    for i in range(1, 9) 
        exe "map " . s:modifier . i . "> :call BufPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "map " . s:modifier . "0> :call BufPos_ActivateBuffer(10)<CR>"
endfunction

autocmd VimEnter * call BufPos_Initialize()

