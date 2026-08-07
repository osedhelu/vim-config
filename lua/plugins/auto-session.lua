return {
  "rmagatti/auto-session",
  lazy = false,
  priority = 1000, -- Cargar con alta prioridad para asegurar restauración temprana
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
  },
  config = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
