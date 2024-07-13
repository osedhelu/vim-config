-- #region
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Go to previous [D]iagnostic message',
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Go to next [D]iagnostic message',
})
vim.keymap.set('n', '<leader>bb', vim.diagnostic.open_float, {
  desc = 'Show diagnostic [E]rror messages',
})
vim.keymap.set('n', '<leader>w', ':w<CR>', {
  desc = 'Guardar Cambios',
})

-- vim.api.nvim_command(':bdelete ' .. vim.fn.expand('%'))
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<S-L>', ':BufferLineCycleNext<CR>', {
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<S-H>', ':BufferLineCyclePrev<CR>', {
  noremap = true,
  silent = true,
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})
-- Asignar <leader> fr para easymotion buscar
vim.keymap.set('n', '<leader>fr', '<Plug>(easymotion-s2)', {
  desc = 'EasyMotion search',
})
-- #endregion

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
-- @diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'nvim-tree/nvim-web-devicons' },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    'mfussenegger/nvim-dap', -- A�ج���adir nvim-dap
  },
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
  },
  require 'custom.plugins.lukas-reineke',
  require 'custom.plugins.bufferline',
  require 'custom.plugins.nvim-neo-tree',
  require 'custom.plugins.lewis6991',
  require 'custom.plugins.tailwind-tools',
  require 'custom.plugins.which-key',
  require 'custom.plugins.telescope',
  require 'custom.plugins.lspconfig',
  require 'custom.plugins.conform',
  require 'custom.plugins.nvim-cmp',
  require 'custom.plugins.nvim-treesitter',
  require 'custom.plugins.mini',
  require 'custom.plugins.nvim-autopairs',
  require 'custom.plugins.todo-comments',
  require 'custom.plugins.tokyonight',
  require 'custom.plugins.vim-easymotion',
  {
    'famiu/bufdelete.nvim', -- Configuración adicional si es necesario...
  },
  {
    import = 'custom.plugins',
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
-- Añadir comando para cerrar pestañas o buffers usando bufdelete.nvim
vim.keymap.set('n', '<leader>q', function()
  local bufs = vim.fn.getbufinfo {
    buflisted = true,
  }
  if #bufs > 1 then
    vim.cmd 'Bdelete'
  else
    vim.cmd 'enew' -- Crea un nuevo buffer vacío
    vim.cmd 'Bdelete' -- Cierra el buffer actual usando bufdelete.nvim
  end
end, {
  desc = '[Q]uitar buffer',
})
function ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match '^user_config' then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath 'config' .. '/init.lua')
end

-- Asigna la funci�n al mapeo <leader>tp
vim.keymap.set('n', '<leader>tp', ReloadConfig, {
  desc = '[T]oggle [P]roject (Recargar Configuraci�n)',
})
