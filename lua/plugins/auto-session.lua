return {
  "rmagatti/auto-session",
  lazy = false,
  priority = 1000, -- Cargar con alta prioridad para asegurar restauración temprana
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  ---@type AutoSession.Config
  opts = {
    -- Directorio donde se guardan las sesiones
    auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",

    -- Auto-restaurar sesión al abrir nvim (crítico para OpenCode)
    auto_restore_enabled = true,

    -- Auto-guardar sesión al salir de nvim
    auto_save_enabled = true,

    -- Silenciar notificaciones de restauración
    suppress_session_restore_message = false,

    -- Usar la rama de Git como nombre de sesión (más predecible)
    use_git_branch_as_session_name = true,

    -- Permitir restauración en subdirectorios
    auto_session_allowed_dirs = {
      "~/projects",
      "~/work",
      "~/.config/nvim",
      "~",
    },

    -- NO restaurar sesión en estos directorios (evita conflictos)
    auto_session_suppress_dirs = {
      "~/",
      "~/Downloads",
      "/tmp",
      "/var/tmp",
    },

    -- No guardar estos buffers en la sesión
    bypass_session_save_file_types = {
      "gitcommit",
      "gitrebase",
      "qf",
      "Trouble",
      "help",
      "terminal",
      "floaterm",
    },

    -- Logging para debugging (cambiar a "debug" si hay problemas)
    log_level = "error",

    -- Restaurar sesión cuando cambies de directorio en nvim
    cwd_change_handling = {
      restore_on_change = true,
      pre_cwd_changed_hook = function() end,
      post_cwd_changed_hook = function() end,
    },

    -- Función personalizada para determinar el nombre de sesión
    session_lens = {
      -- Mostrar sesiones en Telescope cuando se usa <Leader>Sf
      previewer = false,
    },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)

    -- Integración con Telescope para ver/cambiar sesiones
    if pcall(require, "telescope") then
      require("telescope").load_extension "sessions"
    end

    -- Debug: Mostrar información sobre la sesión al iniciar
    vim.schedule(function()
      local session_lib = require "auto-session.session-lens.session"
      local cwd = vim.fn.getcwd()
      local session_name = session_lib.format_session_name(cwd)
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          if vim.fn.argc() == 0 then
            -- Mostrar sesión restaurada (solo en VimEnter)
            vim.notify(
              "Auto-session: Working dir: " .. cwd .. " | Session: " .. session_name,
              vim.log.levels.DEBUG
            )
          end
        end,
      })
    end)
  end,
}
