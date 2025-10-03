-- Neovim configuration with native LSP
-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic vim settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = false
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.mouse = ""
vim.opt.cmdheight = 2
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200
vim.opt.clipboard = "unnamed"
vim.opt.backspace = "indent,eol,start"
vim.opt.startofline = false

-- Different indentation for yaml
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Whitespace settings
vim.opt.listchars = "eol:↵,trail:~,tab:>-,nbsp:␣"
vim.api.nvim_set_hl(0, "whiteSpaceError", { link = "Error" })
-- Use autocmd for whitespace highlighting to avoid conflicts
vim.api.nvim_create_autocmd({"BufWinEnter", "BufRead"}, {
  pattern = "*",
  callback = function()
    vim.fn.matchadd("whiteSpaceError", "\\s\\+$")
  end,
})

-- Plugin setup with lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,
          custom = {},
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        files = {
          file_ignore_patterns = { "%.pyc$", "__pycache__" },
        },
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP config with auto-install
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls" },
      })
    end,
  },


  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc", "query" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
        },
      })
    end,
  },

  -- Colorscheme
  {
    "morhetz/gruvbox",
    config = function()
      vim.g.gruvbox_contrast_dark = "hard"
      vim.opt.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Other plugins
  --"leafgarland/typescript-vim",
  --"udalov/kotlin-vim",
  --"tpope/vim-vinegar",
  --"rust-lang/rust.vim",
  --"vim-autoformat/vim-autoformat",
  --"github/copilot.vim",
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  -- Java LSP
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
})

-- Copilot configuration
require("copilot").setup({
  suggestion = { enabled = true, auto_trigger = true },
  panel      = { enabled = false },
})
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
--vim.g.copilot_tab_fallback = ""

-- LSP Configuration
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
    severity_limit = "Warning", -- Only show warnings and errors
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- LSP capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Function to detect uv environment
local util = require("lspconfig.util")
local function get_python_path(workspace)
  -- 1) Try finding a .venv folder in or above the cwd
  local root = util.root_pattern(".venv")(workspace or vim.fn.getcwd())
  if root then
    local py = root .. "/.venv/bin/python"
    if vim.fn.executable(py) == 1 then
      return py
    end
  end

  -- 2) If uv is available, use its shim’d python
  if vim.fn.executable("uv") == 1 then
    local uv_py = vim.trim(vim.fn.system("uv which python"))
    if uv_py ~= "" and vim.fn.executable(uv_py) == 1 then
      return uv_py
    end
  end

  -- 3) System fallback
  return vim.fn.exepath("python3")
      or vim.fn.exepath("python")
      or "python"
end

-- Python LSP setup
lspconfig.pyright.setup({
  capabilities = capabilities,
  before_init = function(_, config)
    local py = get_python_path(config.root_dir)
    print("→ Pyright using: ", py)
    config.settings.python.pythonPath = py
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Ruff LSP for linting and formatting
lspconfig.ruff.setup({
  capabilities = capabilities,
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    
    -- Diagnostic navigation and display
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
  end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("LspFormatting", {}),
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Auto-close quickfix when selecting an item
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
  end,
})

-- Autocompletion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        return require("copilot.suggestion").accept()
      elseif cmp.visible() then
        return cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        return luasnip.expand_or_jump()
      else
        return fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").jumpable(-1) then
        return require("copilot.suggestion").jump(-1)
      elseif cmp.visible() then
        return cmp.select_prev_item()
      else
        return fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- Key mappings
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "<C-L>", ":nohl<CR><C-L>")

-- Tab navigation
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "[t", ":tabprevious<CR>")
vim.keymap.set("n", "]T", ":tablast<CR>")
vim.keymap.set("n", "[T", ":tabfirst<CR>")

-- Buffer navigation
vim.keymap.set("n", "]b", ":bnext<CR>")
vim.keymap.set("n", "[b", ":bprevious<CR>")
vim.keymap.set("n", "gn", ":bnext<CR>")
vim.keymap.set("n", "gp", ":bprevious<CR>")
vim.keymap.set("n", "gl", ":ls<CR>")
vim.keymap.set("n", "gb", ":ls<CR>:b")
vim.keymap.set("n", "gq", ":bd<CR>")

-- File explorer
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", ",n", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-X>", ":Explore<CR>")

-- fzf-lua
vim.keymap.set("n", ";", "<cmd>lua require('fzf-lua').files()<cr>")
vim.keymap.set("n", "fg", "<cmd>lua require('fzf-lua').live_grep()<cr>")
vim.keymap.set("n", "fb", "<cmd>lua require('fzf-lua').buffers()<cr>")
vim.keymap.set("n", "fh", "<cmd>lua require('fzf-lua').help_tags()<cr>")

-- Git signs
vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<cr>")
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<cr>")
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>")

-- Commands
vim.api.nvim_create_user_command("Vimrc", "e $HOME/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("Source", "source $HOME/.config/nvim/init.lua", {})

-- Formatting
vim.keymap.set("n", "<F3>", function()
  vim.lsp.buf.format({ async = true })
end)

-- Paste mode toggle
vim.keymap.set("n", "<F11>", ":set paste!<CR>")

-- Clipboard
vim.keymap.set("n", "<leader>c", '"+y')
vim.keymap.set("v", "<leader>c", '"+y')
