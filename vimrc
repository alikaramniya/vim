" config.vim

let mapleader = ","

syntax enable

set nocompatible
""" set number relativenumber                " Show numbers on the left
set hlsearch              " Highlight search results
set ignorecase            " Search ingnoring case
set smartcase             " Do not ignore case if the search patter has uppercase
set noerrorbells          " I hate bells
set belloff=esc
set tabstop=4             " Tab size of 2 spaces
set softtabstop=4         " On insert use 2 spaces for tab
set shiftwidth=4
set expandtab             " Use apropiate number of spaces
set nowrap                " Wrapping sucks (except on markdown)
autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap " DO wrap on markdown files
set noswapfile            " Do not leve any backup files
set mouse=a               " Enable mouse on all modes
set clipboard=unnamed,unnamedplus     " Use the OS clipboard
set showmatch
set termguicolors
set splitright splitbelow
set list lcs=tab:\¦\      "(here is a space)

" set completeopt-=preview

" Keep VisualMode after indent with > or <
vmap < <gv
vmap > >gv
"
" Move Visual blocks with J an K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Autocomand to remember las editing position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Install vim-plug for vim and neovim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set background=dark

" Use Ctrl-k Ctrl-k to open a sidebar with the list of files
map <C-k><C-k> :NERDTreeToggle<cr>
" Use Ctrl-P to open the fuzzy file opener
nnoremap <C-p> :Files<cr>

" Shortcut for get list active tabs by press lt
nnoremap tb :W<CR>

" Get list todo
nnoremap td :Ag todo<CR>

" Run VCoolor
nnoremap vc :VCoolor<CR>

" ---------------------------------------------------- Coc Config start --------------------------------------------"


" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Config nvim or vim for tmux
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" end config

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
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
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

" Download @yaegassy/coc-laravel package coc from https://github.com/yaegassy/coc-laravel
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-html-css-support',
    \ 'coc-blade',
    \ '@yaegassy/coc-laravel',
    \ 'coc-snippets',
    \ 'coc-prettier',
    \ 'coc-tailwindcss',
    \ '@yaegassy/coc-tailwindcss3',
    \ '@yaegassy/coc-volar',
    \ 'coc-emmet',
    \ 'coc-php-cs-fixer',
    \ 'coc-phpls',
    \ 'coc-python',
    \ 'coc-diagnostic'
    \]

" ---------------------------------------------- Coc Config end --------------------------------------------- "

"Cursor settings:
let &t_SI.="\e[2 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" Shortcut for break line to new line by press ctrl+j
nnoremap <NL> i<CR><ESC>

" Close all buffer without latest buffer
command BufOnly silent! execute "%bd|e#|bd#"
" map <C-k>t b :BufOnly<cr>
noremap <C-k>t :BufOnly<CR>

" Select all word
let g:multi_cursor_select_all_word_key = '<C-a>'

" Change current spit's width
noremap <silent> <C-S-Left> :vertical resize -1<CR>
noremap <silent> <C-S-Right> :vertical resize +1<CR>
nnoremap <silent> <C-S-Up> :resize -1<CR>
noremap <silent> <C-S-Down> :resize +1<CR>

" toggle tagbar
map <C-T><C-T> :TagbarToggle <cr>
" Set default width for tagbar
let g:tagbar_width = winwidth(0) * 20/100

let NERDTreeShowHidden=1

" Support persian language
set termbidi

" maximize current split or return to previous
noremap <C-f>t :MaximizerToggle<CR>

" Config NeoSolarized
set termguicolors

nnoremap <silent> zh :call HorizontalScrollMode('h')<CR>
nnoremap <silent> zl :call HorizontalScrollMode('l')<CR>
nnoremap <silent> zH :call HorizontalScrollMode('H')<CR>
nnoremap <silent> zL :call HorizontalScrollMode('L')<CR>

function! HorizontalScrollMode( call_char  )
      if &wrap
        return
      endif

      echohl Title
      let typed_char = a:call_char
      while index( [ 'h', 'l', 'H', 'L'  ], typed_char  ) != -1
        execute 'normal! z'.typed_char
        redraws
        echon '-- Horizontal scrolling mode (h/l/H/L)'
        let typed_char = nr2char(getchar())
      endwhile
      echohl None | echo '' | redraws
endfunction

""" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_theme_style = 'default-community'
let g:material_terminal_italics = 1

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Set under line for curren cursor
set cursorline
augroup CustomCursorLine
   au!
   au ColorScheme * :hi clear CursorLine
   au ColorScheme * :hi! CursorLine gui=underline cterm=underline
augroup END

" Airline Config
let g:airline_theme='darkspace'

" Move between buffer with shortcut
nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

" Tokyonight theme config
let g:tokyonight_style = 'night' " available: night, storm, day
let g:tokyonight_enable_italic = 1

" Config folding for php
""" map <F4> <Esc>:DisablePHPFolds<Cr>
map <F5> <Esc>:EnableFastPHPFolds<Cr>
" End config folding

" Exit from search mode
nnoremap <esc> :nohlsearch<return>

" Remove everything in statusline
let &statusline='%#Normal#'

" Status line config
set statusline=\ %t\ %=%{%'%'.(line('$')->len()).'l'%}/%L\ 

" Remove ~ icon from first of line and replace them with space
set fillchars+=eob: 

" -------------------------------------- NeoSolarized config ---------------------------------
" Default value is "normal", Setting this option to "high" or "low" does use the
" same Solarized palette but simply shifts some values up or down in order to
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed
" using ":set list" can be set to one of three levels depending on your needs.
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"

" I make vertSplitBar a transparent background color. If you like the origin
" solarized vertSplitBar style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

" If you wish to enable/disable NeoSolarized from displaying bold, underlined
" or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
" Default values:
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 0

" Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
" text output by commands like `ls` aren't what you expect, you might want to
" try disabling this option. Default value:
let g:neosolarized_termBoldAsBright = 1

" -------------------------------------- NeoSolarized config ---------------------------------
" Plugins
call plug#begin('~/.vim/plugged')
" Plugins here !!!!
Plug 'tpope/vim-sensible'         " Sensible defaults
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File navigator
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Install fuzzy finder binary
Plug 'junegunn/fzf.vim'               " Enable fuzzy finder in Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intelisense
Plug 'sheerun/vim-polyglot'
Plug 'szw/vim-maximizer' " Vim maximizer
Plug 'tpope/vim-commentary' " Coummenting
Plug 'terryma/vim-multiple-cursors' " Multi cursor work
Plug 'jiangmiao/auto-pairs' " auto paris
Plug 'majutsushi/tagbar' " Tag bar plug
Plug 'andrewradev/tagalong.vim' " Auto rename tag
" Start laravel plug
Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-projectionist'        "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'
" End laravel plug
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-fugitive' " work with git
Plug 'tpope/vim-surround' " Working with tags
Plug 'honza/vim-snippets' " Vim Snippets
Plug 'SirVer/ultisnips' " Create custom snippet
Plug 'ryanoasis/vim-devicons' " Icon for file in vim
Plug 'gko/vim-coloresque' " Color plugin for vim
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'icymind/neosolarized'
Plug 'nn1ks/vim-darkspace'
Plug 'tribela/vim-transparent'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'cocopon/iceberg.vim'
Plug 'KabbAmine/vCoolor.vim' " Work with color and set custom color when coding
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'GuiLra/vim'
Plug 'sakibmoon/vim-colors-notepad-plus-plus'
Plug 'bluz71/vim-moonfly-colors'
Plug 'JAremko/alpine-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'scrooloose/syntastic'
Plug 'techtuner/aura-neovim' "Vim-Plug
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'eihigh/vim-aomi-grayscale'
Plug 'stefanvanburen/rams.vim' " best
Plug 'meain/hima-vim'   " add the plugin
Plug 'erizocosmico/vim-color-golang'
call plug#end()

colorscheme material
