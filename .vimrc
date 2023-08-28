"{{{ Information
"# vim: set foldmethod=marker:
"
" @title	Vim Configurations
" @author 	Maxwell Middnedorf
" 
" @purpose	This file is intend to provide
" 		configuarations and plugins
" 		for Vim."
"}}}
"{{{ Plugins
"  .............................................................................

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

	" Fern File Explore
	Plug 'lambdalisue/fern.vim'
		" Fern Preview
		Plug 'yuki-yano/fern-preview.vim'
	
	" File Icon
	Plug 'ryanoasis/vim-devicons'
	Plug 'lambdalisue/nerdfont.vim'
	Plug 'lambdalisue/fern-renderer-nerdfont.vim'
	
	" Linting
	Plug 'dense-analysis/ale'

	" Close Deliminators
	Plug 'Raimondi/delimitMate'

	" Methods and Variable Overview
	Plug 'preservim/tagbar'
	Plug 'liuchengxu/vista.vim'
	Plug 'universal-ctags/ctags'

	" Code Autocomplete
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'lambdalisue/fern-git-status.vim'

	" Surround
	Plug 'tpope/vim-surround'

	" Comment Out
	Plug 'tpope/vim-commentary'

	" AI Completion
	Plug '0xStabby/chatgpt-vim'

	" Databases
	Plug 'tpope/vim-dadbod'

	" Buffer Viewer
	Plug 'ap/vim-buftabline'


call plug#end()



"}}}
"{{{ Basic Settings
"  .............................................................................

" line numbers
set number

" Number Hybrid
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Hybrid Colors
highlight LineNrAbove ctermfg=red
highlight LineNRBelow ctermfg=green

" syntax coloring
syntax on

" Enable Auto-Completion Menu
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Inherit indentation from previous line
set autoindent

" Enable Backspace
set backspace=indent,eol,start

" Disable Welcome Message
set shortmess=I

" Enable File Icons
"set encoding=UTF-8
let g:fern#renderer = "nerdfont"

"" Wordwrap on End of Words
set linebreak

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
set smartcase

" Set the number of commands to save in history (default=20)
set history=1000

" Enable auto completion menu (TAB)
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" Disable Tildes
highlight EndOfBuffer ctermfg=Black ctermbg=Black

" Folding config
set foldmethod=syntax
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = 150 - len(line_text) - len(folded_line_num)
    return ' ' .  repeat(' ', indent(v:foldstart)) . '(+) ' . line_text . '    ' .  repeat('-', fillcharcount) . ' (' . folded_line_num . ' Lines)'
endfunction
set foldtext=MyFoldText()
set foldcolumn=1 "defines 1 col at window left, to indicate folding

" Open all folds all on file opening 
set foldlevel=99

" Enable Mouse Scrolling
set mouse=a

" Enable Modelines
set modeline
set modelines=5

" Search Before Enter
set incsearch

" Automatically CD To Current Working Directory
set autochdir

" Hide Split Lines
set fillchars+=vert:\ 
set foldcolumn=2
let s:hidden_all = 0
highlight VertSplit ctermfg=Black

" Fix Cursor Position in Normal Mode
set virtualedit=onemore

" Buffer Tabs Configurations
let g:buftabline_show=1
let g:buftabline_indicators=1

"{{{ Use Return, Backspace,and Delete keys in normal mode like in insert mode
function! Delete_key(...)
  let line=getline (".")
  if line=~'^\s*$'  
    execute "normal dd"
    return
  endif
  let column = col(".")
  let line_len = strlen (line)
  let first_or_end=0
  if column == 1
    let first_or_end=1
  else
    if column == line_len
      let first_or_end=1
    endif
  endif
  execute "normal i\<DEL>\<Esc>"
  if first_or_end == 0
    execute "normal l"
  endif
endfunction
function! Backspace_key(...)
  let line=getline (".")
  if line=~'^\s*$'  
    execute "normal dd"
    return
  endif
  let column = col(".")
  let line_len = strlen (line)
  let first_or_end=0
  if column == 1
    let first_or_end=1
  else
    if column == line_len
      let first_or_end=1
    endif
  endif
  execute "normal i\<backspace>\<Esc>"
  if first_or_end == 0
    execute "normal l"
  endif
endfunction
function! Backspace_key(...)
  let line=getline (".")
  if line=~'^\s*$'  
    execute "normal dd"
    return
  endif
  let column = col(".")
  let line_len = strlen (line)
  let first_or_end=0
  if column == 1
    let first_or_end=1
  else
    if column == line_len
      let first_or_end=1
    endif
  endif
  execute "normal i\<backspace>\<Esc>"
  if first_or_end == 0
    execute "normal l"
  endif
endfunction
nnoremap <silent> <DEL> :call Delete_key()<CR>
nnoremap <silent> <backspace> :call Backspace_key()<CR>
nnoremap <silent> <CR> i<CR><Esc>
"}}}
"}}}
"{{{ Color Changes

" Coc Error Float 
highlight FgCocErrorFloatBgCocFloating ctermbg=235 ctermfg=9

"}}}
"{{{ Key Remapings
"  .............................................................................
"{{{Navigation
	
	" Delete to beginning of word
	imap <Esc><BS> <C-w>
	nmap <Esc><BS> dvb


	" Delete to end of word 
	imap ( <C-o>dw
	nmap ( dve
	
	" Previous Word
	nmap OOD b
	imap OOD [1;2D

	" Next Word
	nmap OOC w
	imap OOC [1;2C

	" Move to  SoL 
	map H ^
	imap H <C-o>^
 	
	" Move to EoL  
	map F g_l
	imap F <End>
	
	" Page Up/Down Corrections
	map <silent> <PageUp> 1000<C-U>
	map <silent> <PageDown> 1000<C-D>
	imap <silent> <PageUp> <C-O>1000<C-U>
	imap <silent> <PageDown> <C-O>1000<C-D>	

	" Next Page
	map OOB 

	" Previous Page
	map OOA 


	" Switch Windows/Tabs
	
		" nmap H 
	
		" Prev Buffer
		nmap <silent>J :bp<CR>
		
		" Next Buffer
		nmap <silent>K :bn<CR>
	
		" nmap L

	"}}}

" Open Command Line
nnoremap ; :

" Find Next
nnoremap ' ;

" Toggle Drawer
noremap <silent> <F7> :Fern .. -reveal=:%h -drawer -keep -width=45 -toggle<CR><C-w>=

" Toggle Tagbar
nmap <silent> <F8> :Vista!!<CR>

" Remap Redo
nmap U <C-r>

" AI Code Completion

"}}}
"{{{ Custom Commands
"  .............................................................................

" Edit Settings
command Settings e ~/.vimrc
command Resettings source ~/.vimrc

" Run Current File
command Run :!./% 


" Compile and Run
command Go :make | Run

"}}}
"{{{ Fern Configurations
"  .............................................................................
function! s:fern_settings() abort
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

set hidden
""}}}
"{{{ Auto-Complete Configurations
"  ..............................................................................

" Colors
highlight CocFloating ctermbg=8
highlight CocSearch ctermfg=12 ctermbg=NONE
highlight Folded term=italic ctermfg=14 ctermbg=0
highlight FoldColumn term=italic ctermfg=14 ctermbg=0
highlight SignColumn term=italic ctermfg=14 ctermbg=0

set updatetime=300
set signcolumn=yes




imap <silent><expr> <C-\>
 	\ coc#pum#visible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request( 'snippetNext'', 'snippetCheck', ['snippets-expand-jump',''])\<CR>" :
	\ coc#refresh()


let g:coc_snippet_next = '<tab>'


" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <C-\> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction





" Use `[g` and `]g` to navigate diagnostics
" Use `:CcDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> r <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap R <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
map <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
""}}}
"{{{ Compiling Configurations

" C
autocmd Filetype c setlocal makeprg=gcc\ %\ -o\ %<

" C++
autocmd Filetype cpp setlocal makeprg=g++\ %\ -o\ %<

" COBAL
autocmd Filetype cobal setlocal makeprg=cobc\ -xj\ %\

" Java
autocmd Filetype java setlocal makeprg=java\ %

" Javascript
autocmd Filetype javascript setlocal makeprg=node\ %

" Typescript
autocmd Filetype typescript setlocal makeprg=ts-node\ %

" Python
autocmd Filetype python setlocal makeprg=python3\ %

" Rust
autocmd Filetype rust setlocal makeprg=cargo\ run

"}}}
"{{{ TODO

" 	- Map Chat Gpt commands / comment prompts
" 	- Navigation
" 	- Preview Buffer Fix
"	- Fix Color
"	- Input Variables



	"{{{ Test Zone
	
	

	
	"}}}


"}}}
