" Disable vi compatibility
set nocompatible
filetype off

"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() "call this when installing new plugins

filetype plugin on
set ofu=syntaxcomplete#Complete
"=====================================================================================
" BASIC SETTINGS
let mapleader=","
command! -nargs=* Wrap set wrap linebreak nolist

"GIST VIM
let g:github_user = "iwyg-snippets"
let g:github_token = "$GITHUB_TOKEN"
" Set encoding
set encoding=utf8
set fileencoding=utf8
" cappuccino runtime
set runtimepath+=/usr/local/narwhal/bin/objj
"append $ when changing a word
set cpoptions+=$

"set line numbers
set number
"set relativenumber
set undofile
set ruler
set title
set backspace=indent,eol,start
"set nowrap
set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85
set autowrite

set hidden

"if has("mouse")
"	set mouse=a
"endif	

" Backups
set history=1000
set undolevels=1000
set nobackup
set directory=~/.vim/tmp/swap/



" toggle line numbers
nmap <Leader>R :set number!<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>L :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:·

" hide scrollbars
set guioptions-=l
set guioptions-=r

" Searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
set grepprg=ack
runtime macros/matchit.vim
" Status bar
set laststatus=2

"disable arrow keys in normal mode 
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

"tab moving
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>

"delete current buffer
"nmap <D-w> :bd<CR>

"webindent
filetype plugin indent on
"tabindex
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set noexpandtab

nmap <C-TAB> :b#<CR>
vmap <C-TAB> :b#<CR>
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>
" Popup menu behavior
set completeopt=longest,menu
set pumheight=20

"code folding
"Then you can toggle folding with za. 
"You can fold everything with zM and unfold everything with zR. zm and zr 
"can be used to get those folds just right. 
"Always remember the almighty help file at “help :folding” if you get stuck.

set foldmethod=indent "fold based on indent
set foldnestmax=10 "deepest fold is 10 levels
set nofoldenable "dont fold by default
set foldlevel=1

"xml folding
let g:xml_syntax_folding = 1
set foldmethod=syntax
"=====================================================================================
" Plugin Configuration
"=====================================================================================
" Syntastic
"=====================================================================================
let g:syntasitc_enable_filetypes = ['js']
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1
let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=0
let g:syntastic_disabled_filetypes = ['scss']
"=====================================================================================
" JSlint
" Turn on JSLint error highlighting
let g:JSLintHighlightErrorLine = 1
" JSbreautyfy JSlint
let g:Jsbeautify_jslint_whitespace = 1
"=====================================================================================
" NERDTree and Supertab
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']

" Setup supertab to be a bit smarter about it's usage
" let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabLongestEnhanced = 1
map <Leader>n :NERDTree<CR>
map <Leader>nn :NERDTreeToggle<CR>
"=====================================================================================
" Command-T configuration
let g:CommandTMaxHeight=40
"=====================================================================================


"=====================================================================================
" SYNTAX
"=====================================================================================

" Let Google Linter autofix the js errors in the current buffer
function! FixJS()
  setlocal autoread
"  execute('!sudo $HOME/.vim/syntax_checkers/compilers/fixjsstyle --strict --nojsdoc %')
"	execute('!fixjsstyle --strict --nojsdoc %')
	execute('!fixjsstyle --strict  %')
endfunction
:command! FJS :call FixJS()

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

" Less CSS Sytax
	au BufNewFile,BufRead *.less set filetype=less
" md, markdown, and mk are markdown and define buffer-local preview
	au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
" add json syntax highlighting
	au BufNewFile,BufRead *.json set ft=javascript

	au BufRead,BufNewFile *.txt call s:setupWrapping()
"typoscript
	au BufNewFile,BufRead mozex.textarea.* setlocal filetype=typoscript
	au BufNewFile,BufRead *.ts setlocal filetype=typoscript 	
"smarty	
	au BufNewFile,BufRead *.tpl setlocal filetype=smarty 	
"underscore templates 	
	au BufNewFile,BufRead *.jst set syntax=jst

"underscore templates 	
	au BufNewFile,BufRead *.j set syntax=objj

endif

" stripping trailing whitespaces
"
"=====================================================================================
" AUTOCOMPLETION
"=====================================================================================
if has("autocmd")
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType smarty set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType xsl set omnifunc=xmlcomplete#CompleteTags
endif
"=====================================================================================
" WHITESPACES
"=====================================================================================

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

if has("autocmd")
	autocmd BufWritePre *.py,*.js,*.xsl,*.html :call <SID>StripTrailingWhitespaces()
endif	

" Themes and GUI settings
" -----------------------------------------------------------------------------
if $TERM == 'xterm-color' && &t_Co == 8
  set t_Co=16
endif
if $TERM == 'xterm-256color'
  set t_Co=256
endif

if has("terminfo")
  set t_Co=16
  set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
  set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
else
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Show syntax highlighting groups for word under cursor
" -----------------------------------------------------------------------------
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" --------------------
autocmd FileWritePost,BufWritePost *.less :call LessCSSCompress()
function! LessCSSCompress()
  let cwd = expand('<afile>:p:h')
  let name = expand('<afile>:t:r')
  if (executable('lessc'))
    cal system('lessc '.cwd.'/'.name.'.less > '.cwd.'/../css/'.name.'.css &')
  endif
endfunction


" Mardown 2 Html Conversion
nmap <leader>md :!/usr/local/bin/markdown % > %.html<cr> 

" php doc
source ~/.vim/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 
