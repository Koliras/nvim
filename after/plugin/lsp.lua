local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "<leader>vws", '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
  vim.keymap.set("n", "<leader>vca", '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', "<C-/>", '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', "<leader>vrn", '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  vim.keymap.set('n', "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
end)

lsp_zero.setup()

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip'},
    {name = 'buffer'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

require('nvim-ts-autotag').setup()

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)
