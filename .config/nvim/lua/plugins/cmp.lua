local status_ok, cmp = pcall(require, "cmp")
if not status_ok then return end

-- config for copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- load snippets
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local lspkind = require('lspkind')
cmp.setup {
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                buffer = "[BUFFER]",
                nvim_lsp = "[LSP]",
                luasnip = "[SNIPPET]",
                cmp_tabnine = "[TN]",
                copilot = "[COPILOT]",
                path = "[PATH]"
            })
        })
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
        -- ["`"] = cmp.mapping(function(fallback)
        --     cmp.mapping.abort()
        --     local copilot_keys = vim.fn["copilot#Accept"]()
        --     if copilot_keys ~= "" then
        --         vim.api.nvim_feedkeys(copilot_keys, "i", true)
        --     else
        --         fallback()
        --     end
        -- end)
    },
    sources = {
        {name = 'copilot'}, {name = 'nvim_lsp'},
        {name = 'nvim_lsp_signature_help'}, {name = 'spell'}, {name = "path"},
        {name = 'luasnip'}, {name = 'treesitter'}, {name = 'cmp_tabnine'},
        {name = 'buffer'}, {name = 'nvim_lua'}
    },
    documentation = {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
    },
    experimental = {ghost_text = false}

}
