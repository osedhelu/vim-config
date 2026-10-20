---@type LazySpec
return {
  -- ==========================================================================
  -- Kotlin — soporte de lenguaje
  --
  -- Requisitos: JDK 17+ instalado (el LSP de Kotlin lo necesita). Mason instala
  -- los binarios: kotlin_language_server (LSP), ktlint (formato/lint) y
  -- kotlin-debug-adapter (depurador).
  --
  -- Pasos de instalación y atajos: README.md > "Kotlin y Spring Boot".
  -- ==========================================================================

  -- 1) Servidor de lenguaje de Kotlin (fwcd/kotlin-language-server).
  --    mason-lspconfig lo instala y AstroNvim lo habilita solo: usa el handler
  --    por defecto de mason-lspconfig para todo servidor instalado (ver el
  --    lspconfig.lua de AstroNvim).
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "kotlin_language_server",
      })
      return opts
    end,
  },

  -- 2) Formateo y linting con ktlint vía none-ls.
  --    Ojo: `.kts` (p. ej. build.gradle.kts) también tiene filetype `kotlin`.
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "ktlint", -- formateador + linter de Kotlin
      })
      return opts
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = require("astrocore").list_insert_unique(opts.sources or {}, {
        null_ls.builtins.formatting.ktlint,
        null_ls.builtins.diagnostics.ktlint,
      })
      return opts
    end,
  },

  -- 3) Depuración de Kotlin con nvim-dap. mason-nvim-dap registra el adaptador
  --    (kotlin-debug-adapter) y la configuración "launch - kotlin", que pide la
  --    clase principal del proyecto, p. ej. com.example.demo.DemoApplicationKt.
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "kotlin", -- -> kotlin-debug-adapter
      })
      return opts
    end,
  },

  -- 4) Atajos de Kotlin.
  --    El `ga` global (formateo LSP, ver lua/plugins/_astrolsp_mappings.lua) usa
  --    astrolsp.format_opts, que excluye a none-ls de forma global
  --    (lua/plugins/astrolsp.lua > formatting.disabled). En Kotlin el único
  --    formateador es ktlint (none-ls), así que aquí se redefine `ga` solo para
  --    buffers Kotlin y se añade <Leader>kf.
  --    El grupo <Leader>k ("Kotlin / Spring Boot") se completa en
  --    lua/plugins/java-spring-boot.lua.
  {
    "AstroNvim/astrocore",
    optional = true,
    opts = function(_, opts)
      local function format_ktlint()
        local has_null_ls = false
        for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
          if client.name == "null-ls" then
            has_null_ls = true
            break
          end
        end
        if not has_null_ls then
          require("astrocore").notify("ktlint no está disponible en este buffer (revisa :Mason)", vim.log.levels.WARN)
          return
        end
        vim.lsp.buf.format { async = true, filter = function(client) return client.name == "null-ls" end }
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("AstroKotlinFormat", { clear = true }),
        pattern = { "kotlin" },
        desc = "Usar ktlint con `ga` en buffers Kotlin",
        callback = function(event)
          vim.keymap.set("n", "ga", format_ktlint, { buffer = event.buf, desc = "Formatear con ktlint" })
        end,
      })

      opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
        n = {
          ["<Leader>k"] = { desc = "Kotlin / Spring Boot" },
          ["<Leader>kf"] = { format_ktlint, desc = "Formatear Kotlin (ktlint)" },
        },
      })
    end,
  },
}
