return {
  'xiyaowong/nvim-transparent',
  config = function()
    require('transparent').setup {
      extra_groups = {
        'Normal',
        'NormalNC',
        'Comment',
        'Constant',
        'Special',
        'Identifier',
        'Statement',
        'PreProc',
        'Type',
        'Underlined',
        'Todo',
        'String',
        'Function',
        'Conditional',
        'Repeat',
        'Operator',
        'Structure',
        'LineNr',
        'NonText',
        'SignColumn',
        'CursorLineNr',
        'EndOfBuffer',
      },
      exclude_groups = {},
    }
  end,
  transparency = 50, -- Esto establece la transparencia al 50%. Puedes ajustar este valor seg√É¬∫n tu preferencia.
}
