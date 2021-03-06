"
" Andy's vimrc file.(based on the example vimrc file)
"

if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
 
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""
"  Add by Andy.S.Y.Chen in 2013 Feb 18  "
"""""""""""""""""""""""""""""""""""""""""

" basic config {

set number
set smartindent   
set autoindent 
set autoread

set sw=4

set title        " set the terminal title to the current file
"set cursorline   " highlight the line under the cursor
"set foldmethod = syntax   

nmap wv  <C-w>v   
nmap ws  <C-w>s
nmap wc  <C-w>c
nmap wq  <C-w>q

" }


"""""""""""""""""""""""""""""""""""""""""
"            Tag list (ctags)           "
"""""""""""""""""""""""""""""""""""""""""

" taglist config { 

"let Tlist_Auto_Open = 1          
let Tlist_Show_One_File = 1
let Tlist_Use_left_Window = 1   
let Tlist_Exit_OnlyWindow = 1 
let Tlist_WinWidth = 40
let Tlist_WinHeight = 50

" }

"""""""""""""""""""""""""""""""""""""""""
"              bufexplorer              "
"""""""""""""""""""""""""""""""""""""""""

" bufexplorer config {

let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSortBy = 'mru'

nmap bf :BufExplorer<cr>

" prev file
nmap bp :bp<cr>         
" next file    
nmap bn :bn<cr>             

" }

"""""""""""""""""""""""""""""""""""""""""
"  WinManager combine TagList & netrw   "
"""""""""""""""""""""""""""""""""""""""""

" winmanager config {

let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:winManagerWidth = 40
let g:winManagerHeight = 80
let g:defaultExplorer = 0

nmap wm :WMToggle<cr>
nmap <C-w><C-F> :FirstExplorerWindow<cr>
nmap <C-w><C-B> :BottomExplorerWindow<cr>

" }


""""""""""""""""""""""""""""""""""""""""""
"          cscope configuration          "
""""""""""""""""""""""""""""""""""""""""""

" cscope config {

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   set cscopequickfix=s-,c-,d-,i-,t-,e-
   
   if filereadable("cscope.out")
      cs add cscope.out
   elseif $CSCOPE_DB !=""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

nmap cs :cs find s 
nmap cg :cs find g 
nmap cc :cs find c 
nmap ct :cs find t 
nmap ce :cs find e 
nmap cf :cs find f 
nmap ci :cs find i 
nmap cd :cs find d

" }

"""""""""""""""""""""""""""""""""""""""""
"        new-omni-completion            "
"""""""""""""""""""""""""""""""""""""""""

" new-omni-completion config {

filetype plugin indent on 
set completeopt=longest,menu

" }

"""""""""""""""""""""""""""""""""""""""""
"               supertab                "
"""""""""""""""""""""""""""""""""""""""""

" supertab config {

let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

" }


"""""""""""""""""""""""""""""""""""""""""
"       quickfix command mapping        "
"""""""""""""""""""""""""""""""""""""""""

" quickfix config {

nmap lmake :lmake<cr>
nmap make :make<cr>
nmap mc :make clean<cr>
nmap qc :cc<cr> 
nmap qp :cp<cr> 
nmap qn :cn<cr> 
nmap ql :cl<cr> 
nmap qw :cw<cr> 
nmap ol :col<cr> 
nmap nl :cnew<cr>

" Add in 2013.08.22
map <F8> :lmake<cr> :copen<cr>
map <F5> :make<cr> :copen<cr>
map <F6> :make clean<cr> :copen<cr>
" End add

" }

"""""""""""""""""""""""""""""""""""""""""
"       Project command mapping         "
"""""""""""""""""""""""""""""""""""""""""

" project config {

nmap pj :Project<cr>

" }

"""""""""""""""""""""""""""""""""""""""""
"               A Plugin                "
"""""""""""""""""""""""""""""""""""""""""

" A config {

nnoremap <silent> <F12> :A<cr>

" }
