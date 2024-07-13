return {
  'akinsho/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'mfussenegger/nvim-dap', -- A√Ø¬ø¬Ωadir la dependencia
    'lukas-reineke/lsp-format.nvim', -- A√É¬±adir la dependencia
  },
  config = function()
    require('flutter-tools').setup {
      lsp = {
        on_attach = function(client, bufnr)
          require('lsp-format').on_attach(client)
        end,
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { vim.fn.expand '$HOME/development/flutter/packages' },
        },
      },
      debugger = { -- integrate with nvim-dap
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
        register_configurations = function(_)
          require('dap').configurations.dart = {}
          require('dap.ext.vscode').load_launchjs()
        end,
      },
      dev_log = {
        open_cmd = 'tabedit',
      },
      outline = {
        open_cmd = '30vnew',
        auto_open = false,
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = 'ErrorMsg',
        prefix = '//',
        enabled = true,
      },
    }
  end,
}
