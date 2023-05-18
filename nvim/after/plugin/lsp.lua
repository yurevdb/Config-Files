local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'rust_analyzer',
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp_action.tab_complete(),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
