return function()
  local is_windows = require("core.global").is_windows

  local settgins = require("core.settings")

  local nvim_lsp = require("lspconfig")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_registry = require("mason-registry")

  require("lspconfig.ui.windows").default_options.border = "single"

  local icons = {
    ui = require("modules.utils.icons").get("ui", true),
    misc = require("modules.utils.icons").get("misc", true),
  }

  mason.setup({
    ui = {
      border = "single",
      icons = {
        package_pending = icons.ui.Modified_alt,
        package_installed = icons.ui.Check,
        package_uninstalled = icons.misc.Ghost,
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
        cancel_installation = "<C-c>",
      },
    },
  })

  mason_lspconfig.setup({
    ensure_installed = settgins.lsp_deps,
  })

  local diagnostics_virtual_text = settgins.diagnostics_virtual_text
  local diagnostics_level = settgins.diagnostics_level

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = diagnostics_virtual_text and {
      severity = {
        min = vim.diagnostic.severity[diagnostics_level],
      },
    } or false,
    -- set update_in_insert to false bacause it was enabled by lspsaga
    update_in_insert = false,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  local opts = {
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    ),
  }

  ---A handler to setup all servers defined under `completion/servers/*.lua`
  ---@param lsp_name string
  local function mason_lsp_handler(lsp_name)
    local ok, custom_handler = pcall(require, "completion.servers." .. lsp_name)
    if not ok then
      -- Default to use factory config for server(s) that doesn't include a spec
      nvim_lsp[lsp_name].setup(opts)
      return
    elseif type(custom_handler) == "function" then
      --- Case where language server requires its own setup
      --- Make sure to call require("lspconfig")[lsp_name].setup() in the function
      --- See `clangd.lua` for example.
      custom_handler(opts)
    elseif type(custom_handler) == "table" then
      nvim_lsp[lsp_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
    else
      vim.notify(
        string.format(
          "Failed to setup [%s].\n\nServer definition under `completion/servers` must return\neither a fun(opts) or a table (got '%s' instead)",
          lsp_name,
          type(custom_handler)
        ),
        vim.log.levels.ERROR,
        { title = "nvim-lspconfig" }
      )
    end
  end

  mason_lspconfig.setup_handlers({ mason_lsp_handler })

  -- Setup lsps that are not supported by `mason.nvim` but supported by `nvim-lspconfig` here.
  if vim.fn.executable("dart") == 1 then
    local _opts = require("completion.servers.dartls")
    local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
    nvim_lsp.dartls.setup(final_opts)
  end

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

      local lsp_opts = { buffer = event.buf }
      -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, lsp_opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.rename, lsp_opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_opts)
      vim.keymap.set("n", "ga", vim.lsp.buf.code_action, lsp_opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, lsp_opts)
      vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, lsp_opts)
    end,
  })
end
