return {
  "easymotion/vim-easymotion",
  config = function()
    -- Configuración de EasyMotion
    vim.g.EasyMotion_do_mapping = 0 -- Desactiva los mapeos predeterminados

    -- Define tus propios mapeos para EasyMotion con silent para suprimir mensajes
    vim.api.nvim_set_keymap("n", "mm", "<Plug>(easymotion-s2)", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>vw", "<Plug>(easymotion-w)", { noremap = true, silent = true })

    -- Desactivar notificaciones de salto
    vim.g.EasyMotion_smartcase = 1
    vim.g.EasyMotion_use_smartsign_us = 1

    -- Configura EasyMotion para que no muestre mensajes en la línea de comandos
    vim.cmd [[
        augroup EasyMotion
          autocmd!
          autocmd User EasyMotionPromptEnd silent! echo ""
          autocmd User EasyMotionPromptEnd silent! redraw!
        augroup END
      ]]

    -- Opcional: Desactivar más mensajes directamente
    vim.g.EasyMotion_verbose = 0
  end,
}
