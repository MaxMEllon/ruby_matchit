" FILE: "/home/johannes/ruby.vim"
" Last Modification: "Mon, 06 May 2002 23:42:11 +0200 (johannes)"
" Additional settings for Ruby
" Johannes Tanzler, <jtanzler@yline.com>

" Matchit for Ruby: '%' {{{
"
"   This function isn't very sophisticated. It just takes care of indentation.
" (I've written it, because I couldn't extend 'matchit.vim' to handle Ruby
" files correctly (that's because everything in Ruby ends with 'end' -- no
" 'endif', 'endclass' etc.))
"
" If you're on the line `if x', then the cursor will jump to the next line
" with the same indentation as the if-clause. The same is true for a whole
" bunch of keywords -- see below for details.
"
" Since brave programmers use indentation, this will work for most of you, I
" hope. At least, it works for me. ;-)
" }}}

let s:save_cpo = &cpo
set cpo&vim

function! ruby_matchit#exec()
  " use default matching for parenthesis, brackets and braces:
  if strpart(getline("."), col(".")-1, 1) =~ '(\|)\|{\|}\|\[\|\]'
    normal __%__
    return
  endif

  normal ^
  sil! let curr_word = expand('<cword>')
  if curr_word == ""
    return
  endif

  let curr_line = line(".")
  let spaces = strlen(matchstr(getline("."), "^\\s*"))

  if curr_word =~ '\<end\>'
    while 1
      normal k
      if strlen(matchstr(getline("."), "^\\s*")) == spaces
            \ && getline(".") !~ "^\\s*$"
            \ && getline(".") !~ "^#"
        normal ^
        break
      elseif line(".") == 1
        exe 'normal ' . curr_line . 'G'
        break
      endif
    endwhile
  elseif curr_word =~ '\<\(if\|unless\|elsif\|else\|do\|case\|when\|while\|until\|def\|module\|class\|context\|it\|xit\|describe\)\>'
    while 1
      normal j
      if strlen(matchstr(getline("."), "^\\s*")) == spaces
            \&& getline(".") !~ "^\\s*$"
            \&& getline(".") !~ "^#"
        normal ^
        break
      elseif line(".") == line("$")
        exe 'normal ' . curr_line . 'G'
        break
      endif
    endwhile
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
