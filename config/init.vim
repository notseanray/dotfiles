set nocompatible

"automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'glepnir/dashboard-nvim'
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
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
Plug 'sbdchd/neoformat'
Plug 'nanozuki/tabby.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'kylechui/nvim-surround'
Plug 'machakann/vim-sandwich'
Plug 'lewis6991/gitsigns.nvim'
Plug 'monaqa/dial.nvim'
Plug 'kyazdani42/nvim-tree.lua', { 'on': 'NvimTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NvimTreeToggle' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'wakatime/vim-wakatime'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'petertriho/nvim-scrollbar'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'xiyaowong/nvim-transparent'
Plug 'chrisbra/csv.vim'
Plug 'numToStr/Comment.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'jbyuki/venn.nvim'
Plug 'notseanray/presence.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'p00f/clangd_extensions.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mrshmllow/document-color.nvim'
Plug 'sindrets/winshift.nvim'
Plug 'kevinhwang91/rnvimr'
Plug 'uga-rosa/ccc.nvim', {'branch': '0.7.2'}
Plug 'sindrets/diffview.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

Plug 'catppuccin/nvim', {'as': 'catppuccin', 'do': 'CatppuccinCompile'}
call plug#end()

set mouse=a

" this variable must be enabled for colors to be applied properly
set termguicolors

" setlocal spelloptions+=noplainbuffer

filetype plugin on

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Replace `$EDITOR` candidate with this command to open the selected file
let g:rnvimr_edit_cmd = 'drop'

" Disable a border for floating window
let g:rnvimr_draw_border = 0

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 70

" Draw border with both
let g:rnvimr_ranger_cmd = ['ranger', '--cmd=set draw_borders both']

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Resize floating window by all preset layouts
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

" Resize floating window by special preset layouts
tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

" Resize floating window by single preset layout
tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]

" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }

" Customize multiple preset layouts
" '{}' represents the initial layout
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]

" prettier for formatting on save
let g:neoformat_try_node_exe = 1

" always show tab line
set showtabline=1

" open default file if buffer name is empty
" au VimEnter * if eval("@%") == "" | e ~/Desktop/common.md | endif

" colorscheme one
" colorscheme one
" set background=dark

lua << EOF
local augend = require("dial.augend")
require("dial.config").augends:register_group{
  -- default augends used when no group name is specified
  default = {
    augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
  },

  -- augends used when group with name `mygroup` is specified
  mygroup = {
    augend.integer.alias.decimal,
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
  }
}

local ccc = require("ccc")
local mapping = ccc.mapping
ccc.setup({})

--  require('spellsitter').setup {
--    -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
--    enable = true,
--    debug = false
--  }
local my_augroup = vim.api.nvim_create_augroup("my_augroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json" }, -- disable spellchecking for these filetypes
  command = "setlocal nospell",
  group = my_augroup,
})
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embeded terminal
  command = "setlocal nospell",
  group = my_augroup,
})
EOF

" set spell
syntax on

" increment decrement etc
nmap  <C-a>  <Plug>(dial-increment)
nmap  <C-x>  <Plug>(dial-decrement)
vmap  <C-a>  <Plug>(dial-increment)
vmap  <C-x>  <Plug>(dial-decrement)
vmap g<C-a> g<Plug>(dial-increment)
vmap g<C-x> g<Plug>(dial-decrement)

lua << EOF
require("winshift").setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  },
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    win_move_mode = {
      ["h"] = "left",
      ["j"] = "down",
      ["k"] = "up",
      ["l"] = "right",
      ["H"] = "far_left",
      ["J"] = "far_down",
      ["K"] = "far_up",
      ["L"] = "far_right",
      ["<left>"] = "left",
      ["<down>"] = "down",
      ["<up>"] = "up",
      ["<right>"] = "right",
      ["<S-left>"] = "far_left",
      ["<S-down>"] = "far_down",
      ["<S-up>"] = "far_up",
      ["<S-right>"] = "far_right",
    },
  },
  ---A function that should prompt the user to select a window.
  ---
  ---The window picker is used to select a window while swapping windows with
  ---`:WinShift swap`.
  ---@return integer? winid # Either the selected window ID, or `nil` to
  ---   indicate that the user cancelled / gave an invalid selection.
  window_picker = function()
    return require("winshift.lib").pick_window({
      -- A string of chars used as identifiers by the window picker.
      picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      filter_rules = {
        -- This table allows you to indicate to the window picker that a window
        -- should be ignored if its buffer matches any of the following criteria.
        cur_win = true, -- Filter out the current window
        floats = true,  -- Filter out floating windows
        filetype = {},  -- List of ignored file types
        buftype = {},   -- List of ignored buftypes
        bufname = {},   -- List of vim regex patterns matching ignored buffer names
      },
      ---A function used to filter the list of selectable windows.
      ---@param winids integer[] # The list of selectable window IDs.
      ---@return integer[] filtered # The filtered list of window IDs.
      filter_func = nil,
    })
  end,
})
EOF

" Start Win-Move mode:
nnoremap <C-W><C-M> <Cmd>WinShift<CR>
nnoremap <C-W>m <Cmd>WinShift<CR>

" Swap two windows:
nnoremap <C-W>x <Cmd>WinShift swap<CR>

" If you don't want to use Win-Move mode you can create mappings for calling the
" move commands directly:
nnoremap <C-M-H> <Cmd>WinShift left<CR>
nnoremap <C-M-J> <Cmd>WinShift down<CR>
nnoremap <C-M-K> <Cmd>WinShift up<CR>
nnoremap <C-M-L> <Cmd>WinShift right<CR>

lua << EOF
local DEFAULT_SETTINGS = {
    ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "none",

         icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },

        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },

    -- The directory in which to install packages.
    -- install_root_dir = path.concat { vim.fn.stdpath "data", "mason" },

    pip = {
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
        -- 2. The release version (e.g. "v0.3.0")
        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
local MASON_DEFAULT = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = { "rust_analyzer", "pyright", "jdtls", "tsserver", "gopls", "volar", "tailwindcss", "clangd" },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
}
require("mason-lspconfig").setup(MASON_DEFAULT)
EOF

lua <<EOF
  local home = os.getenv('HOME')
  local db = require('dashboard')
  db.custom_header = {
    \'',
    \'   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
    \'    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    \'          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
    \'           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    \'          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    \'   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    \'  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    \' ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    \' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
    \'      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    \'       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
    \'                                   ',
    \'               NEOVIM              ',
    \
  }
  db.custom_footer = { "NVIM > VSCode" }
  db.custom_center = {
      {icon = '  ',
      desc = 'Recently latest session                ',
      shortcut = 'SPC s l',
      action ='SessionLoad'},
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  'DashboardFindHistory',
      shortcut = 'SPC f h'},
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
      {icon = '  ',
      desc ='File Browser                            ',
      action =  'Telescope file_browser',
      shortcut = 'SPC f b'},
      {icon = '  ',
      desc = 'Find  word                              ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f w'},
      {icon = '  ',
      desc = 'Open Personal dotfiles                  ',
      action = 'Telescope dotfiles path=' .. home ..'/Desktop/stuff/dotfiles',
      shortcut = 'SPC f d'},
    }

EOF
" For 'Yggdroot/indentLine' and 'lukas-reineke/indent-blankline.nvim' "
let g:indentLine_fileTypeExclude = ['dashboard']
" For 'ntpeters/vim-better-whitespace' "
let g:better_whitespace_filetypes_blacklist = ['dashboard']


lua << EOF
require 'colorizer'.setup {
  'scss';
  'html';
  'vue';
  'svelte';
  'tsx';
  'jsx';
  'css';
  'javascript';
  html = {
    mode = 'foreground';
  }
}
EOF


lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 2000,
    follow_files = false
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 500,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'rounded',
    style = '',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF

lua << EOF
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
EOF

let g:coq_settings = ({'display.icons.mode': 'none', 'keymap.jump_to_mark': '<C-i>', 'auto_start': v:false})

lua require('Comment').setup()

" Function to trim extra whitespace in whole file
function! Trim()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()
autocmd BufWritePost * call Trim()
autocmd BufWritePost * StripWhitespace

" auto + smart indent for code
" set autoindent
" set smartindent

set visualbell
set wrap

set shortmess+=c
set wildoptions+=pum
set completeopt=menuone,noinsert,noselect


" Compile Catppuccin
autocmd BufWritePost init.vim :CatppuccinCompile

lua << EOF
require("notify").setup({
    relative = "editor",
    anchor = "NE",
    width = 50,
    height = 10,
    background_colour = "#c9d2e4",
    render = "minimal",
})

vim.notify = require("notify")

require("transparent").setup({
  enable = true, -- boolean: enable transparent
})
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require("indent_blankline").setup {
    space_char_blankline = "",
}
EOF

lua << EOF
    vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
    require("catppuccin").setup({
        transparent_background = false,
        term_colors = false,
        compile = {
            enabled = true,
            path = vim.fn.stdpath "cache" .. "/catppuccin",
        },
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = { "italic" },
            functions = { "italic" },
            keywords = { "italic" },
            strings = { "italic" },
            variables = { "italic" },
            numbers = { "italic" },
            booleans = { "italic" },
            properties = { "italic" },
            types = { "italic" },
            operators = { "italic" },
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            coc_nvim = false,
            lsp_trouble = false,
            cmp = true,
            lsp_saga = false,
            gitgutter = true,
            gitsigns = true,
            leap = false,
            telescope = true,
            nvimtree = {
                enabled = true,
                show_root = true,
                transparent_panel = false,
            },
            neotree = {
                enabled = false,
                show_root = true,
                transparent_panel = false,
            },
            dap = {
                enabled = false,
                enable_ui = false,
            },
            which_key = false,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            dashboard = true,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = true,
            markdown = true,
            lightspeed = false,
            ts_rainbow = false,
            hop = false,
            notify = true,
            telekasten = true,
            symbols_outline = true,
        }
    })
    vim.cmd[[colorscheme catppuccin]]
EOF


" Catppuccin
" let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
" colorscheme catppuccin

lua << EOF
require('nvim-autopairs').setup({
  enable_check_bracket_line = false
})
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
require("scrollbar").setup({
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    folds = 500, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = {
            text = { "-", "=" },
            priority = 0,
            color = nil,
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "-", "=" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "-", "=" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "-", "=" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "-", "=" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "-", "=" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
        },
    },
    excluded_buftypes = {
        "terminal",
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
        clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
        },
    },
    handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
})
EOF

lua << EOF
require("clangd_extensions").setup {
    server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}
EOF

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
        --hover_with_actions = true,
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

require("document-color").setup {
    -- Default options
    mode = "background", -- "background" | "foreground" | "single"
}

local on_attach = function(client)
  if client.server_capabilities.colorProvider then
    -- Attach document colour support
    require("document-color").buf_attach(bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- nvim ufo folding
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- You are now capable!
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}

-- Lsp servers that support documentColor
require("lspconfig").tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

local ftMap = {
    vim = 'indent',
    python = {'indent'},
    git = ''
}

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

vim.keymap.set('n', 'zK', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of them
        -- coc.nvim
        -- vim.fn.CocActionAsync('definitionHover')
        -- nvimlsp
        vim.lsp.buf.hover()
    end
end)

require('ufo').setup({
    fold_virt_text_handler = handler,
    open_fold_hl_timeout = 100,
    close_fold_kinds = {'imports', 'comment'},
    preview = {
        win_config = {
            border = {'', '─', '', '', '', '─', '', ''},
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>'
        }
    },
    provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        -- return ftMap[filetype]
        return {'treesitter', 'indent'}

        -- refer to ./doc/example.lua for detail
    end
})

-- local coq = require"coq"

local servers = { 'pyright', 'tsserver', 'gopls', 'clangd', 'volar', 'tailwindcss', 'clangd', 'jdtls', 'svelte-language-server' }

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        capabilities = capabilities,
    })
end

require('rust-tools').setup(opts)

local palettes = {
  gruvbox_light = {
    accent = '#d65d0e', -- orange
    accent_sec = '#7c6f64', -- fg4
    bg = '#ebdbb2', -- bg1
    bg_sec = '#d5c4a1', -- bg2
    fg = '#504945', -- fg2
    fg_sec = '#665c54', -- fg3
  },
  gruvbox_dark = {
    accent = '#d65d0e', -- orange
    accent_sec = '#a89984', -- fg4
    bg = '#3c3836', -- bg1
    bg_sec = '#504945', -- bg2
    fg = '#d5c4a1', -- fg2
    fg_sec = '#bdae93', -- fg3
  },
  edge_light = {
    accent = '#bf75d6', -- bg_purple
    accent_sec = '#8790a0', -- grey
    bg = '#eef1f4', -- bg1
    bg_sec = '#dde2e7', -- bg4
    fg = '#33353f', -- default:bg1
    fg_sec = '#4b505b', -- fg
  },
  nord = {
    accent = '#88c0d0', -- nord8
    accent_sec = '#81a1c1', -- nord9
    bg = '#3b4252', -- nord1
    bg_sec = '#4c566a', -- nord3
    fg = '#e5e9f0', -- nord4
    fg_sec = '#d8dee9', -- nord4
  },
}

local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}
local tabby_config = function()
  local palette = palettes.nord
  local filename = require('tabby.filename')
  local cwd = function()
    return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
  end
  local tabname = function(tabid)
    return vim.api.nvim_tabpage_get_number(tabid)
  end
  local line = {
    hl = { fg = palette.fg, bg = palette.bg },
    layout = 'active_wins_at_tail',
    head = {
      { cwd, hl = { fg = palette.bg, bg = palette.accent } },
      { '', hl = { fg = palette.accent, bg = palette.bg } },
    },
    active_tab = {
      label = function(tabid)
        return {
          '  ' .. tabname(tabid) .. ' ',
          hl = { fg = palette.bg, bg = palette.accent_sec, style = 'bold' },
        }
      end,
      left_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
    },
    inactive_tab = {
      label = function(tabid)
        return {
          '  ' .. tabname(tabid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec, style = 'bold' },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    top_win = {
      label = function(winid)
        return {
          '  ' .. filename.unique(winid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    win = {
      label = function(winid)
        return {
          '  ' .. filename.unique(winid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    tail = {
      { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
      { '  ', hl = { fg = palette.bg, bg = palette.accent_sec } },
    },
  }
  require('tabby').setup({ tabline = line })
end
tabby_config()


-- local get_hex = require('cokeline/utils').get_hex
-- require('cokeline').setup({
--   components = {
--     {
--       text = function(buffer) return (buffer.index ~= 1) and '▏' or '' end,
--       fg = get_hex('Normal', 'fg')
--     },
--     {
--       text = function(buffer) return '    ' .. buffer.devicon.icon end,
--       fg = function(buffer) return buffer.devicon.color end,
--     },
--     {
--       text = function(buffer) return buffer.filename .. '    ' end,
--       style = function(buffer) return buffer.is_focused and 'bold' or nil end,
--     },
--     {
--       text = '',
--       delete_buffer_on_left_click = true,
--     },
--     {
--       text = '  ',
--     },
--   },
-- })


-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
require'nvim-tree'.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = true,
  reload_on_bufenter = true,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    width = 30,
    height = 30,
    hide_root_folder = true,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = true,
    signcolumn = "no",
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = " ",
        symlink = " ",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = " ",
          open = " ",
          empty = " ",
          empty_open = " ",
          symlink = " ",
          symlink_open = " ",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = " ",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {"node_modules", "target"},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = " ",
      info = " ",
      warning = " ",
      error = " ",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 100,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
}
EOF

lua <<EOF
local coq = require'coq'
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

" General options
let g:presence_auto_update         = 1
let g:presence_neovim_image_text   = "nvim > vscode"
let g:presence_main_image          = "neovim"
let g:presence_client_id           = "793271441293967371"
let g:presence_debounce_timeout    = 500
let g:presence_enable_line_number  = 1
let g:presence_blacklist           = []
let g:presence_buttons             = 1
let g:presence_file_assets         = {}

" Rich Presence text options
let g:presence_editing_text        = "editing %s"
let g:presence_file_explorer_text  = "browsing %s"
let g:presence_git_commit_text     = "git-ing good"
let g:presence_plugin_manager_text = "fixing plugins"
let g:presence_reading_text        = "reading %s"
let g:presence_workspace_text      = "working on %s"
let g:presence_line_number_text    = "line [%s/%s]"

" add '_' as a word delimeter
" set iskeyword-=_

" if the current buffer is open when fzf opens, jump to it in selection
let g:fzf_buffers_jump = 1

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

function InitialOpen()
    if eval("@%") == ""
        :DashboardNewFile
    endif
    :NvimTreeToggle
endfunction

nnoremap <silent> <C-n> :call InitialOpen()<CR>
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

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" comfy keybind to search
nnoremap <C-s> /
vnoremap <silent> <C-s> gc
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

" let g:gruvbox_contrast_dark = 'light'
" let g:gruvbox_improved_strings = '1'
" let g:gruvbox_improved_warnings = '1'

" set gruvbox color scheme
" autocmd vimenter * ++nested colorscheme gruvbox
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
nnoremap <silent> gk :bp<bar>sp<bar>bn<bar>bd<CR>

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

" handle urls with # in them correctly
function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!xdg-open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction

map <leader>u :call HandleURL()<cr>

let g:Hexokinase_highlighters = ['backgroundfull']

" :Rename command
command! -nargs=1 Rename saveas <args> | call delete(expand('#')) | bd #

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.config/viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list

augroup myvimrc au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

command! PU PlugUpdate | PlugUpgrade

" move vim info file
set viminfo+=n~/.config/viminfo
" The width of a hard tabstop measured in "spaces" -- effectively the (maximum) width of an actual tab character.
set tabstop=4
" Setting this to a non-zero value other than tabstop will make the tab key (in insert mode) insert a combination of spaces (and possibly tabs) to simulate tab stops at this width.
set softtabstop=4
" Enabling this will make the tab key (in insert mode) insert spaces instead of tab characters. This also affects the behavior of the retab command.
set expandtab
" Enabling this will make the tab key (in insert mode) insert spaces or tabs to go to the next indent of the next tabstop when the cursor is at the beginning of a line (i.e. the only preceding characters are whitespace).
set smarttab
set shiftwidth=4

" auto update plugged every week
function! OnVimEnter() abort
  if exists('g:plug_home')
    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
    if filereadable(l:filename) == 0
      call writefile([], l:filename)
    endif

    let l:this_week = strftime('%Y_%V')
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_week) < 0
      " launch headless
      call execute(':!nvim +PlugUpdate +qa > /dev/null 2&>1')
      call writefile([l:this_week], l:filename, 'a')
    endif
  endif
endfunction

autocmd VimEnter * call OnVimEnter()

if has ('autocmd') && execute("file") != ".config/nvim/init.vim" " Remain compatible with earlier versions
 augroup vimrc
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
