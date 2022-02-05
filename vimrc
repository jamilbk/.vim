" Enable gui stuff for cterm vim (use only inside 24-bit color terms)
set termguicolors

" Sometimes these two lines are also needed for termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" who doesn't love plugins
call plug#begin('~/.vim/plugged')
Plug 'mattreduce/vim-mix'
Plug 'BeneCollyridam/futhark-vim'
Plug 'pearofducks/ansible-vim'
Plug 'mfukar/robotframework-vim'
Plug 'jamilbk/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'chr4/nginx.vim'
Plug 'hashivim/vim-terraform'
Plug 'jparise/vim-graphql'
Plug 'thoughtbot/vim-rspec'
Plug 'haystackandroid/cosmic_latte'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/groovyindent-unix'
Plug 'digitaltoad/vim-jade'
Plug 'briancollins/vim-jst'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/LargeFile'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/tComment'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-bundler'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-commentary'
Plug 'Lokaltog/vim-distinguished'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'jnwhiteh/vim-golang'
Plug 'tpope/vim-haml'
Plug 'pangloss/vim-javascript'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-rvm'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-unimpaired'
Plug 'posva/vim-vue'
Plug 'wakatime/vim-wakatime'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'w0rp/ale'
Plug 'dense-analysis/ale'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/html5.vim'
Plug 'elmcast/elm-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Elixir mappings
" Run unit tests no-color (useful for macvim)
map <C-u> :Mix test --no-color<CR>
map <C-U> :Mix test --no-color %<CR>

" A nifty included plugin in Vim 8
packadd! matchit

" allow external .vimrc's
set exrc

" Always show gutter (prevent code jumping left to ride on lint-as-you-type)
" set signcolumn=yes

" Don't syntax highlight more than 80 columns
set synmaxcol=500

" Decrease async updates from 4,000ms (default) to 100ms. Helps with things
" like GitGutter but causes input lag
" set updatetime=100

set nohls
set tabpagemax=50
set sidescroll=1
set sidescrolloff=10
set scrolloff=10
set backspace=indent,eol,start " fixes issue with compiled 7.3 not backspacing properly
set nocompatible
set number
set ruler
set wildmode=list:longest,full
set showmode
set history=50
set nomodeline
set nowrap
set textwidth=0
set nolist
set shiftwidth=2
set shiftround
set expandtab
set tabstop=2
" set textwidth=80 " Hard-wrap column
filetype on
filetype plugin indent on
syntax enable
autocmd FileType html set formatoptions+=t1
autocmd FileType markdown set wrap
autocmd FileType * set nowrap
autocmd FileType markdown setlocal spell spelllang=en_us
set smartcase
set incsearch
au BufRead,BufNewFile *.hamlc set ft=haml
au BufRead,BufNewFile Capfile set ft=ruby
au BufRead,BufNewFile *Dockerfile* set ft=dockerfile
au BufRead,BufNewFile Jenkinsfile set ft=groovy tabstop=4 shiftwidth=4
au BufRead,BufNewFile Rakefile set ft=ruby
au BufRead,BufNewFile Guardfile set ft=ruby
au BufRead,BufNewFile Makefile set noexpandtab
au BufRead,BufNewFile Vagrantfile set ft=ruby
au BufRead,BufNewFile Bowerfile set ft=ruby
au BufRead,BufNewFile colorscheme set ft=vim
au BufRead,BufNewFile *.yml* set ft=yaml
au BufRead,BufNewFile *.go set noexpandtab

" Don't let matchparen to slow down cursor movement. Limit it to 2 ms.
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

" Enable prettier integration
let g:ale_fix_on_save = 1

" Always in gutter
let g:ale_sign_column_always = 0

" Use strict mode
let g:ale_elixir_credo_strict = 1

let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'graphql': ['prettier'],
      \ 'css': ['prettier']
      \}

let g:ale_linters = {
      \ 'elixir': ['credo'],
      \ 'ruby': ['rubocop']
      \}

" Disable lint as you type
let g:ale_lint_on_text_changed = 'never'

" Disable syntax highlighting for errors
let g:ale_set_highlights = 1

" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 1
let g:ale_fix_on_enter = 0

" Fix Ctrl-P hangs with VIM-ALE
autocmd BufEnter ControlP let b:ale_enabled = 0

" Disable compiled languages ALE
" autocmd FileType elixir let b:ale_enabled = 0

" Speed up grep and Ctrl-P
if executable('rg')
  " Optionally use rg for listing files
  let g:ctrlp_user_command = 'rg %s -l --files -g ""'
  let g:ctrlp_use_caching = 0
end

" Automatically open the quickfix after :make, :grep, and :lvimgrep
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" For easy select of recently pasted text
nnoremap gp `[v`]
nmap <C-T> :TagbarToggle<CR>

" Visual Bell instead of Audio Bell
set vb

" Disable Visual Bell flash
set t_vb=

" helpful quickfix navigation
map <C-j> :cn<CR>
map <C-k> :cp<CR>

" Tidy XML when opened -- causes problems with Git blame
" au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Tidy HTML / XML on demand
command Thtml :%!tidy -q -i --show-errors 0
command Txml  :%!tidy -q -i --show-errors 0 -xml

" used to map Space bar as fold key
set foldmethod=syntax
set foldlevel=99 " files open with no folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" copy yanks to clipboard, only if not in tmux on mac
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set clipboard=unnamed
  elseif s:uname == "Linux\n"
    " Linux
    set clipboard+=unnamedplus
  endif
endif

" NERDTree shortcut
map <C-N> :NERDTreeToggle<CR>

" Swap windows more easily
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"

  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )

  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf

  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"

  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf 
endfunction

nmap <silent> <C-w>y :call MarkWindowSwap()<CR>
nmap <silent> <C-w>p :call DoWindowSwap()<CR>

" load different shell
if has("macunix")
  set shell=/bin/zsh
elseif has("unix")
  set shell=/usr/bin/zsh
endif

let mapleader=" "

" ignores
set wildignore+=/swagger-ui/*,/vendor/*,/*tfstate*,/_build,*/tmp/*,/log,*.so,*.swp,*.zip,*/node_modules/*,/deps,_site/*,*/lib/public/js/vendor/*,/components/*,*/builtAssets/*,*/coverage/*
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|log|*tfstate*|_site|solr|_build|swagger-ui|deps|doc|public\/js\/vendor|\.DS_Store|_site|\/components|builtAssets|node_modules)$'
" uncomment to hide the directories from NERDTree
let NERDTreeIgnore=['.*VBoxSVC.*\.log$', '^deps$', '\.tfstate$', '\.backup$', '^node_modules$', '^_build$']

" Files over 100 MB are considered large files
let g:LargeFile=100

" Disable syntax on files over 5000 lines
au BufRead,BufNewFile * if line("$") > 5000|set syntax=|endif

" Performance
set lazyredraw
set ttyfast

" Faster for most syntax highlighting libraries
" set regexpengine=1

" Import chosen colorschemes
" runtime colorscheme
source ${HOME}/.vim/colorscheme

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set noswapfile


" " Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


" " Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk


" " Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" " Remember info about open buffers on close
set viminfo^=%


" """"""""""""""""""""""""""""""
" " => Status line
" """"""""""""""""""""""""""""""
" " Always show the status line
set laststatus=2

" " Format the status line
set statusline=%{winnr()}\ %t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" " Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.json :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()
autocmd BufWrite *.haml :call DeleteTrailingWS()
autocmd BufWrite *.erb :call DeleteTrailingWS()
autocmd BufWrite *.html :call DeleteTrailingWS()
autocmd BufWrite *.hamlbars :call DeleteTrailingWS()
autocmd BufWrite *.hbs :call DeleteTrailingWS()
autocmd BufWrite *.yml :call DeleteTrailingWS()
autocmd BufWrite *.yaml :call DeleteTrailingWS()
autocmd BufWrite *.vue :call DeleteTrailingWS()
autocmd BufWrite *.sh :call DeleteTrailingWS()
autocmd BufWrite *.ex :call DeleteTrailingWS()
autocmd BufWrite *.exs :call DeleteTrailingWS()
autocmd BufWrite *.md :call DeleteTrailingWS()
autocmd BufWrite *.gql :call DeleteTrailingWS()


" " When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" gutter highlighting
" dark mode enabled?
"
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark' || !has('macunix')
  highlight OverLength ctermbg=188 guibg=#414141
else
  highlight OverLength ctermbg=188 guibg=#e1e1e1
endif

" match OverLength /\%81v.\+/
autocmd BufWritePost * match OverLength /\%81v.\+/
autocmd BufWinEnter * match OverLength /\%81v.\+/

" Elixir files can be 98 chars long
autocmd BufWritePost,BufWinEnter *.ex match OverLength /\%99v.\+/
autocmd BufWritePost,BufWinEnter *.exs match OverLength /\%99v.\+/
autocmd BufWritePost,BufWinEnter *.eex match OverLength /\%99v.\+/
autocmd BufWritePost,BufWinEnter *.leex match OverLength /\%99v.\+/

" Python files can be 88 chars long
autocmd BufWritePost,BufWinEnter *.py match OverLength /\%89v.\+/

" Ruby files can be 120 chars long
autocmd BufWritePost,BufWinEnter *.rb match OverLength /\%119v.\+/
autocmd BufWritePost,BufWinEnter *.erb match OverLength /\%119v.\+/
