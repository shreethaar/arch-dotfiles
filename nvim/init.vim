call plug#begin('~/.vim/plugged')

" Grubbox colorscheme"
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-tree/nvim-web-devicons' " Optional for file icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Recommended for better syntax highlighting

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


" Golang Plugins - just using ray-x/go.nvim now
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua', { 'do': 'cd lua && ./install.sh' }

" LSP Configurations
" (removed duplicate nvim-lspconfig)

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
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

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
" Add Harpoon for quick file navigation
Plug 'ThePrimeagen/harpoon'
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
set shortmess+=I "disable the default intro message
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

" Grubbox configurations
" Set up terminal colors
set termguicolors
" Set contrast level (options: 'hard', 'medium', 'soft')
let g:gruvbox_contrast_dark = 'hard'


" config for fzf
if exists('g:loaded_fzf') && !exists('g:fzf_loaded')
  " Set FZF default command (respects .gitignore if available)
  if executable('rg')
    " Use ripgrep for faster, smarter searching
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  elseif executable('fd')
    " Use fd as fallback
    let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
  else
    " Default to find
    let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*"'
  endif

  " FZF layout configuration
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
  let g:fzf_buffers_jump = 1  " Jump to existing buffer if available

  " Customize appearance
  let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

  " Key mappings
  nnoremap <silent> <C-p> :Files<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>h :History<CR>
  nnoremap <silent> <leader>t :BTags<CR>
  nnoremap <silent> <leader>T :Tags<CR>
  nnoremap <silent> <leader>l :BLines<CR>
  nnoremap <silent> <leader>L :Lines<CR>
  nnoremap <silent> <leader>m :Marks<CR>
  nnoremap <silent> <leader>c :Commits<CR>
  nnoremap <silent> <leader>C :BCommits<CR>
  nnoremap <silent> <leader>rg :Rg<CR>
  nnoremap <silent> <leader>gs :GFiles?<CR>

  " Command mode mappings
  cnoremap <C-p> <C-R>=fzf#vim#complete#path()<CR>
  cnoremap <expr> <C-x><C-f> fzf#vim#complete#path('blah')

  " Custom commands
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  " Advanced: Customize statusline in FZF window
  augroup fzf_status
    autocmd! FileType fzf
    autocmd FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup END
endif


" Lua configurations
lua << EOF

require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})


local ascii_art = {
    "0x251e IS SOO BACCKKK!"
}

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        for _, line in ipairs(ascii_art) do
            print(line)
        end
    end
})



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
    },
    -- Add Go-specific pickers
    go_implementations = {
      theme = "dropdown"
    },
    go_references = {
      theme = "dropdown"
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
  ensure_installed = { 'c', 'cpp', 'rust', 'go' ,'python', 'javascript', 'typescript'}, -- Added Go
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
    
    -- Go-specific keybindings - now using go.nvim style commands
    vim.keymap.set('n', '<leader>gi', '<cmd>lua require("telescope").extensions.go.implements()<CR>', { buffer = bufnr })
    vim.keymap.set('n', '<leader>gr', '<cmd>lua require("telescope").extensions.go.references()<CR>', { buffer = bufnr })
  end
}

-- Updated go.nvim setup
require('go').setup({
  -- Autoformat on save
  gofmt = 'gopls',
  goimports = 'gopls',
  
  -- Diagnostic configuration
  diagnostic = {
    hdlr = true,  -- Enable handler
    underline = true,
    virtual_text = {spacing = 0},
    signs = true,
  },
  
  -- Linter configuration - make sure it's installed
  linter = 'golangci-lint',
  
  -- Test configuration
  test_runner = 'go',
  
  -- Run gofmt + goimports on save
  run_in_floaterm = true,
  
  -- Include all the go tools
  install_all_deps = true
})

-- Harpoon setup
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Keymaps for Harpoon
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Navigation shortcuts
vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
EOF

" Telescope Keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
" Updated Go keybindings for Telescope
nnoremap <leader>gi <cmd>lua require('telescope').extensions.go.implements()<cr>
nnoremap <leader>gr <cmd>lua require('telescope').extensions.go.references()<cr>



" Set colorscheme
colorscheme gruvbox

" Optional: Set background (light or dark)
set background=dark



" Create a custom startup screen with autocmd
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | call YourCustomStartFunction() | endif

function! YourCustomStartFunction()
  " Clear the buffer
  enew
  " Set buffer options
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  
  " Get the current window width
  let s:width = &columns
  
  " Create a function to center text
  function! s:CenterText(text)
    let indent = (s:width - len(a:text)) / 2
    return repeat(' ', indent > 0 ? indent : 0) . a:text
  endfunction

  " ASCII art as a single block - we'll center this as a whole
  let s:nvim_logo = [
        \ '                                            ',
        \ '         ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
        \ '         ████╗  ██║██║   ██║██║████╗ ████║',
        \ '         ██╔██╗ ██║██║   ██║██║██╔████╔██║',
        \ '         ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        \ '         ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
        \ '         ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝'
        \ ]
  
  " Calculate the width of the ASCII art (assume all lines are the same width)
  let s:logo_width = len(s:nvim_logo[0])
  let s:logo_indent = (s:width - s:logo_width) / 2
  let s:logo_space = repeat(' ', s:logo_indent > 0 ? s:logo_indent : 0)
  
  " Add your custom text/ASCII art with centering
  let s:lines = []
  call add(s:lines, '')
  
  " Add the logo with consistent padding
  for line in s:nvim_logo
    call add(s:lines, s:logo_space . line)
  endfor
  
  " Add the rest of the content
  call extend(s:lines, [
        \ '',
        \ s:CenterText('Run PlugUpdate and PlugUpgrade from time to time :)'),
        \ '',
        \ s:CenterText('─── Installed Plugins ───'),
        \ '',
        \ s:CenterText('Theme: gruvbox.nvim'),
        \ s:CenterText('Icons: nvim-web-devicons'),
        \ s:CenterText('Syntax: nvim-treesitter'),
        \ '',
        \ s:CenterText('─── Languages Support ───'),
        \ '',
        \ s:CenterText('Go: ray-x/go.nvim'),
        \ s:CenterText('Rust: rust-tools.nvim'),
        \ s:CenterText('C#: omnisharp-vim'),
        \ '',
        \ s:CenterText('─── Core Tools ───'),
        \ '',
        \ s:CenterText('Search: fzf + telescope'),
        \ s:CenterText('LSP: nvim-lspconfig'),
        \ s:CenterText('Completion: nvim-cmp'),
        \ s:CenterText('Debug: nvim-dap'),
        \ s:CenterText('Navigation: harpoon'),
        \ '',
        \ s:CenterText('─── Commands ───'),
        \ '',
        \ s:CenterText('[c] Create file    [f] Find files    [q] Quit'),
        \ s:CenterText('[e] File explorer  [p] Find plugin   [?] Help'),
        \ s:CenterText('[h] Harpoon        [t] Typr          [v] Vim-be-good'),
        \ '',
        \])
  
  " Add the lines to the buffer
  call append(0, s:lines)
  
  " Set cursor position
  normal! gg
  " Make it non-modifiable
  setlocal nomodifiable nomodified
  " Add keymaps for your custom commands
  nnoremap <buffer> c :enew<CR>
  nnoremap <buffer> e :Explore<CR>
  nnoremap <buffer> q :quit<CR>
  nnoremap <buffer> ? :help<CR>
  nnoremap <buffer> f :Telescope find_files<CR>
  nnoremap <buffer> p :Telescope find_files cwd=~/.vim/plugged/<CR>
  nnoremap <buffer> h :lua require("harpoon.ui").toggle_quick_menu()<CR>
  nnoremap <buffer> t :Typr<CR>
  nnoremap <buffer> v :VimBeGood<CR>
endfunction
