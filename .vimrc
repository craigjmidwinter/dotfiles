set nocompatible
set t_Co=256
filetype off
set shell=/bin/bash\ -i
set shell=zsh\ -i
execute pathogen#infect()

syntax enable
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
if !has("gui_running")
    let g:solarized_termtrans=1
    let g:solarized_termcolors=16
endif
colorscheme solarized

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/Vundle.vim'
" Nerdtree
Plugin 'scrooloose/nerdtree'
" vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chrisbra/Colorizer'
"colour-scheme
" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Fugitive
Plugin 'tpope/vim-fugitive'
" VMustache
Plugin 'tobyS/vmustache'
" Ultisnips
Plugin 'SirVer/ultisnips'
" PDV
Bundle 'tobyS/PDV'
" Ctrlp
Plugin 'kien/ctrlp.vim'
" Commentary
Plugin 'tpope/vim-commentary'
" Easymotion
Plugin 'Lokaltog/vim-easymotion'
" Surround
Plugin 'tpope/vim-surround'
" PHP
Plugin 'StanAngeloff/php.vim'
" PHP QA Tools
Bundle 'joonty/vim-phpqa.git'
" Supertab
Plugin 'ervandew/supertab'
" PHP refactoring
Bundle 'vim-php/vim-php-refactoring'
" Blade syntax
Plugin 'xsbeats/vim-blade'
" PHP-complete
Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
Plugin 'joonty/vdebug'
Bundle 'Valloric/YouCompleteMe'
Plugin 'mkusher/padawan.vim'
Plugin 'mhinz/vim-signify'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'tomasr/molokai'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'nelsyeung/twig.vim'

" All plugins must be defined before here
call vundle#end()
filetype plugin indent on

let g:airline_solarized_bg='dark'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'thaerkh/vim-workspace'
call plug#end()

" NERDTree
map <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=0 " Press I to toggle hidden files
let NERDTreeQuitOnOpen=1
let NERDTreeDirArrows=1
let NERDTreeChDirMode=2
let NERDTreeHighlightCursorline=1
autocmd StdinReadPre * let s:std_in=1 " Open NerdTree on launch if no file selected
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Close vim if only NerdTree open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if only NerdTree open

let g:airline#extensions#tabline#buffer_nr_show = 1

map <leader>r :NERDTreeFind<cr>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

let $PATH=$PATH . ':' . expand('/Users/craig/.composer/vendor/bin')
let g:padawan#composer_command = "composer"
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php =
\ ['->', '::', '(', 'use ', 'namespace ', '\']

" vim-airline
set encoding=utf-8
set guifont=Meslo\ LG\ M\ for\ Powerline	"Install the font on host Putty 'powerline/fonts'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1
set laststatus=2	" Always show the status bar
set showtabline=2
set noshowmode	"Hide the default mode text

"UltiSnips
let g:UltiSnipsExpandTrigger="<Leader>sn"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" PHP Documentor
inoremap <leader>db <ESC>:call pdv#DocumentWithSnip()<CR>i
nnoremap <leader>db :call pdv#DocumentWithSnip()<CR>
vnoremap <leader>db :call pdv#DocumentWithSnip()<CR>
let g:pdv_template_dir = $HOME ."/.vim/DocBlocks/"

" PHP QA
let g:phpqa_messdetector_autorun = 1
let g:phpqa_codesniffer_args =  "--standard=~/.vim/rulesets/tccodestyle.xml"
let g:phpqa_messdetector_ruleset = "~/.vim/rulesets/tccodestyle.xml"

" Quick fix window

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_options["path_maps"] = {"/home/admin/domains/www.pepper.local": "/Users/craig/workspace/www.pepper.local"}
let g:vdebug_options['ide_key']='PHPSTORM'

nmap <Leader>ec :lcl<CR>
nmap <Leader>en :lne<CR>
imap <Leader>en <ESC>:lne<CR>i
vmap <Leader>en <ESC>:lne<CR>i
nmap <Leader>ep :lp<CR>
imap <Leader>ep <ESC>:lp<CR>i
vmap <Leader>ep <ESC>:lp<CR>

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*.swp,*.zip,*.so,*/tmp/*,*/node_modules/*,*/vendor/*,*/bower_components/*
let g:ctrlp_max_files=500000

" Omincomplete
highlight Pmenu ctermbg=238 gui=bold
set completeopt-=preview
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"


" Supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" PHP refactoring
let g:php_refactor_command='php ~/.vim/refactor/refactor.phar'

" keymaps
nmap <C-s> :w<CR>	" Make sure to add 'stty ixany' and 'stty ixoff -ixon' to .bashrc to disable freezing
nmap vs :vsplit<CR>
nmap sp :split<CR>
nmap <C-s> :bnext<CR>    " Faster buffer changes
nmap <C-a> :bprev<CR>   " Faster buffer changes
nmap <C-x> :bd<CR>  " Close the current buffer"

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"Standard Settings"
set tabstop=4
set shiftwidth=4
set smarttab
set tags=tags
set softtabstop=4
set autoindent
set copyindent
set pastetoggle=<F2>
set expandtab
set shiftround
set backspace=indent,eol,start	" allow backspaceing over evetyting in insert mode
set number
set ignorecase
set smartcase
set noerrorbells
set autowrite

" Disable all beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif
if $TERM == "xterm-256color"
      set t_Co=256
endif
" Swap files out of the project root
set backupdir=~/.vim/backups/
set directory=~/.vim/swap/

" Syntax highlighting
au BufNewFile,BufRead *.blade.php set filetype=blade " Set blade extension syntax

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:signify_vcs_list = [ 'git' ]
let g:signify_update_on_bufenter = 0
let g:signify_sign_change = '~'
let g:signify_sign_delete_first_line = '*'
let g:signify_update_on_focusgained = 0

highlight SignifySignAdd    cterm=bold ctermfg=green
highlight SignifySignDelete cterm=bold ctermfg=red
highlight SignifySignChange cterm=bold ctermfg=blue

highlight SignifySignAdd    gui=bold  guifg=green
highlight SignifySignDelete gui=bold  guifg=red
highlight SignifySignChange gui=bold  guifg=darkorange

let g:used_javascript_libs = 'underscore,backbone'
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1

nnoremap <leader>s :ToggleWorkspace<CR>

Plug 'trkw/yarn.vim'

