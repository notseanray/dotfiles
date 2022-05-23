set nocompatible

"automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'kyazdani42/nvim-web-devicons' " If you want devicons
Plug 'glepnir/galaxyline.nvim'
Plug 'notseanray/nerd-galaxyline'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'projekt0n/github-nvim-theme'
Plug 'noib3/nvim-cokeline'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-tree.lua' |
            \ Plug 'ryanoasis/vim-devicons' 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'rakr/vim-one'
Plug 'timonv/vim-cargo'
Plug 'wakatime/vim-wakatime'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'andweeb/presence.nvim'

call plug#end()

set shortmess+=c 
set completeopt=menuone,noinsert,noselect

" this variable must be enabled for colors to be applied properly
set termguicolors

lua << EOF
-- default settings, but here anyway to allow easy swapping
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
				inlay_hints = {
					maxLength = 20,
					closureReturnTypeHints = true
				}
            }
        }
    },
	-- options same as lsp hover / vim.lsp.util.open_floating_preview()
	hover_actions = {
		-- the border that is used for the hover window
		-- see vim.api.nvim_open_win()
		border = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		},

		-- whether the hover action window gets automatically focused
		-- default: false
		auto_focus = false,
	},
}

require('rust-tools').setup(opts)

local coq = require "coq"

local get_hex = require('cokeline/utils').get_hex
require('cokeline').setup({
  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
      fg = get_hex('Normal', 'fg')
    },
    {
      text = function(buffer) return '    ' .. buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.filename .. '    ' end,
      style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },
})
EOF

lua <<EOF
local cmp = require'cmp'
cmp.setup(coq.lsp_ensure_capabilities({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}))
EOF

" Find files using Telescope command-line sugar.
nnoremap <silent> <leader>ff <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>fg <cmd>Telescope live_grep<CR>
" default bind for this is fg, above, but 'find word' makes more sense in my
" head
nnoremap <silent> <leader>fw <cmd>Telescope live_grep<CR>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>fh <cmd>Telescope help_tags<CR>

" search buffers with fzf
nnoremap <silent> <C-b>Telescope buffers<CR>
nnoremap <silent> <C-f>Telescope live_grep<CR>

let g:presence_enable_line_number = 1

" add '_' as a word delimeter
set iskeyword-=_ 

" if the current buffer is open when fzf opens, jump to it in selection
let g:fzf_buffers_jump = 1

let g:coq_settings = { 'display.icons.mode': 'none' }

" disable status line for fzf
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" shorter lsp update time 
set updatetime=200
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" 0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_git_hl = 1 
" 0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_highlight_opened_files = 1 
" This is the default. See :help filename-modifiers for more options
let g:nvim_tree_root_folder_modifier = ':~' 
" 0 by default, append a trailing slash to folder names
let g:nvim_tree_add_trailing = 0
" 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_group_empty = 0 
" one space by default, used for rendering the space between the icon and the filename. 
" Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_icon_padding = ' ' 
" defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_symlink_arrow = ' >> ' 
" 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_respect_buf_cwd = 0 
" 0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_create_in_closed_folder = 0 
" List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_special_files = { 
	\ 'README.md': 1, 
	\ 'Makefile': 1, 
	\ 'MAKEFILE': 1, 
	\ 'readme.md': 1, 
	\ 'Cargo.toml': 1, 
	\ } 

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set renderer.indent_markers.enable (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': " ",
    \ 'symlink': " ",
    \ 'git': {
    \   'unstaged': "✗ ",
    \   'staged': "✓ ",
    \   'unmerged': " ",
    \   'renamed': "➜",
    \   'untracked': "★ ",
    \   'deleted': " ",
    \   'ignored': "◌ "
    \   },
    \ 'folder': {
    \   'arrow_open': " ",
    \   'arrow_closed': " ",
    \   'default': " ",
    \   'open': " ",
    \   'empty': " ",
    \   'empty_open': " ",
    \   'symlink': " ",
    \   'symlink_open': " ",
    \   }
    \ }

nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR>
nnoremap <silent> <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors 

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

" setup nvim-tree
lua require'nvim-tree'.setup()


nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" comfy keybind to search
nnoremap <C-s> /
" clear search next time esc is hit
nnoremap <silent> <esc> :noh <CR>

" open terminal
nnoremap <silent> t :terminal<CR> 

" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:gruvbox_contrast_dark = 'light'
let g:gruvbox_improved_strings = '1'
let g:gruvbox_improved_warnings = '1'

" set gruvbox color scheme
autocmd vimenter * ++nested colorscheme gruvbox
" colorscheme github_dark

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" binds escape in terminal mode
tnoremap <Esc> <C-\><C-n>

" buffer navigation
nnoremap <silent> gl :bn<CR>
nnoremap <silent> gh :bp<CR>
" kill buffer, gd doesn't seem right but g-kill makes sense
nnoremap <silent> gk :bdelete!<CR>  

if has('clipboard')
	" copy and cut to both buffers
	vnoremap <silent> <C-c> "+y | %+y 
	vnoremap <silent> <C-x> "+d | %+d 
	nnoremap <silent> <p> "+p <CR>
endif

" turn hybrid line numbers on
:set number relativenumber
:set nu rnu

" when using :w! to save, chmod the file too
function! g:ChmodOnWrite()
  if v:cmdbang
    silent !chmod u+w %
  endif
endfunction

autocmd BufWrite * call g:ChmodOnWrite()

let g:Hexokinase_highlighters = ['backgroundfull']

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.config/viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

" move vim info file
set viminfo+=n~/.config/viminfo

set tabstop=4
set shiftwidth=4
