let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged' )

  """ sensible base settings as a blackbox.
  Plug 'tpope/vim-sensible'


	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
	Plug 'salkin-mada/openscad.nvim'

	Plug 'famiu/nvim-reload'	
	""" Required by reload
	Plug 'nvim-lua/plenary.nvim'

	Plug 'folke/which-key.nvim'

	""" Color Plugins
	Plug 'shaunsingh/nord.nvim'

  Plug 'jiangmiao/auto-pairs'

  """ Markdown Plugins
  
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  """ Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()



""" make space for the Neo
""" Neo2 Nvim Remapping
" https://neovim.io/doc/user/map.html#mapmode-nvh
""r" snrt ---> hjkr
set langmap=jn,nj,JN,NJ
set langmap+=rk,kr,RK,KR
set langmap+=lt,tl,LT,TL
set langmap+=hs,sh,HS,SH

" ---- Markdown Stuff
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> to trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0
"Trigger for Markdown Preview
nnoremap <M-m> :MarkdownPreview<CR>
" ----
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }


""" COLOR STUFF
let g:nord_cursor_line_number_background = 1
let g:nord_italic_comments = v:true 

colorscheme nord
""" END COLOR


" vim.g.openscad_help_trig_key = vim.g.openscad_help_trig_key or '<A-h>'
" vim.g.openscad_manual_trig_key = vim.g.openscad_manual_trig_key or '<A-m>'
" vim.g.openscad_exec_openscad_trig_key = vim.g.openscad_exec_openscad_trig_key or '<A-o>'
" vim.g.openscad_top_toggle = vim.g.openscad_top_toggle or '<A-c>'
let g:openscad_default_mappings = v:true 
lua require('openscad')

""" which key default conf
lua << EOF
require("which-key").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
}
EOF



""" Bracket Magic https://github.com/jiangmiao/auto-pairs
let g:AutoPairsShortcutToggle = '<A-p>'
let g:AutoPairsShortcutFastWrap = '<A-e>'
let g:AutoPairsShortcutJump = '<A-j>'
let g:AutoPairsShortcutPackInsert = '<A-b>'
let g:AutoPairsFlyMode = 1
"""
""" Default Config Sets
set cursorline
set number relativenumber
set nospell spelllang=en_us

set mouse=a
set mousemodel=popup
set clipboard+=unnamedplus
set nocompatible

set expandtab
set tabstop=2
set shiftwidth=2

""" do not split words at soft wraps
set linebreak
"""

""""""""""""""
" Remapping
" See: https://neovim.io/doc/user/map.html
""""""""""""""
""" Escape to …
noremap … <esc>
inoremap … <esc>
cnoremap … <c-u><bs>
"""

noremap _ A

""" Spellchecking
""" See: https://neovim.io/doc/user/spell.html
inoremap <silent> <F6> <esc>:set invspell<cr>i
noremap <silent> <F6> :set invspell<cr>
inoremap <silent> <F7> <esc>]s
noremap <silent> <F7> ]s
inoremap <silent> <F8> <esc>z=i
noremap <silent> <F8> z=
inoremap <F20> <esc>zgi
noremap <F20> zg 
""" Reload Config
noremap  <F11> :Restart<cr>
noremap  <F12> :Reload<cr>

vnoremap n j
vnoremap r k 

