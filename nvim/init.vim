call plug#begin('~/.vim/plugged')

" Golang Plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua', { 'do': 'cd lua && ./install.sh' }

" LSP Configurations
Plug 'neovim/nvim-lspconfig'

" Rust Tools for enhanced Rust development
Plug 'simrat39/rust-tools.nvim'

" C# Development
Plug 'OmniSharp/omnisharp-vim'  " OmniSharp integration
Plug 'dense-analysis/ale'        " Linting support

" Autocompletion support
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip' " Snippet engine

" Treesitter for syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-neotest/nvim-nio' " Required for nvim-dap-ui

" Telescope and its dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" smear-cursor https://github.com/sphamba/smear-cursor.nvim"
Plug 'sphamba/smear-cursor.nvim'

Plug 'nvzone/volt'  " Add dependency first
Plug 'nvzone/typr'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()

" General settings
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets
set ignorecase              " case insensitive search
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " use system clipboard
filetype plugin on
set ttyfast                 " speed up scrolling in Vim
set relativenumber
nnoremap <leader>rn :set relativenumber!<CR>

" Highlight settings
hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None

" OmniSharp settings
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_highlight_types = 3
let g:OmniSharp_selector_ui = 'fzf'

" ALE settings for C#
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" Lua configurations
lua << EOF
-- Setup LSP and autocompletion
local nvim_lsp = require('lspconfig')
local rt = require('rust-tools')
local cmp = require('cmp')
local cursor = require('smear_cursor').setup({ cursor_color = '#E8E45B' })
local telescope = require('telescope')

-- Telescope setup
telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

-- Load fzf extension
require('telescope').load_extension('fzf')

-- Autocompletion setup
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- C# LSP setup
nvim_lsp.omnisharp.setup({
  cmd = { "omnisharp" },
  on_attach = function(client, bufnr)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, { buffer = bufnr })
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

-- Rust tools setup
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- LSP bindings
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    end,
  }
})

-- Clangd setup for C/C++
nvim_lsp.clangd.setup({
  on_attach = function(client, bufnr)
    -- Keybindings for C/C++
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Treesitter setup
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'rust' }, -- Add other languages if needed
  highlight = {
    enable = true,
  },
})

-- Debugging setup
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb', -- Path to lldb
  name = 'lldb',
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

require('dapui').setup()

-- Go Language Server Configuration
local lspconfig = require('lspconfig')
lspconfig.gopls.setup{
  cmd = {'gopls'},
  -- capabilities inherited from existing LSP setup
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Existing LSP keybindings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    
    -- Go-specific keybindings
    vim.keymap.set('n', '<leader>gi', '<cmd>GoImplements<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>gr', '<cmd>GoReferrers<CR>', { buffer = bufnr })
  end
}

-- Go.nvim setup
require('go').setup({
  -- Autoformat on save
  gofmt = 'gopls',
  -- Additional tools
  goimports = 'gopls',
  
  -- Diagnostic configuration
  diagnostic = {
    hdlr = true,  -- Enable handler
    underline = true,
    virtual_text = {spacing = 0},
    signs = true,
  },
  
  -- Linter configuration
  linter = 'golangci-lint',
  
  -- Test configuration
  test_runner = 'go',
  
  -- Run gofmt + goimports on save
  run_in_floaterm = true
})

-- Add Go to Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 
    -- Existing languages 
    'c', 'cpp', 'rust', 
    -- Add Go
    'go' 
  },
  highlight = {
    enable = true,
  },
})
EOF

" Vim-Go configurations
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_fmt_command = "gopls"
let g:go_imports_mode = "gopls"

" Telescope configuration for Go
lua << EOF
require('telescope').setup{
  pickers = {
    -- Add Go-specific pickers
    go_implementations = {
      theme = "dropdown"
    },
    go_references = {
      theme = "dropdown"
    }
  }
}

EOF

" Telescope Keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>gi <cmd>Telescope go_implementations<cr>
nnoremap <leader>gr <cmd>Telescope go_references<cr>
