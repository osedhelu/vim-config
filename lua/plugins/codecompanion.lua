-- CodeCompanion → Ollama remoto (Tailscale)
-- Servidor: http://deoslv.tail1ad40d.ts.net:11434
-- Modelo:  qwen2.5:7b
--
-- Alternativa: export OLLAMA_HOST="http://deoslv.tail1ad40d.ts.net:11434"

local OLLAMA_URL = vim.env.OLLAMA_HOST or "http://deoslv.local:11434"
local OLLAMA_MODEL = vim.env.OLLAMA_MODEL or "qwen2.5:7b"

---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "franco-ruggeri/codecompanion-spinner.nvim", -- spinner "Processing..." en el chat
    },
    opts = {
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = OLLAMA_URL,
              },
              schema = {
                model = {
                  default = OLLAMA_MODEL,
                },
              },
            })
          end,
        },
      },
      -- Spinner visible mientras espera la respuesta de Ollama
      extensions = {
        spinner = {},
      },
      interactions = {
        chat = {
          adapter = { name = "ollama", model = OLLAMA_MODEL },
        },
        inline = {
          adapter = { name = "ollama", model = OLLAMA_MODEL },
        },
        cmd = {
          adapter = { name = "ollama", model = OLLAMA_MODEL },
        },
      },
    },
  },
}
