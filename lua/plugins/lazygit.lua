---@type LazySpec
return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<Leader>gg",
      function()
        local function open()
          vim.cmd "LazyGit"
        end
        -- Si ya hay un tab con lazygit, saltar a él
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match "lazygit" then
            for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
              if vim.api.nvim_tabpage_is_valid(tab) then
                local tab_wins = vim.api.nvim_tabpage_list_wins(tab)
                for _, tw in ipairs(tab_wins) do
                  if tw == win then
                    vim.api.nvim_set_current_tabpage(tab)
                    return
                  end
                end
              end
            end
          end
        end
        -- Abrir en nuevo tab
        vim.cmd "tabnew"
        open()
      end,
      desc = "LazyGit (tab)",
    },
    { "<Leader>gF", "<Cmd>LazyGitFilterCurrentFile<CR>", desc = "Commits de este archivo" },
    {
      "<Leader>gp",
      function()
        vim.notify("Pushing...", vim.log.levels.INFO)
        local output = vim.fn.system "git push 2>&1"
        if vim.v.shell_error ~= 0 then
          vim.notify("Push falló:\n" .. output, vim.log.levels.ERROR)
        else
          vim.notify("Push completado ✓", vim.log.levels.INFO)
        end
      end,
      desc = "Git push",
    },
    {
      "<Leader>gc",
      function()
        local msg = vim.fn.input "Mensaje de commit: "
        if msg ~= "" then
          local output = vim.fn.system({ "git", "commit", "-m", msg })
          if vim.v.shell_error ~= 0 then
            vim.notify("Commit falló:\n" .. output, vim.log.levels.ERROR)
          else
            vim.notify("Commit creado ✓", vim.log.levels.INFO)
          end
        end
      end,
      desc = "Git commit",
    },
  },
  config = function(_, opts)
    require("lazygit").setup(opts)
  end,
}
