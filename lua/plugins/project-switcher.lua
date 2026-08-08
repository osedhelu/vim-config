---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<Leader>pp",
      function()
        if not require("astrocore").is_available "telescope.nvim" then
          require("astrocore").notify "telescope.nvim no disponible"
          return
        end

        local pickers = require "telescope.pickers"
        local finders = require "telescope.finders"
        local conf = require("telescope.config").values
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        local search_dirs = {
          vim.fn.expand "~/Desktop",
          vim.fn.expand "~/Documents",
          vim.fn.expand "~/StudioProjects",
        }

        local projects = {}
        local seen = {}

        local cwd = vim.fn.getcwd()
        seen[vim.fn.fnamemodify(cwd, ":t")] = true
        table.insert(projects, { path = cwd, name = "(actual) " .. vim.fn.fnamemodify(cwd, ":t") })

        for _, dir in ipairs(search_dirs) do
          if vim.fn.isdirectory(dir) == 1 then
            local handle = vim.fn.globpath(dir, "*/.git", false, true)
            for _, git_dir in ipairs(handle) do
              local project_dir = vim.fn.fnamemodify(git_dir, ":h")
              local name = vim.fn.fnamemodify(project_dir, ":t")
              if not seen[name] then
                seen[name] = true
                table.insert(projects, { path = project_dir, name = name })
              end
            end
          end
        end

        if #projects <= 1 then
          vim.notify("No se encontraron otros proyectos", vim.log.levels.INFO)
          return
        end

        pickers
          .new({}, {
            prompt_title = "Proyectos",
            finder = finders.new_table {
              results = projects,
              entry_maker = function(entry)
                return {
                  value = entry.path,
                  display = entry.name .. "  →  " .. entry.path,
                  ordinal = entry.name,
                }
              end,
            },
            sorter = conf.generic_sorter {},
            layout_config = { width = 0.8, height = 0.6 },
            attach_mappings = function(prompt_bufnr, map)
              map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                  vim.cmd("cd " .. selection.value)
                  vim.notify("Proyecto: " .. selection.value, vim.log.levels.INFO)
                end
              end)
              map("n", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                  vim.cmd("cd " .. selection.value)
                  vim.notify("Proyecto: " .. selection.value, vim.log.levels.INFO)
                end
              end)
              return true
            end,
          })
          :find()
      end,
      desc = "Cambiar de proyecto",
    },
  },
}
