" Init Plugins by https://github.com/kristijanhusak/vim-packager
if &compatible
  set nocompatible
endif

" Load packager only when you need it
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'})
  call packager#add('junegunn/fzf.vim')
  call packager#add('Shougo/deoplete.nvim')
  call packager#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'})
  call packager#add('scrooloose/nerdtree')
  call packager#add('Xuyuanp/nerdtree-git-plugin')
  call packager#add('pangloss/vim-javascript')
  call packager#add('airblade/vim-gitgutter')
  call packager#add('vim-airline/vim-airline')
  call packager#add('vim-airline/vim-airline-themes')
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-surround')
  call packager#add('flazz/vim-colorschemes')
  call packager#add('liuchengxu/space-vim-dark')
  call packager#add('Yggdroot/indentLine')
  call packager#add('nikvdp/ejs-syntax')
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! PackagerUpdate call PackagerInit() | call packager#update()
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

" ================ Basic Configuration ====================
" It hides buffers instead of closing them.
" https://medium.com/usevim/vim-101-set-hidden-f78800142855
set hidden
" Show tha number
set number
" always set autoindenting on
set autoindent
" Make indent above it relative lines
set breakindent
" Highlights search results as you type vs after you press Enter
set incsearch
" Ignore case when searching
set ignorecase
set smartcase
" Turns search highlighting on
set hlsearch
" Expands TABs into whitespaces
set expandtab
set shiftwidth=2
" A tab is 2 spaces
set tabstop=2
" insert tabs on the start of a line according to
" shiftwidth, not tabstop
set smarttab
" Turn on TrueColor
set termguicolors
" This is colorscheme 
colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59
hi LineNr ctermbg=NONE guibg=NONE

" Remaping
inoremap jj <Esc>
inoremap ja <Esc>A
inoremap jw <Esc>:w<CR>
nnoremap ; :

" make down and up more natural when using long lines and wrap together
nnoremap j gj
nnoremap k gk

" cc now hides those annoying search highlihghts after you're done searching
nnoremap cc :let @/ = ""<cr>

" \e to open a NerdTree at in the directory of the currently viewed file
nnoremap <C-n> :Ex<CR>

" Ctrl+P opens a fuzzy filesearch window (powered by Fzf)
nnoremap <C-p> :Files<CR>

" ================ Turn Off Swap Files ============== {{{
set noswapfile
set nobackup
set nowritebackup

" Plugins Configuration
" Vim Javascript plugin
let g:javascript_plugin_jsdoc = 1

" Vim airline themes
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

" ============================ NerdTree Plugin =============================
" NerdTree toggle
map <C-n> :NERDTreeToggle<CR>
" NerdTree minimal UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Quit nvim when there's only NerdTree tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" automatically open NerdTree when no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Language Server Plugin
let g:LanguageClient_serverCommands = {
\ 'javascript': ['javascript-typescript-stdio'],
\ 'javascript.jsx': ['javascript-typescript-stdio'],
\ 'typescript': ['javascript-typescript-stdio'],
\ 'python': ['pyls'],
\ }
