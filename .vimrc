set nu
syntax on
set noeb vb t_vb=
inoremap jj <ESC>
filetype plugin on

" Set clipboard up to be the unnamed register in linux and osx 
if !exists('g:os')
  if has('win64') || has('win32') 
    let g:os = 'Windows'
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif
if g:os == 'Darwin'
  set clipboard=unnamed
elseif g:os == 'Linux'
  set clipboard=unnamedplus
endif

set backspace=indent,eol,start
