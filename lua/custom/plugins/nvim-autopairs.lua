return {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true, -- Enable treesitter integration
      ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false,
        solidity = { 'string', 'comment' },
      },
    }
  end,
}
