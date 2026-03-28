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

    -- Mientras eliges destino: sin diagnósticos en pantalla (menos ruido) y menos "Press ENTER"
    local motion_au = vim.api.nvim_create_augroup("EasyMotionDiagQuiet", { clear = true })
    local saved_showcmd
    vim.api.nvim_create_autocmd("User", {
      group = motion_au,
      pattern = "EasyMotionPromptBegin",
      callback = function()
        saved_showcmd = vim.opt.showcmd:get()
        vim.opt.showcmd = false
        local buf = vim.api.nvim_get_current_buf()
        if vim.diagnostic.enable then
          pcall(vim.diagnostic.enable, false, { bufnr = buf })
        else
          vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = false,
            signs = false,
            underline = false,
          }
        end
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = motion_au,
      pattern = "EasyMotionPromptEnd",
      callback = function()
        if saved_showcmd ~= nil then
          vim.opt.showcmd = saved_showcmd
          saved_showcmd = nil
        end
        local buf = vim.api.nvim_get_current_buf()
        if vim.diagnostic.enable then
          pcall(vim.diagnostic.enable, true, { bufnr = buf })
        else
          require("config.diagnostic_ui").apply_vim_diagnostic()
        end
        vim.cmd [[silent! echo "" | redraw!]]
      end,
    })

    -- Opcional: Desactivar más mensajes directamente
    vim.g.EasyMotion_verbose = 0
  end,
}
