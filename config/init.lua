vim.opt.ttimeoutlen=2
vim.opt.mouse="a"
vim.opt.cmdheight=1
vim.opt.shortmess:append({ c = true })
vim.opt.hidden = true
vim.opt.nu = true
vim.o.relativenumber = true
vim.opt.updatetime=200
vim.opt.encoding="utf-8"
vim.opt.termguicolors = true
vim.o.showtabline = 2
vim.cmd("set signcolumn=number")
vim.cmd("set t_Co=256")
vim.cmd("set nobackup")
vim.cmd("set nowritebackup")
vim.cmd("autocmd BufLeave,BufWinLeave * silent! mkview")
vim.cmd("autocmd BufReadPost * silent! loadview")
vim.cmd("autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler")
vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })")
vim.cmd("autocmd BufWrite * call g:ChmodOnWrite()")
vim.cmd("command! -nargs=1 Rename saveas <args> | call delete(expand('#')) | bd #")
vim.cmd("set viminfo=%,<800,'10,/50,:100,h,f0,n~/.config/viminfo")
vim.cmd("set viminfo=%,<800,'10,/50,:100,h,f0,n~/.config/viminfo")

vim.fn.sign_define(
    "DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError", linehl = "DiagnosticLineError", numhl = "" }
)
vim.fn.sign_define(
    "DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn", linehl = "DiagnosticLineWarn", numhl = "" }
)
vim.fn.sign_define(
    "DiagnosticSignWarning",
    { text = " ", texthl = "DiagnosticSignWarning", linehl = "DiagnosticLineWarning", numhl = "" }
)
vim.fn.sign_define(
    "DiagnosticSignInformation",
    { text = " ", texthl = "DiagnosticSignInformation", linehl = "DiagnosticLineInformation", numhl = "" }
)
vim.fn.sign_define(
    "DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo", linehl = "DiagnosticLineInfo", numhl = "" }
)
vim.fn.sign_define(
    "DiagnosticSignHing",
    { text = " ", texthl = "DiagnosticSignHint", linehl = "DiagnosticLineHint", numhl = "" }
)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
    {
        "junegunn/fzf",
        build = "fzf#install()",
    },
    {
        "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup()
        end
    },
    "glepnir/galaxyline.nvim",
    "ntpeters/vim-better-whitespace",
    "notseanray/nerd-galaxyline",
    "chrisbra/csv.vim",
    "junegunn/fzf.vim",
    {
	"numToStr/Comment.nvim",
	    config = function()
		require('Comment').setup()
	    end
    },
    {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
              enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
              suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
              operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
              motions = true, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = true, -- default bindings on <c-w>
              nav = true, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true, -- bindings for prefixed with g
            },
          },
          -- add operators that will trigger motion and text object completion
          -- to enable all native operators, set the preset / operators plugin above
          operators = { gc = "Comments" },
          key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
          },
          popup_mappings = {
            scroll_down = '<c-d>', -- binding to scroll down inside the popup
            scroll_up = '<c-u>', -- binding to scroll up inside the popup
          },
          window = {
            border = "none", -- none, single, double, shadow
            position = "top", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 20
          },
          layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
          },
          ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
          hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
          -- triggers = {"<leader>"} -- or specify a list manually
          triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
          },
          -- disable the WhichKey popup for certain buf types and file types.
          -- Disabled by deafult for Telescope
          disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
          },
          }
      end
    },
  {
	  "kevinhwang91/nvim-hlslens",
	  config = function()
		  require("hlslens").setup()
	  end
  },
  {
      'stevearc/dressing.nvim',
      opts = {},
      config = function()
          require('dressing').setup({
              input = {
                -- Set to false to disable the vim.ui.input implementation
                enabled = true,

                -- Default prompt string
                default_prompt = "Input:",

                -- Can be 'left', 'right', or 'center'
                prompt_align = "left",

                -- When true, <Esc> will close the modal
                insert_only = true,

                -- When true, input will start in insert mode.
                start_in_insert = true,

                -- These are passed to nvim_open_win
                anchor = "SW",
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "cursor",

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                prefer_width = 40,
                width = nil,
                -- min_width and max_width can be a list of mixed types.
                -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },

                -- Window transparency (0-100)
                winblend = 10,
                -- Change default highlight groups (see :help winhl)
                winhighlight = "",

                -- Set to `false` to disable
                mappings = {
                  n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                  },
                  i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<Up>"] = "HistoryPrev",
                    ["<Down>"] = "HistoryNext",
                  },
                },

                override = function(conf)
                  -- This is the config that will be passed to nvim_open_win.
                  -- Change values here to customize the layout
                  return conf
                end,

                -- see :help dressing_get_config
                get_config = nil,
              },
              select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,

                -- Priority list of preferred vim.select implementations
                backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

                -- Trim trailing `:` from prompt
                trim_prompt = true,

                -- Options for telescope selector
                -- These are passed into the telescope picker directly. Can be used like:
                -- telescope = require('telescope.themes').get_ivy({...})
                telescope = nil,

                -- Options for fzf selector
                fzf = {
                  window = {
                    width = 0.5,
                    height = 0.4,
                  },
                },

                -- Options for fzf_lua selector
                fzf_lua = {
                  winopts = {
                    width = 0.5,
                    height = 0.4,
                  },
                },

                -- Options for nui Menu
                nui = {
                  position = "50%",
                  size = nil,
                  relative = "editor",
                  border = {
                    style = "rounded",
                  },
                  buf_options = {
                    swapfile = false,
                    filetype = "DressingSelect",
                  },
                  win_options = {
                    winblend = 10,
                  },
                  max_width = 80,
                  max_height = 40,
                  min_width = 40,
                  min_height = 10,
                },

                -- Options for built-in selector
                builtin = {
                  -- These are passed to nvim_open_win
                  anchor = "NW",
                  border = "rounded",
                  -- 'editor' and 'win' will default to being centered
                  relative = "editor",

                  -- Window transparency (0-100)
                  winblend = 10,
                  -- Change default highlight groups (see :help winhl)
                  winhighlight = "",

                  -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                  -- the min_ and max_ options can be a list of mixed types.
                  -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                  width = nil,
                  max_width = { 140, 0.8 },
                  min_width = { 40, 0.2 },
                  height = nil,
                  max_height = 0.9,
                  min_height = { 10, 0.2 },

                  -- Set to `false` to disable
                  mappings = {
                    ["<Esc>"] = "Close",
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                  },

                  override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                  end,
                },

                -- Used to override format_item. See :help dressing-format
                format_item_override = {},

                -- see :help dressing_get_config
                get_config = nil,
              },
            })
      end
  },
  { "projekt0n/github-nvim-theme", lazy = false },
  -- { "ayu-theme/ayu-vim", lazy = false },
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  {
	  "lewis6991/gitsigns.nvim",
	config = function()
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
  update_debounce = 1000,
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

	end
  },
  "sbdchd/neoformat",
  {
    "ggandor/flit.nvim",
    config = function()
        require('flit').setup {
          keys = { f = 'f', F = 'F', t = 't', T = 'T' },
          -- A string like "nv", "nvo", "o", etc.
          labeled_modes = "v",
          multiline = true,
          -- Like `leap`s similar argument (call-specific overrides).
          -- E.g.: opts = { equivalence_classes = {} }
          opts = {}
        }

    end
  },
  { "nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require'nvim-treesitter.configs'.setup {
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 12000, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
  -- A list of parser names, or "all"
  ensure_installed = { "rust", "lua", "c", "python" },
  ignore_install = { "regex" },

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

	end,
},
{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

    end
},
{
	"simrat39/rust-tools.nvim",
	config = function()
local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        --hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
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
        auto_focus = true,
    },
}

require('rust-tools').setup(opts)
	end
},
{
    "williamboman/mason-lspconfig.nvim",
    config = function()
        local MASON_DEFAULT = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = { "rust_analyzer", "tsserver", "tailwindcss", "pylsp", "vuels", "svelte" },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = true,
}
require("mason-lspconfig").setup(MASON_DEFAULT)

    end
},
"p00f/nvim-ts-rainbow",
{
    "iamcco/markdown-preview.nvim",
    build = "mkdp#util#install()",
},
{
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
},
{
	"jedrzejboczar/possession.nvim",
	config = function()
		require('possession').setup {
	    commands = {
		save = 'SSave',
		load = 'SLoad',
		delete = 'SDelete',
		list = 'SList',
	    }
	}
	end

},
"kyazdani42/nvim-web-devicons",
{
    "nvim-telescope/telescope.nvim",
    config = function()
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
require('telescope').load_extension('possession')

local nvim_lsp = require'lspconfig'

local kopts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, kopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, kopts)


-- require("document-color").setup {
--     -- Default options
--     mode = "background", -- "background" | "foreground" | "single"
-- }
--
-- local on_attach = function(client)
--   if client.server_capabilities.colorProvider then
--     -- Attach document colour support
--     require("document-color").buf_attach(bufnr)
--   end
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- BEING UFO
-- -- nvim ufo folding
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
--
-- -- You are now capable!
-- capabilities.textDocument.colorProvider = {
--   dynamicRegistration = true
-- }

-- Lsp servers that support documentColor
require("lspconfig").tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

-- local ftMap = {
--     vim = 'indent',
--     python = {'indent'},
--     git = ''
-- }
--
-- local handler = function(virtText, lnum, endLnum, width, truncate)
--     local newVirtText = {}
--     local suffix = ('  %d '):format(endLnum - lnum)
--     local sufWidth = vim.fn.strdisplaywidth(suffix)
--     local targetWidth = width - sufWidth
--     local curWidth = 0
--     for _, chunk in ipairs(virtText) do
--         local chunkText = chunk[1]
--         local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--         if targetWidth > curWidth + chunkWidth then
--             table.insert(newVirtText, chunk)
--         else
--             chunkText = truncate(chunkText, targetWidth - curWidth)
--             local hlGroup = chunk[2]
--             table.insert(newVirtText, {chunkText, hlGroup})
--             chunkWidth = vim.fn.strdisplaywidth(chunkText)
--             -- str width returned from truncate() may less than 2nd argument, need padding
--             if curWidth + chunkWidth < targetWidth then
--                 suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
--             end
--             break
--         end
--         curWidth = curWidth + chunkWidth
--     end
--     table.insert(newVirtText, {suffix, 'MoreMsg'})
--     return newVirtText
-- end
--
-- vim.keymap.set('n', 'zK', function()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--         -- choose one of them
--         -- coc.nvim
--         -- vim.fn.CocActionAsync('definitionHover')
--         -- nvimlsp
--         vim.lsp.buf.hover()
--     end
-- end)
--
-- require('ufo').setup({
--     fold_virt_text_handler = handler,
--     open_fold_hl_timeout = 100,
--     close_fold_kinds = {'imports', 'comment'},
--     preview = {
--         win_config = {
--             border = {'', '─', '', '', '', '─', '', ''},
--             winhighlight = 'Normal:Folded',
--             winblend = 0
--         },
--         mappings = {
--             scrollU = '<C-u>',
--             scrollD = '<C-d>'
--         }
--     },
--     provider_selector = function(bufnr, filetype, buftype)
--         -- if you prefer treesitter provider rather than lsp,
--         -- return ftMap[filetype] or {'treesitter', 'indent'}
--         -- return ftMap[filetype]
--         return {'treesitter', 'indent'}
--
--         -- refer to ./doc/example.lua for detail
--     end
-- })
--
-- local coq = require"coq"
-- END UFO

local servers = { 'tsserver', 'tailwindcss' }

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        capabilities = capabilities,
    })
end

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
    accent = '#be5e67', -- orange
    accent_sec = '#a89984', -- fg4
    bg = '#0f101a', -- bg1
    bg_sec = '#3b4252', -- bg2
    fg = '#e5e9f0', -- fg2
    fg_sec = '#d8dee9', -- fg3
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
  local palette = palettes.gruvbox_dark
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
},
"nanozuki/tabby.nvim",
"nvim-telescope/telescope-fzf-native.nvim",
"hrsh7th/cmp-vsnip",
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-path",
"hrsh7th/cmp-buffer",
"hrsh7th/vim-vsnip",
{
	"hrsh7th/nvim-cmp",
	config = function()
        local cmp = require("cmp")
		cmp.setup({
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
})

	end

},
{
    -- "lukas-reineke/headlines.nvim",
    -- dependencies = "nvim-treesitter/nvim-treesitter",
    -- config = function()
    --     require("headlines").setup {
    --     markdown = {
    --         query = vim.treesitter.parse_query(
    --             "markdown",
    --             [[
    --                 (atx_heading [
    --                     (atx_h1_marker)
    --                     (atx_h2_marker)
    --                     (atx_h3_marker)
    --                     (atx_h4_marker)
    --                     (atx_h5_marker)
    --                     (atx_h6_marker)
    --                 ] @headline)
    --
    --                 (thematic_break) @dash
    --
    --                 (fenced_code_block) @codeblock
    --
    --                 (block_quote_marker) @quote
    --                 (block_quote (paragraph (inline (block_continuation) @quote)))
    --             ]]
    --         ),
    --         headline_highlights = { "Headline" },
    --         codeblock_highlight = "CodeBlock",
    --         dash_highlight = "Dash",
    --         dash_string = "-",
    --         quote_highlight = "Quote",
    --         quote_string = "┃",
    --         fat_headlines = true,
    --         fat_headline_upper_string = "▃",
    --         fat_headline_lower_string = "🬂",
    --     },
    --     rmd = {
    --         query = vim.treesitter.parse_query(
    --             "markdown",
    --             [[
    --                 (atx_heading [
    --                     (atx_h1_marker)
    --                     (atx_h2_marker)
    --                     (atx_h3_marker)
    --                     (atx_h4_marker)
    --                     (atx_h5_marker)
    --                     (atx_h6_marker)
    --                 ] @headline)
    --
    --                 (thematic_break) @dash
    --
    --                 (fenced_code_block) @codeblock
    --
    --                 (block_quote_marker) @quote
    --                 (block_quote (paragraph (inline (block_continuation) @quote)))
    --             ]]
    --         ),
    --         treesitter_language = "markdown",
    --         headline_highlights = { "Headline" },
    --         codeblock_highlight = "CodeBlock",
    --         dash_highlight = "Dash",
    --         dash_string = "-",
    --         quote_highlight = "Quote",
    --         quote_string = "┃",
    --         fat_headlines = true,
    --         fat_headline_upper_string = "▃",
    --         fat_headline_lower_string = "🬂",
    --     },
    --     norg = {
    --         query = vim.treesitter.parse_query(
    --             "norg",
    --             [[
    --                 [
    --                     (heading1_prefix)
    --                     (heading2_prefix)
    --                     (heading3_prefix)
    --                     (heading4_prefix)
    --                     (heading5_prefix)
    --                     (heading6_prefix)
    --                 ] @headline
    --
    --                 (weak_paragraph_delimiter) @dash
    --                 (strong_paragraph_delimiter) @doubledash
    --
    --                 ((ranged_tag
    --                     name: (tag_name) @_name
    --                     (#eq? @_name "code")
    --                 ) @codeblock (#offset! @codeblock 0 0 1 0))
    --
    --                 (quote1_prefix) @quote
    --             ]]
    --         ),
    --         headline_highlights = { "Headline" },
    --         codeblock_highlight = "CodeBlock",
    --         dash_highlight = "Dash",
    --         dash_string = "-",
    --         doubledash_highlight = "DoubleDash",
    --         doubledash_string = "=",
    --         quote_highlight = "Quote",
    --         quote_string = "┃",
    --         fat_headlines = true,
    --         fat_headline_upper_string = "▃",
    --         fat_headline_lower_string = "🬂",
    --     },
    --     org = {
    --         query = vim.treesitter.parse_query(
    --             "org",
    --             [[
    --                 (headline (stars) @headline)
    --
    --                 (
    --                     (expr) @dash
    --                     (#match? @dash "^-----+$")
    --                 )
    --
    --                 (block
    --                     name: (expr) @_name
    --                     (#eq? @_name "SRC")
    --                 ) @codeblock
    --
    --                 (paragraph . (expr) @quote
    --                     (#eq? @quote ">")
    --                 )
    --             ]]
    --         ),
    --         headline_highlights = { "Headline" },
    --         codeblock_highlight = "CodeBlock",
    --         dash_highlight = "Dash",
    --         dash_string = "-",
    --         quote_highlight = "Quote",
    --         quote_string = "┃",
    --         fat_headlines = true,
    --         fat_headline_upper_string = "▃",
    --         fat_headline_lower_string = "🬂",
    --     },
    -- }
    -- end
},
{
    "neovim/nvim-lspconfig",
    config = function()
        local nvim_lsp = require'lspconfig'

local kopts = { noremap=true, silent=true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, kopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, kopts)

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        --hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
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
        auto_focus = true,
    },
}

-- require("document-color").setup {
--     -- Default options
--     mode = "background", -- "background" | "foreground" | "single"
-- }
--
-- local on_attach = function(client)
--   if client.server_capabilities.colorProvider then
--     -- Attach document colour support
--     require("document-color").buf_attach(bufnr)
--   end
-- end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- BEING UFO
-- -- nvim ufo folding
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
--
-- -- You are now capable!
-- capabilities.textDocument.colorProvider = {
--   dynamicRegistration = true
-- }

-- Lsp servers that support documentColor
require("lspconfig").tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

-- local ftMap = {
--     vim = 'indent',
--     python = {'indent'},
--     git = ''
-- }
--
-- local handler = function(virtText, lnum, endLnum, width, truncate)
--     local newVirtText = {}
--     local suffix = ('  %d '):format(endLnum - lnum)
--     local sufWidth = vim.fn.strdisplaywidth(suffix)
--     local targetWidth = width - sufWidth
--     local curWidth = 0
--     for _, chunk in ipairs(virtText) do
--         local chunkText = chunk[1]
--         local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--         if targetWidth > curWidth + chunkWidth then
--             table.insert(newVirtText, chunk)
--         else
--             chunkText = truncate(chunkText, targetWidth - curWidth)
--             local hlGroup = chunk[2]
--             table.insert(newVirtText, {chunkText, hlGroup})
--             chunkWidth = vim.fn.strdisplaywidth(chunkText)
--             -- str width returned from truncate() may less than 2nd argument, need padding
--             if curWidth + chunkWidth < targetWidth then
--                 suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
--             end
--             break
--         end
--         curWidth = curWidth + chunkWidth
--     end
--     table.insert(newVirtText, {suffix, 'MoreMsg'})
--     return newVirtText
-- end
--
-- vim.keymap.set('n', 'zK', function()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--         -- choose one of them
--         -- coc.nvim
--         -- vim.fn.CocActionAsync('definitionHover')
--         -- nvimlsp
--         vim.lsp.buf.hover()
--     end
-- end)
--
-- require('ufo').setup({
--     fold_virt_text_handler = handler,
--     open_fold_hl_timeout = 100,
--     close_fold_kinds = {'imports', 'comment'},
--     preview = {
--         win_config = {
--             border = {'', '─', '', '', '', '─', '', ''},
--             winhighlight = 'Normal:Folded',
--             winblend = 0
--         },
--         mappings = {
--             scrollU = '<C-u>',
--             scrollD = '<C-d>'
--         }
--     },
--     provider_selector = function(bufnr, filetype, buftype)
--         -- if you prefer treesitter provider rather than lsp,
--         -- return ftMap[filetype] or {'treesitter', 'indent'}
--         -- return ftMap[filetype]
--         return {'treesitter', 'indent'}
--
--         -- refer to ./doc/example.lua for detail
--     end
-- })
--
-- local coq = require"coq"
-- END UFO

local servers = { 'tsserver', 'tailwindcss' }

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup({
        capabilities = capabilities,
    })
end

    end
},

  "wakatime/vim-wakatime",
  "tpope/vim-repeat",
  {
	  "windwp/nvim-autopairs",
	  config = function()
		  require("nvim-autopairs").setup({
			  enable_check_bracket_line = false
		  })
	  end
  },
  "tpope/vim-repeat",
  {
      "ggandor/leap.nvim",
      config = function()
          require('leap').add_default_mappings()
            vim.keymap.del({'x', 'o'}, 'x')
            vim.keymap.del({'x', 'o'}, 'X')
      end
  },
  {
      "ggandor/leap-spooky.nvim",
      config = function()
          require('leap-spooky').setup {
          affixes = {
            -- These will generate mappings for all native text objects, like:
            -- (ir|ar|iR|aR|im|am|iM|aM){obj}.
            -- Special line objects will also be added, by repeating the affixes.
            -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
            -- window.
            -- You can also use 'rest' & 'move' as mnemonics.
            remote   = { window = 'r', cross_window = 'R' },
            magnetic = { window = 'm', cross_window = 'M' },
          },
          -- If this option is set to true, the yanked text will automatically be pasted
          -- at the cursor position if the unnamed register is in use (and the object is
          -- "non-magnetic").
          yank_paste = false,
        }

      end
  },
  "MunifTanjim/nui.nvim",
  {
      "rcarriga/nvim-notify",
      config = function()
          require("notify").setup({
                relative = "editor",
                anchor = "NE",
                width = 50,
                height = 10,
                background_colour = "#c9d2e4",
                render = "minimal",
            })

      end
  },
  "lambdalisue/suda.vim",
  "nvim-lua/plenary.nvim",
  {
	  "sindrets/winshift.nvim",
	  config = function()
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

	  end
  },
  {
  'nyngwang/suave.lua',
  config = function()
    require('suave').setup {
      -- menu_height = 6,
      auto_save = {
        enabled = true,
        -- exclude_filetypes = {},
      },
      store_hooks = {
        -- WARN: DON'T call `vim.cmd('wa')` here. Use `setup.auto_save` instead. (See #4)
        before_mksession = {
          -- function ()
          --   -- `rcarriga/nvim-dap-ui`.
          --   require('dapui').close()
          -- end,
          -- function ()
          --   -- `nvim-neo-tree/neo-tree.nvim`.
          --   for _, w in ipairs(vim.api.nvim_list_wins()) do
          --     if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), 'ft') == 'neo-tree' then
          --       vim.api.nvim_win_close(w, false)
          --     end
          --   end
          -- end,
        },
        after_mksession = {
          -- NOTE: the `data` param is Lua table, which will be stored in json format under `.suave/` folder.
          function (data)
            -- store current colorscheme.
            data.colorscheme = vim.g.colors_name
          end,
        },
      },
      restore_hooks = {
        after_source = {
          function (data)
            if not data then return end
            -- restore colorscheme.
            vim.cmd(string.format([[
              color %s
              doau ColorScheme %s
            ]], data.colorscheme, data.colorscheme))
          end,
        },
      }
    }
  end
},
  {
      "norcalli/nvim-colorizer.lua",
      config = function()
          require'colorizer'.setup()
      end
  },
  "folke/neodev.nvim",
  {
	  "gbprod/yanky.nvim",
	  config = function()
		  require("yanky").setup({
			  ring = {
			    history_length = 100,
			    storage = "shada",
			    sync_with_numbered_registers = true,
			    cancel_event = "update",
			  },
			  picker = {
			    select = {
			      action = nil, -- nil to use default put action
			    },
			    telescope = {
			      mappings = nil, -- nil to use default mappings
			    },
			  },
			  system_clipboard = {
			    sync_with_ring = true,
			  },
			  highlight = {
			    on_put = true,
			    on_yank = true,
			    timer = 100,
			  },
			  preserve_cursor_position = {
			    enabled = true,
			  },
			})
	end,
  },
  {
  "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    sort_function = nil , -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "+",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖",-- this can only be used in the git_status source
          renamed   = "",-- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "",
          staged    = "",
          conflict  = "",
        }
      },
    },
    window = {
      position = "left",
      width = 26,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        --["Z"] = "expand_all_nodes",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none" -- "none", "relative", "absolute"
          }
        },
        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      }
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = true, -- This will find and focus the file in the active buffer every
                                   -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                              -- in whatever position is specified in window.position
                            -- "open_current",  -- netrw disabled, opening a directory opens within the
                                              -- window like netrw would, regardless of window.position
                            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        }
      }
    },
    buffers = {
      follow_current_file = true, -- This will find and focus the file in the active buffer every
                                   -- time the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        }
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        }
      }
  }})

    end,
}
})

-- prettier for formatting on save
vim.g.neoformat_try_node_exe = 1

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function get_visual_selection()
    -- Yank current visual selection into the 'v' register
    --
    -- Note that this makes no effort to preserve this register
    vim.cmd('noau normal! "vy"')

    return vim.fn.getreg('v')
end

vim.cmd [[
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
]]

vim.cmd [[
function! g:ChmodOnWrite()
  if v:cmdbang
    silent !chmod u+w %
  endif
endfunction
]]

map("v", "<C-c>", ":y+\" | y+%<ENTER>", { noremap = true, silent = true, nowait = true })
map("v", "<C-x>", ":d+\" | d+%<ENTER>", { noremap = true, silent = true })
map("v", "<p>", ":\"+p", { silent = true })
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "gl", ":bn<ENTER>", { silent = true })
map("n", "gh", ":bp<ENTER>", { silent = true })
map("n", "gk", ":bp<bar>sp<bar>bn<bar>bd<ENTER>", { silent = true })
map("n", "<esc>", ":noh<ENTER>", { silent = true })
map("n", "t", ":terminal<ENTER>", { silent = true })
map("n", "<c-]>", ":lua vim.lsp.buf.definition()<ENTER>", { silent = true })
map("n", "K", ":lua vim.lsp.buf.hover()<ENTER>", { silent = true })
map("n", "gD", ":lua vim.lsp.buf.implementation()<ENTER>", { silent = true })
map("n", "<c-K>", ":lua vim.lsp.buf.signature_help()<ENTER>", { silent = true })
map("n", "1gD", ":lua vim.lsp.buf.type_definition()<ENTER>", { silent = true })
map("n", "gr", ":lua vim.lsp.buf.references()<ENTER>", { silent = true })
map("n", "g0", ":lua vim.lsp.buf.document_symbol()<ENTER>", { silent = true })
map("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<ENTER>", { silent = true })
map("n", "gd", ":lua vim.lsp.buf.definition<ENTER>", { silent = true })
map("n", "ga", ":lua vim.lsp.buf.code_action()<ENTER>", { silent = true })
map("n", "<C-b>", ":Telescope buffers<ENTER>", { silent = true })
map("n", "<C-f>", ":Telescope live_grep", { silent = true })
map("n", "g[", ":lua vim.diagnostic.goto_prev()", { silent = true })
map("n", "g]", ":lua vim.diagnostic.goto_next()", { silent = true })
map("n", "gss", ":SList<ENTER>", { silent = true })
map("n", "gsl", ":SLoad", { silent = true })
map("n", "gsn", ":SSave<ENTER>", { silent = true })
map("n", "<C-s>", "/")
map("v", "<C-s>", "gc")
map("n", "<C-p>", ":lua require(\"notify\").dismiss()<ENTER>", { silent = true })
map("n", "<C-W>", ":WinShift<ENTER>")
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
--map("n", "K", ":call <SID>show_documentation()", { silent = true })

-- map("n", "<C-f", ":Neoformat<ENTER>")

-- vim.g.ayucolor="dark"
local colorscheme = "github_dark_colorblind"
local _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

vim.g.clipboard=unnamedplus
vim.g.rainbow_active = 1
--vim.g.indentLine_fileTypeExclude = ['dashboard']
--vim.g.better_whitespace_filetypes_blacklist = ['dashboard', 'terminal', 'neo-tree', 'md', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive']
vim.cmd("let g:indentLine_fileTypeExclude = ['dashboard']")
vim.cmd("let g:better_whitespace_filetypes_blacklist = ['dashboard', 'terminal', 'neo-tree', 'md', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'zsh', 'bash', '', ]")
vim.g.strip_whitespace_confirm=0
vim.g.current_line_whitespace_disabled_hard=1
vim.g.current_line_whitespace_disabled_soft=1


local function set_tab(n)
	vim.o.tabstop = n
	vim.o.shiftwidth = n
	vim.o.softtabstop = n
	vim.opt.expandtab = true
	vim.opt.autoindent = true
	vim.opt.smartindent = true
end
set_tab(4)


vim.cmd [[
function! Trim()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()
autocmd BufWritePost * call Trim()
]]

vim.cmd [[highlight Headline1 guibg=#1e2718]]
vim.cmd [[highlight Headline2 guibg=#21262d]]
vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]


if vim.g.filetype == "neo-tree" then
	map("n", "o", "<ENTER>", { silent = true })
end
map("n", "<C-n>", ":NeoTreeShowToggle<ENTER>", { silent = true })
map("n", "<C-h>", ":call WinMove('h')<ENTER>", { silent = true })
map("n", "<C-j>", ":call WinMove('j')<ENTER>", { silent = true })
map("n", "<C-k>", ":call WinMove('k')<ENTER>", { silent = true })
map("n", "<C-l>", ":call WinMove('l')<ENTER>", { silent = true })
