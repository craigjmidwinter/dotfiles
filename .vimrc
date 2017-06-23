set nocompatible
set t_Co=256
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/Vundle.vim'
" Nerdtree
Plugin 'scrooloose/nerdtree'
" vim-airline
Plugin 'bling/vim-airline'
"colour-scheme
Plugin 'ajh17/Spacegray.vim'
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
" Gundo
Plugin 'sjl/gundo.vim'
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
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'
Plugin 'editorconfig/editorconfig-vim'

" All plugins must be defined before here
call vundle#end()
filetype plugin indent on

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

map <leader>r :NERDTreeFind<cr>

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
set term=xterm-256color
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
" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_close_on_revert = 1
set hidden " stops undo history deleting after buffer change

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
colorscheme breezy
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


" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   F8                next scheme
"   Shift-F8          previous scheme
"   Alt-F8            random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColors all              (all $VIMRUNTIME/colors/*.vim)
"   :SetColors my               (names built into script)
"   :SetColors blue slate ron   (these schemes)
"   :SetColors                  (display current scheme names)
" Set the current color scheme based on time of day:
"   :SetColors now
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1
let s:mycolors = ['slate', 'torte', 'darkblue', 'delek', 'murphy', 'elflord', 'pablo', 'koehler']  " colorscheme names that we use to set color

" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors(args)
  if len(a:args) == 0
    echo 'Current color scheme names:'
    let i = 0
    while i < len(s:mycolors)
      echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')
    echo 'List of colors set from all installed color schemes'
  elseif a:args == 'my'
    let c1 = 'default elflord peachpuff desert256 breeze morning'
    let c2 = 'darkblue gothic aqua earth black_angus relaxedgreen'
    let c3 = 'darkblack freya motus impact less chocolateliquor'
    let s:mycolors = split(c1.' '.c2.' '.c3)
    echo 'List of colors set from built-in names'
  elseif a:args == 'now'
    call s:HourColor()
  else
    let s:mycolors = split(a:args)
    echo 'List of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    call s:SetColors('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

" Set color scheme according to current time of day.
function! s:HourColor()
  let hr = str2nr(strftime('%H'))
  if hr <= 3
    let i = 0
  elseif hr <= 7
    let i = 1
  elseif hr <= 14
    let i = 2
  elseif hr <= 18
    let i = 3
  else
    let i = 4
  endif
  let nowcolors = 'elflord morning desert evening pablo'
  execute 'colorscheme '.split(nowcolors)[i]
  redraw
  echo g:colors_name
endfunction

