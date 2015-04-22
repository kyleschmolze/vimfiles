"""""""""""""""""
" VUNDLE PACKAGES
"""""""""""""""""

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add plugins here. Github, vim-scripts.org, git, and local files are all supported.
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-haml'
Plugin 'vim-scripts/vim-coffee-script'
Plugin 'digitaltoad/vim-jade'
"Plugin 'sjl/gundo.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


""""""""""
" SETTINGS
""""""""""


" Color settings. Very picky!
set background=dark
colorscheme solarized
let g:solarized_termcolors=256 
syntax on

" :BGD and :BGL to quickly switch color schemes
command BGD set background=dark | colo solarized
command BGL set background=light | colo solarized

" Use ag for CtrlP
let mapleader=","
let g:ctrlp_user_command = 'ag %s -l -i --nocolor --hidden -g ""'
map <leader>f :CtrlP<CR>
map <leader>b :CtrlPMRU<CR>



" Some settings
set expandtab " Always use spaces, never tabs
set ts=2
set shiftwidth=2
set scrolloff=3 " 3 lines between cursor and top/bottom of screen
set cursorline
set relativenumber
set number
set ruler " Shows current mode, cursor position, on bottom status bar

set autoindent " based on previous line
set incsearch " search as you type
set showmatch " Show matching brackets/parenthesis
set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present

set backspace=2 " otherwise, you can only Backspace-delete things you just typed


" Persistent undo
set undodir=~/.vim/undo
set undofile

set clipboard=unnamed " Use mac clipboard

" Put all swap and backup files in one place
set backupdir=~/.vim/backup
set directory=~/.vim/swap


" Folding
set foldlevel=999
set foldmethod=indent

" Disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Declare some filetypes for syntax highlighting
au BufNewFile,BufRead *.eco set filetype=html
au BufNewFile,BufRead *.rabl set filetype=ruby
au BufNewFile,BufRead *.less set filetype=scss

" Enter => new line
nmap <C-j> o<Esc> 
nmap <C-k> O<Esc>
nmap <Space> i_<Esc>r

" Quickly edit .vimrc
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>ez :e ~/.zshrc<CR>

" Quick save
map <leader>s :w<CR>

" Simple key remaps
imap jk <Esc>
nmap ; :

" Space => Insert one char
nmap <Space> i_<Esc>r

" Y => cut rest of line
nmap Y Du

" Common typos
cmap Wq wq
cmap WQ wq
cmap Q q


" The following lines make word wraping great
" UPDATE I'm disabling these until it's a problem
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l



" This function moves the current file, quite useful
function! MoveFile(newspec)
  let old = expand('%')
  " could be improved:
  if (old == a:newspec)
    return 0
  endif
  exe 'sav' fnameescape(a:newspec)
  call delete(old)
endfunction

" This function let's you write into new directories, and it mkdir's them
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

command! -nargs=1 -complete=file -bar MoveFile call MoveFile('<args>')
command! -nargs=1 AddExt execute "saveas ".expand("%:p").<q-args>
command! -nargs=1 ChgExt execute "saveas ".expand("%:p:r").<q-args>

