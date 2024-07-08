-- #region
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣'
}
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous [D]iagnostic message'
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next [D]iagnostic message'
})
vim.keymap.set('n', '<leader>bb', vim.diagnostic.open_float, {
    desc = 'Show diagnostic [E]rror messages'
})
vim.keymap.set('n', '<leader>w', ':w<CR>', {
    desc = 'Guardar Cambios'
})

-- vim.api.nvim_command(':bdelete ' .. vim.fn.expand('%'))
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode'
})

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
    desc = 'Move focus to the left window'
})
vim.keymap.set('n', '<S-L>', ':BufferLineCycleNext<CR>', {
    noremap = true,
    silent = true
})
vim.keymap.set('n', '<S-H>', ':BufferLineCyclePrev<CR>', {
    noremap = true,
    silent = true
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
    desc = 'Move focus to the right window'
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
    desc = 'Move focus to the lower window'
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
    desc = 'Move focus to the upper window'
})
-- Asignar <leader> fr para easymotion buscar
vim.keymap.set('n', '<leader>fr', '<Plug>(easymotion-s2)', {
    desc = 'EasyMotion search'
})
-- #endregion

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true
    }),
    callback = function()
        vim.highlight.on_yank()
    end
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system {'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath}
end
-- @diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({{'nvim-tree/nvim-web-devicons'}, {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
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
                indicator_icon = '󱓦',
                buffer_close_icon = 'x',
                modified_icon = '󱊐',
                close_icon = '󱊑',
                left_trunc_marker = '󱊩',
                right_trunc_marker = '󱊨',
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
                offsets = {{
                    filetype = 'neo-tree',
                    text = 'Directorio �',
                    highlight = 'Directory',
                    text_align = 'left'
                }},
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
                        default = false
                    })
                    return icon, hl
                end
            }
        }
    end
}, {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim'},
    config = function()
        require('neo-tree').setup {
            window = {
                mappings = {
                    ['o'] = 'open'
                }

            },
            close_if_last_window = true,
            popup_border_style = 'rounded',
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        added = '✚',
                        modified = '',
                        deleted = '✖',
                        renamed = '',
                        untracked = '',
                        ignored = '',
                        unstaged = '󰐒',
                        staged = '',
                        conflict = ''
                    }
                }
            }
        }
        vim.api.nvim_set_keymap('n', '<Leader>e', ':Neotree reveal<CR>', {
            noremap = true,
            silent = true
        })
    end
}, {
    'numToStr/Comment.nvim',
    opts = {}
}, {
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add = {
                text = '+'
            },
            change = {
                text = '~'
            },
            delete = {
                text = '_'
            },
            topdelete = {
                text = '‾'
            },
            changedelete = {
                text = '~'
            }
        }
    }
}, {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    opts = {
        document_color = {
            enabled = true, -- can be toggled by commands
            kind = 'inline', -- "inline" | "foreground" | "background"
            inline_symbol = '', -- only used in inline mode
            debounce = 200 -- in milliseconds, only applied in insert mode
        },
        conceal = {
            enabled = false, -- can be toggled by commands
            min_length = nil, -- only conceal classes exceeding the provided length
            symbol = '', -- only a single character is allowed
            highlight = { -- extmark highlight options, see :h 'highlight'
                fg = '#38BDF8'
            }
        },
        custom_filetypes = {} -- see the extension section to learn how it works
    } -- your configuration
}, {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        require('which-key').setup()
        require('which-key').register {
            ['<leader>c'] = {
                name = '[C]ode',
                _ = 'which_key_ignore'
            },
            ['<leader>d'] = {
                name = '[D]ocument',
                _ = 'which_key_ignore'
            },
            ['<leader>r'] = {
                name = '[R]ename',
                _ = 'which_key_ignore'
            },
            ['<leader>s'] = {
                name = '[S]earch',
                _ = 'which_key_ignore'
            },
            ['<leader>p'] = {
                name = 'Workspace',
                _ = 'which_key_ignore'
            },
            ['<leader>t'] = {
                name = '[T]oggle',
                _ = 'which_key_ignore'
            },
            ['<leader>h'] = {
                name = 'Git [H]unk',
                _ = 'which_key_ignore'
            }
        }
        require('which-key').register({
            ['<leader>h'] = {'Git [H]unk'}
        }, {
            mode = 'v'
        })
    end
}, {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim', {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }, {'nvim-telescope/telescope-ui-select.nvim'}},
    config = function()
        require('telescope').setup {
            extensions = {
                ['ui-select'] = {require('telescope.themes').get_dropdown()}
            }
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
            desc = '[S]earch [H]elp'
        })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
            desc = '[S]earch [K]eymaps'
        })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, {
            desc = '[S]earch [F]iles'
        })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, {
            desc = '[S]earch [S]elect Telescope'
        })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
            desc = '[S]earch current [W]ord'
        })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
            desc = '[S]earch by [G]rep'
        })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
            desc = '[S]earch [D]iagnostics'
        })
        vim.keymap.set('n', '<leader>sr', builtin.resume, {
            desc = '[S]earch [R]esume'
        })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, {
            desc = '[S]earch Recent Files ("." for repeat)'
        })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, {
            desc = '[ ] Find existing buffers'
        })
        vim.keymap.set('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', {
            desc = 'Comentar/Descomentar'
        })
        vim.keymap.set('x', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', {
            desc = 'Comentar/Descomentar'
        })
        -- vim.keymap.set('n', '<leader>/', function()
        --  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        --    winblend = 10,
        --    previewer = false,
        --  })
        -- end, { desc = '[/] Fuzzily search in current buffer' })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files'
            }
        end, {
            desc = '[S]earch [/] in Open Files'
        })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files {
                cwd = vim.fn.stdpath 'config'
            }
        end, {
            desc = '[S]earch [N]eovim files'
        })
    end
}, { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {{
        'williamboman/mason.nvim',
        config = true
    }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim', {
        'j-hui/fidget.nvim',
        opts = {}
    }, {
        'folke/neodev.nvim',
        opts = {}
    }},
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {
                clear = true
            }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, {
                        buffer = event.buf,
                        desc = 'LSP: ' .. desc
                    })
                end

                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                map('<leader>ps', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'p Workspace [S]ymbols')

                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

                map('K', vim.lsp.buf.hover, 'Hover Documentation')

                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', {
                        clear = false
                    })
                    vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight
                    })

                    vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', {
                            clear = true
                        }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds {
                                group = 'kickstart-lsp-highlight',
                                buffer = event2.buf
                            }
                        end
                    })
                end

                if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, '[T]oggle Inlay [H]ints')
                end
            end
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            tsserver = {},
            astro = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace'
                        }
                    }
                }
            }
        }

        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {'stylua', 'prettier', 'eslint'})
        require('mason-tool-installer').setup {
            ensure_installed = ensure_installed
        }

        require('mason-lspconfig').setup {
            handlers = {function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end}
        }
    end
}, {'mfussenegger/nvim-dap' -- A�adir nvim-dap
}, {
    'akinsho/flutter-tools.nvim',
    dependencies = {'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim', 'mfussenegger/nvim-dap' -- A�adir la dependencia
    },
    config = function()
        require('flutter-tools').setup {
            lsp = {
                on_attach = function(client, bufnr)
                    require('lsp-format').on_attach(client)
                end,
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                settings = {
                    showTodos = true,
                    completeFunctionCalls = true,
                    analysisExcludedFolders = {vim.fn.expand '$HOME/development/flutter/packages'}
                }
            },
            debugger = { -- integrate with nvim-dap
                enabled = true,
                run_via_dap = true,
                exception_breakpoints = {},
                register_configurations = function(_)
                    require('dap').configurations.dart = {}
                    require('dap.ext.vscode').load_launchjs()
                end
            },
            dev_log = {
                open_cmd = 'tabedit'
            },
            outline = {
                open_cmd = '30vnew',
                auto_open = false
            },
            widget_guides = {
                enabled = true
            },
            closing_tags = {
                highlight = 'ErrorMsg',
                prefix = '//',
                enabled = true
            }
        }
    end
}, { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {{
        'ga',
        function()
            require('conform').format {
                async = true,
                lsp_fallback = true
            }
        end,
        mode = '',
        desc = '[F]ormat buffer'
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
            }
        end,
        formatters_by_ft = {
            lua = {'stylua'},
            javascript = {'prettier'},
            javascriptreact = {'prettier'},
            css = {'prettier'},
            html = {'prettier'},
            astro = {'prettier'},
            typescript = {'prettier'},
            typescriptreact = {'prettier'},
            sh = {'shfmt'},
            solidity = {'solhint'},
            yaml = {'prettier'},
            json = {'prettier'}
        }
    }
}, {
    'L3MON4D3/LuaSnip',
    keys = function()
        return {}
    end
}, {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {{
        'L3MON4D3/LuaSnip',
        build = (function()
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),
        dependencies = {}
    }, 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-path'},
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-y>'] = cmp.mapping.confirm {
                    select = true
                },
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    select = true
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'}),

                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, {'i', 's'}),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, {'i', 's'})
            },
            sources = {{
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }, {
                name = 'path'
            }}
        }
    end
}, {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        vim.cmd.colorscheme 'tokyonight-night'
        vim.cmd.hi 'Comment gui=none'
    end
}, -- Highlight todo, notes, etc in comments
{
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {
        signs = false
    }
}, { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup {
            n_lines = 500
        }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        local statusline = require 'mini.statusline'
        statusline.setup {
            use_icons = vim.g.have_nerd_font
        }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return '%2l:%-2v'
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end
}, {
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup {
            check_ts = true, -- Enable treesitter integration
            ts_config = {
                lua = {'string', 'source'},
                javascript = {'string', 'template_string'},
                java = false,
                solidity = {'string', 'comment'}
            }
        }
    end
}, {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = {'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'json', 'vimdoc', 'kotlin',
                            'tsx', 'python', 'javascript', 'solidity', 'typescript', 'dart' -- Agregar Dart aqu�
        },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = {'ruby'}
        },
        indent = {
            enable = true,
            disable = {'ruby'}
        }
    },
    config = function(_, opts)
        require('nvim-treesitter.install').prefer_git = true
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)
    end
}, {'famiu/bufdelete.nvim' -- Configuración adicional si es necesario...
}, {
    'xiyaowong/nvim-transparent',
    config = function()
        require('transparent').setup {
            extra_groups = {'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement',
                            'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function', 'Conditional', 'Repeat',
                            'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer'},
            exclude_groups = {}
        }
    end,
    transparency = 50 -- Esto establece la transparencia al 50%. Puedes ajustar este valor según tu preferencia.
}, {
    import = 'custom.plugins'
}, {
    'easymotion/vim-easymotion',
    config = function()
        -- Aqu� puedes a�adir configuraciones adicionales para easymotion si lo deseas
    end
}}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 '
        }
    }
})
-- Añadir comando para cerrar pestañas o buffers usando bufdelete.nvim
vim.keymap.set('n', '<leader>q', function()
    local bufs = vim.fn.getbufinfo({
        buflisted = true
    })
    if #bufs > 1 then
        vim.cmd('Bdelete')
    else
        vim.cmd('enew') -- Crea un nuevo buffer vacío
        vim.cmd('Bdelete') -- Cierra el buffer actual usando bufdelete.nvim
    end
end, {
    desc = '[Q]uitar buffer'
}) -- vim.keymap.set('n', '<leader>q', ':bd   <CR>', { desc = 'cerrar buffer' })
-- vim: ts=2 sts=2 sw=2 et
