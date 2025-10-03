-- Java LSP configuration using nvim-jdtls
local jdtls = require('jdtls')

-- Find jdtls installation (via Mason)
local mason_path = vim.fn.stdpath('data') .. '/mason'
local jdtls_path = mason_path .. '/packages/jdtls'

-- Auto-detect OS and architecture for config path
local function get_config_dir()
  local os_name = vim.loop.os_uname().sysname
  local arch = vim.loop.os_uname().machine

  if os_name == 'Darwin' then
    if arch == 'arm64' then
      return 'config_mac_arm'
    else
      return 'config_mac'
    end
  elseif os_name == 'Linux' then
    if arch:match('arm') or arch:match('aarch64') then
      return 'config_linux_arm'
    else
      return 'config_linux'
    end
  else
    return 'config_win'
  end
end

local config_path = jdtls_path .. '/' .. get_config_dir()
local lombok_path = jdtls_path .. '/lombok.jar'

-- Find the jar file for jdtls
local jar_pattern = jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'
local jar_file = vim.fn.glob(jar_pattern)

-- Check if jdtls is installed
if jar_file == '' then
  vim.notify('jdtls not found. Install it with :MasonInstall jdtls', vim.log.levels.WARN)
  return
end

-- Data directory for workspace
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- Get capabilities from cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configuration for jdtls
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    '-jar', jar_file,
    '-configuration', config_path,
    '-data', workspace_dir,
  },

  root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  capabilities = capabilities,

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = {},
  },
}

-- Start jdtls
jdtls.start_or_attach(config)

-- Java-specific keybindings
local opts = { noremap=true, silent=true, buffer=true }
vim.keymap.set('n', '<leader>jo', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
vim.keymap.set('n', '<leader>jv', "<Cmd>lua require'jdtls'.extract_variable()<CR>", opts)
vim.keymap.set('v', '<leader>jv', "<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>", opts)
vim.keymap.set('n', '<leader>jc', "<Cmd>lua require'jdtls'.extract_constant()<CR>", opts)
vim.keymap.set('v', '<leader>jc', "<Esc><Cmd>lua require'jdtls'.extract_constant(true)<CR>", opts)
vim.keymap.set('v', '<leader>jm', "<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>", opts)
