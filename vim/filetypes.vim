""""""""""""""""""""""""""""""""""""
" vim as TSV editor. Who needs excel?
""""""""""""""""""""""""""""""""""""

function! s:SplitWin()
    split
    resize 1
    setlocal laststatus=0
endfunction


au! BufNewFile,BufRead *.tsv set filetype=tsv

au FileType tsv setlocal noexpandtab
au FileType tsv setlocal shiftwidth=20
au FileType tsv setlocal softtabstop=20
au FileType tsv setlocal tabstop=20
au FileType tsv setlocal tabstop=20
au FileType tsv call s:SplitWin() "window splitting
au FileType tsv wincmd j 

""""""""""""""""""""""""""""""
" => JavaScript section "" Taken from
" https://github.com/amix/vimrc/blob/master/vimrcs/filetypes.vim
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


