return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        hint_enable = false,
        handler_opts = { border = "rounded" },
      }
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- == Markdown Rendering ==
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "md" },
        heading = {
          sign = false,
          icons = { "󰲡 ", "󰲢 ", "󰲣 ", "󰲤 ", "󰲥 ", "󰲦 " },
        },
        code = {
          sign = true,
          style = "full",
          left_pad = 1,
          right_pad = 1,
          border = "thin",
          above = "▄",
          below = "▀",
        },
        dash = {
          icon = "─",
          width = "full",
          highlight = "LineNr",
        },
        bullet = {
          icons = { "●", "○", "◆", "◇" },
        },
        checkbox = {
          unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "󰄲 ",
            highlight = "RenderMarkdownChecked",
          },
        },
        quote = {
          icon = "▋",
          repeat_linebreak = true,
        },
        link = {
          enabled = true,
          hyperlink = {
            icon = "󰌷 ",
          },
        },
        image = {
          enabled = true,
        },
        table = {
          enabled = true,
        },
        latex = {
          enabled = true,
        },
      })
    end,
  },

  -- == Markdown Preview ==
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown", "md" },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_page_title = "「${name}」"
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_filetypes = { "markdown", "md" }
    end,
  },
}
