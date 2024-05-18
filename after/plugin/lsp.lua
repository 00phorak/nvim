local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    lsp.buffer_autoformat()

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, remap = false, desc = "LSP Go Definition" })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = bufnr, remap = false, desc = "LSP Hover" })
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
        { buffer = bufnr, remap = false, desc = "LSP Workspace Symbol" })
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end,
        { buffer = bufnr, remap = false, desc = "LSP Open Flaot" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end,
        { buffer = bufnr, remap = false, desc = "LSP Go to next" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end,
        { buffer = bufnr, remap = false, desc = "LSP Go to prev" })
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, remap = false, desc = "LSP Code Action" })
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
        { buffer = bufnr, remap = false, desc = "LSP References" })
    vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end,
        { buffer = bufnr, remap = false, desc = "LSP Rename" })
    vim.keymap.set("i", "<C-q>", function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, remap = false, desc = "LSP Signature Help" })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
})
