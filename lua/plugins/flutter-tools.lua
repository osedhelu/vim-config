return {
    {
        "akinsho/flutter-tools.nvim",
        lazy = true,
        config = function()
            require("flutter-tools").setup({
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
                },
                lsp = {
                    on_attach = function(client, bufnr)
                        -- your custom on_attach logic here
                    end,
                    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                    settings = {
                        showTodos = true,
                        completeFunctionCalls = true,
                        analysisExcludedFolders = {vim.fn.expand '$HOME/development/flutter/packages'}
                    }
                }
            })
        end,
    },
    -- add lsp plugin
    {
        "AstroNvim/astrolsp",
        ---@param opts AstroLSPOpts
        opts = function(plugin, opts)
            opts.servers = opts.servers or {}
            table.insert(opts.servers, "dartls")

            opts = require("astrocore").extend_tbl(opts, {
                setup_handlers = {
                    -- add custom handler
                    dartls = function(_, dartls_opts)
                        require("flutter-tools").setup({
                            lsp = dartls_opts,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                            settings = {
                                showTodos = true,
                                completeFunctionCalls = true,
                                analysisExcludedFolders = {vim.fn.expand '$HOME/development/flutter/packages'}
                            }
                        })
                    end
                },
                config = {
                    dartls = {
                        -- any changes you want to make to the LSP setup, for example
                        color = {
                            enabled = true
                        },
                        settings = {
                            showTodos = true,
                            completeFunctionCalls = true
                        },
                    }
                }
            })
        end
    }
}

