return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
  config = function()
    require('neo-tree').setup {
      window = {
        mappings = {
          ['o'] = 'open',
        },
      },
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        git_status = {
          symbols = {
            added = '✚',
            modified = '💡',
            deleted = '✘',
            renamed = '',
            untracked = '🆕',
            ignored = '',
            unstaged = '🗞',
            staged = '✅',
            conflict = '🥴',
          },
        },
      },
    }
    vim.api.nvim_set_keymap('n', '<Leader>e', ':Neotree reveal<CR>', {
      noremap = true,
      silent = true,
    })
  end,
}
