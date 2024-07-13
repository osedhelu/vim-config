return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        indicator_icon = '⭕️',
        buffer_close_icon = 'x',
        modified_icon = '💠',
        close_icon = '💢',
        left_trunc_marker = '🔙',
        right_trunc_marker = '🔜',
        name_formatter = function(buf)
          if buf.name:match '%.md' then
            return vim.fn.fnamemodify(buf.name, ':t:r')
          end
        end,
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return '(' .. count .. ')'
        end,
        custom_filter = function(buf_number, buf_numbers)
          if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
            return true
          end
          if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
            return true
          end
          if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
            return true
          end
          if buf_numbers[1] ~= buf_number then
            return true
          end
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Directorio 🔸',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'slant',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'insert_after_current',
        get_element_icon = function(buf)
          local icon, hl = require('nvim-web-devicons').get_icon(buf.name, buf.extension, {
            default = false,
          })
          return icon, hl
        end,
      },
    }
  end,
}