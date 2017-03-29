setlocal sw=2
setlocal ts=2
autocmd BufWritePre *.rb :%s/\s\+$//e
