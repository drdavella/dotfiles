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
vim.fn.matchadd("whiteSpaceError", "\\s\\+$")

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
          custom = { "*.pyc", "*~" },
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
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

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff" },
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
  "github/copilot.vim",
})

-- LSP Configuration
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- LSP capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Function to detect uv environment
local function get_python_path()
  -- Check if we're in a uv environment
  local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
  if vim.v.shell_error == 0 and uv_python ~= "" then
    return uv_python
  end
  
  -- Fallback to system python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- Python LSP setup
lspconfig.pyright.setup({
  capabilities = capabilities,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path()
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
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
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

-- Telescope
vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

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
