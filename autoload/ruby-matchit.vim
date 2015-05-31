if exists("g:loaded_matchit")
  finish
endif
let g:loaded_matchit = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <buffer> \\\\\ %
nnoremap <buffer> % :call <SID>Ruby_Matchit(<CR>)

let &cpo = s:save_cpo
unlet s:save_cpo