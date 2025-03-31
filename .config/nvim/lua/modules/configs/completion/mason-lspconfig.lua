local M = {}

M.setup = function()
  local diagnostics_virtual_text = require("core.settings").diagnostics_virtual_text
  local diagnostics_level = require("core.settings").diagnostics_level

  local nvim_lsp = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  require("mason-lspconfig").setup({
    ensure_installed = require("core.settings").lsp_deps,
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = diagnostics_virtual_text and {
      severity = {
        min = vim.diagnostic.severity[diagnostics_level],
      },
    } or false,
    -- set update_in_insert to false because it was enabled by lspsaga
    update_in_insert = false,
  })

  local opts = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  }

  ---A handler to setup all servers defined under `completion/servers/*.lua`
  ---@param lsp_name string
  local function mason_lsp_handler(lsp_name)
    local ok, handler = pcall(require, "completion.servers." .. lsp_name)
    if not ok then
      -- Default to use factory config for server(s) that doesn't include a spec
      nvim_lsp[lsp_name].setup(opts)
      return
    elseif type(handler) == "function" then
      --- Case where language server requires its own setup
      --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
      --- See `clangd.lua` for example.
      handler(opts)
    elseif type(handler) == "table" then
      nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, handler))
    else
      vim.notify(
        string.format(
          "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(handler)
        ),
        vim.log.levels.ERROR,
        { title = "nvim-lspconfig" }
      )
    end
  end

  mason_lspconfig.setup_handlers({ mason_lsp_handler })

  -- lsp keymap and inlay hints
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
    callback = function(event)
      -- inlay hints
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.inlayHintProvider ~= nil then
        vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
      end

      -- keymaps
      vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      local hover = function()
        vim.lsp.buf.hover({ border = CUSTOM_BORDER })
      end

      local lsp_opts = { buffer = event.buf }
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, lsp_opts)
      vim.keymap.set("n", "K", hover, lsp_opts)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, lsp_opts)
      -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, lsp_opts)
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, lsp_opts)
    end,
  })
end

return M
