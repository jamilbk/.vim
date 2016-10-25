" better plugin management
call pathogen#infect()

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
set shiftwidth=2
set shiftround
set expandtab
set tabstop=2
" set textwidth=80 " Hard-wrap column
filetype on
filetype plugin indent on
syntax enable
autocmd FileType html set formatoptions+=t1
autocmd FileType markdown set tw=79
autocmd FileType markdown setlocal spell spelllang=en_us
set smartcase
set incsearch
au BufRead,BufNewFile *.hamlc set ft=haml
au BufRead,BufNewFile Capfile set ft=ruby
au BufRead,BufNewFile Rakefile set ft=ruby
au BufRead,BufNewFile Guardfile set ft=ruby
au BufRead,BufNewFile Makefile set noexpandtab
au BufRead,BufNewFile Vagrantfile set ft=ruby
au BufRead,BufNewFile Bowerfile set ft=ruby
au BufRead,BufNewFile docker-compose.yml.* set ft=yaml
" au BufRead,BufNewFile (*.markdown,*.md) set tw=79
" au BufRead,BufNewFile (*.markdown,*.md) 


" For easy select of recently pasted text
nnoremap gp `[v`]
nmap <C-T> :TagbarToggle<CR>
" Visual Bell instead of Audio Bell
set vb

" Tidy XML when opened
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Tidy HTML / XML on demand
command Thtml :%!tidy -q -i --show-errors 0
command Txml  :%!tidy -q -i --show-errors 0 -xml

" used to map Space bar as fold key
set foldmethod=syntax
set foldlevel=99 " files open with no folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" copy yanks to clipboard
set clipboard=unnamedplus

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

" Syntastic Syntax Options
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['ruby', 'php', 'javascript'],
                            \ 'passive_filetypes': ['html', 'haml', 'erb'] }
" Ctrl-S pauses many terms
" map <C-S> :SyntasticToggleMode<CR>

" load different shell
set shell=/bin/zsh

" ignores
set wildignore+=*/tmp/*,/log,*.so,*.swp,*.zip,*/node_modules/*,_site/*,*/lib/public/js/vendor/*,/components/*,*/builtAssets/*,*/coverage/*
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|log|_site|solr|doc|public\/js\/vendor|_site|components|builtAssets|node_modules)$'
" uncomment to hide the directories from NERDTree
" let NERDTreeIgnore=['node_modules']

" Files over 100 MB are considered large files
let g:LargeFile=100

" Disable syntax on files over 10000 lines
au BufRead,BufNewFile * if line("$") > 5000|set syntax=|endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Import chosen colorschemes
source /home/jamil/.vim/colorscheme

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


" " When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Helper functions
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
highlight OverLength ctermbg=57 ctermfg=229 guibg=#000050
match OverLength /\%81v.\+/
autocmd BufWritePost * match OverLength /\%81v.\+/
autocmd BufWinEnter * match OverLength /\%81v.\+/
