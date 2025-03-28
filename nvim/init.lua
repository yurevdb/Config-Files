vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 0
vim.opt.foldnestmax = 1

-- Usefull stuff
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 300
    })
  end,
})

-- Keymaps
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>e', ':e .<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>')
--vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>')
--vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':lua<CR>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('i', 'jj', '<Esc>')

-- Plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local lsp_keymaps = function()
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  vim.keymap.set('n', 'R', vim.lsp.buf.rename)
  vim.keymap.set('n', 'J', vim.diagnostic.open_float)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action)
  vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references)
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation)
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition)
end

require('lazy').setup({
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "lua-language-server",
        "rust-analyzer",
        "zls",
        "clangd",
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = { preset = "default" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      fuzzy = { implementation = "lua" },
    },
  },
  --LSP config
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- C
      if (vim.fn.executable('clangd') == 1) then
        require('lspconfig').clangd.setup({
          on_attach = lsp_keymaps(),
          capabilities = capabilities
        })
      end
      -- Lua for nvim
      if (vim.fn.executable('lua-language-server') == 1) then
        require('lspconfig').lua_ls.setup({
          on_attach = lsp_keymaps(),
          capabilities = capabilities
        })
      end
      -- GO
      if (vim.fn.executable('gopls') == 1) then
        require('lspconfig').gopls.setup({
          on_attach = lsp_keymaps(),
          capabilities = capabilities,
          single_file_support = true,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
        })
      end
      -- Zig
      if (vim.fn.executable('zls') == 1) then
        require('lspconfig').zls.setup({
          cmd = { '/usr/local/zig/zls' },
          on_attach = lsp_keymaps(),
          capabilities = capabilities,
        })
      end
    end
  },
  -- Usefull things in nvim
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "rust",
          "zig",
          "go",
        },
        auto_install = true,
        sync_install = true,
        highlights = {
          enable = true
        },
        ignore_install = {},
        modules = {},
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
      }
    end
  },
  -- Fun things
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'rose-pine',
          section_seperators = '',
          component_seperators = '',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'filename' },
          lualine_c = { 'branch', 'diff', 'diagnostics' },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        }
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"
      vim.cmd.colorscheme('rose-pine')

      require('rose-pine').setup({
        highlight_groups = {
        },
        before_highlight = {},
        dark_variant = {},
        dim_inactive_windows = {},
        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true
        },
        extend_background_behind_borders = {},
        groups = {},
        palette = {},
        styles = {
          bold = true,
          italic = true,
          transparency = true
        },
        variant = {}
      })
    end
  },
})

