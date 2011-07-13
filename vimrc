
"pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() "call this when installing new plugins
filetype plugin on

"=====================================================================================
" BASIC SETTINGS
let mapleader=","
"append $ when changein a word
set cpoptions+=$
"set line numbers
set number
" toggle line numbers
nmap <Leader>R :set number!<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>L :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" hide scrollbars
set guioptions-=l
set guioptions-=r

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


"=====================================================================================
" SYNTAX
"=====================================================================================
" Less CSS Sytax
au BufNewFile,BufRead *.less set filetype=less
" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

"=====================================================================================
" JSlint
"=====================================================================================
" Turn on JSLint error highlighting
let g:JSLintHighlightErrorLine = 1
if has("autocmd")		
" makeprg for nodejs	
"	autocmd FileType javascript set makeprg=jslint\ %
" The following is an error format that will catch errors from nodejs, rhino, or jslint:	
"	autocmd FileType javascript set efm=\%f:\ on\ line\ %l:%c:\ %m,\%A%.%#\ \"%f\"\\,\ line\ %l:\ %m,\%C,%Z%p,js:\ %m,\%A%f:%l,%C,%C,%Z%m
endif

" <F5> Make and QuickFix
nnoremap <silent> <F5> :make %<CR>:cw<CR>
inoremap <silent> <F5> <C-O>:make %<CR><C-O>:cw<CR>
nnoremap <silent> <C-F5> :cn<CR>
nnoremap <silent> <S-F5> :cp<CR>
	
"=====================================================================================
" INDENTATION

" Map word movement
"nmap <A-Right>w
"nmap <M-A> <Right>W
"nmap <M-C> <Right>e
"nmap <M-A> <C-Right>E

"map <A-Left>b
"map <M-A-Left>B
"map <M-A-Left>ge
"map <M-A-C-Left>gE 

" Do some Themeing stuff if gui is available
if has("gui_macvim")	
	"set theme
	color mustang
	set guifont=Meslo\ LG\ M\ DZ:h12
	" set transparency
	set transparency=4
endif
