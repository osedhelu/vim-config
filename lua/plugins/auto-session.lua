return {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  ---@type AutoSession.Config
  opts = {
    -- Directorio donde se guardan las sesiones
    auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",

    -- Auto-restaurar sesión al abrir nvim
    auto_restore_enabled = true,

    -- Auto-guardar sesión al salir de nvim
    auto_save_enabled = true,

    -- Nombre de la sesión por defecto (basado en directorio actual)
    use_git_branch_as_session_name = true,

    -- Ignorar estos directorios
    auto_session_allowed_dirs = {
      "~/projects",
      "~/work",
      "~/.config/nvim",
      "~",
    },

    -- No restaurar sesión en estos directorios
    auto_session_suppress_dirs = {
      "~/",
      "~/Downloads",
      "/tmp",
    },

    -- No guardar estos buffers
    bypass_session_save_file_types = {
      "gitcommit",
      "gitrebase",
      "qf",
      "Trouble",
      "help",
    },

    -- Logging (útil para debugging)
    log_level = "error",

    -- Mantener el foco en la ventana actual
    cwd_change_handling = {
      restore_on_change = true,
      pre_cwd_changed_hook = function() end,
      post_cwd_changed_hook = function() end,
    },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)

    -- Integración con Telescope para ver/cambiar sesiones
    local telescope = require "telescope"
    if pcall(telescope.load_extension, "sessions") then
      -- El plugin auto-carga la extensión de Telescope
    end
  end,
}
