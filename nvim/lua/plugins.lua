vim.cmd [[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- For LSPs
On_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require "packer".startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            local builtin = require "telescope.builtin"
            vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<Leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
            vim.keymap.set("n", "<Leader>fi", builtin.lsp_implementations, {})
            vim.keymap.set("n", "<Leader>fd", builtin.lsp_definitions, {})
            vim.keymap.set("n", "<Leader>fr", builtin.lsp_references, {})
            vim.keymap.set("n", "<Leader>fr", builtin.lsp_type_definitions, {})
            vim.keymap.set("n", "<Leader>fD", builtin.diagnostics, {})
        end,
    }

    use "editorconfig/editorconfig-vim"

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        config = function()
            require "lspconfig".texlab.setup { on_attach = On_attach }
            require "lspconfig".zls.setup { on_attach = On_attach }
            require "lspconfig".pyright.setup { on_attach = On_attach }
            require "lspconfig".clangd.setup { on_attach = On_attach }
            require "lspconfig".julials.setup { on_attach = On_attach }
            require "lspconfig".nixd.setup { on_attach = On_attach }
            require "lspconfig".bashls.setup { on_attach = On_attach }
            require 'lspconfig'.lua_ls.setup {
                on_attach = On_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            local _border = "single"

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = _border
                }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = _border
                }
            )

            vim.diagnostic.config {
                float = { border = _border }
            }

            require('lspconfig.ui.windows').default_options = {
                border = _border
            }

            vim.cmd [[
              highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
              highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
              highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
              highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

              sign define DiagnosticSignError text= texthl=DiagnosticSignError
                                                  \ linehl= numhl=DiagnosticLineNrError
              sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn
                                                  \ linehl= numhl=DiagnosticLineNrWarn
              sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo
                                                  \ linehl= numhl=DiagnosticLineNrInfo
              sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint
                                                  \ linehl= numhl=DiagnosticLineNrHint
            ]]
        end,
    }

    use {
        "simrat39/rust-tools.nvim",
        config = function()
            require "rust-tools".setup {
                server = { on_attach = On_attach },
                tools = {
                    inlay_hints = {
                        auto = false,
                    },
                },
            }
        end,
    }
    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                }
            })
        end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "zig" },
                auto_install = true,

                highlight = {
                    enable = true,
                },

                indent = {
                    enable = false,
                },
            }

            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-context'

    use "adimit/prolog.vim"

    use {
        "mattn/emmet-vim",
        config = function()
            vim.g.user_emmet_leader_key = "Ç"
        end,
    }

    use {
        "vimwiki/vimwiki",
        config = function()
            vim.keymap.set("n", "<C-S-Space>", "<Plug>:VimwikiToggleListItem<CR>")
            vim.g.vimwiki_list = { { path = "~/docs/vimwiki" } }
        end,
    }

    use {
        "leafOfTree/vim-svelte-plugin",
        config = function()
            vim.g.vim_svelte_plugin_use_typescript = 1
        end,
    }

    use "tpope/vim-repeat"
    use "JuliaEditorSupport/julia-vim"
    use "tpope/vim-surround"
    use "ThePrimeagen/vim-be-good"
end)
