vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd vim-illuminate]])

local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

mason.setup()
mason_lsp.setup({
  ensure_installed = {
    "bash-language-server",
    "lua-language-server",
    "rust_analyzer",
    "gopls",
    "typescript-language-server",
    "html-lsp",
    "pyright",
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function custom_attach(client)
  require("lsp_signature").on_attach({
    bind = true,
    use_lspsaga = false,
    floating_window = true,
    fix_pos = false,
    hint_enable = true,
    hi_parameter = "Search",
    hint_prefix = "",
    max_width = 40,
    handler_opts = { "double" },
  })
  require("illuminate").on_attach(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = nvim_lsp.util.validate_bufnr(bufnr)
  local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("Corresponding file can’t be determined")
        return
      end
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end)
  else
    print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
  end
end

-- Override server settings here

for _, server in ipairs(mason_lsp.get_installed_servers()) do
  if server == "gopls" then
    nvim_lsp.gopls.setup({
      on_attach = custom_attach,
      flags = { debounce_text_changes = 500 },
      capabilities = capabilities,
      cmd = { "gopls", "-remote=auto" },
      settings = {
        gopls = {
          usePlaceholders = false,
          analyses = {
            nilness = true,
            shadow = true,
            unusedparams = true,
            unusewrites = true,
          },
        },
      },
    })
  elseif server == "sumneko_lua" then
    nvim_lsp.sumneko_lua.setup({
      capabilities = capabilities,
      on_attach = custom_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim", "packer_plugins" } },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = { enable = false },
        },
      },
    })
  elseif server == "clangd" then
    local copy_capabilities = capabilities
    copy_capabilities.offsetEncoding = { "utf-16" }
    nvim_lsp.clangd.setup({
      capabilities = copy_capabilities,
      single_file_support = true,
      on_attach = custom_attach,
      args = {
        "--background-index",
        "-std=c++20",
        "--pch-storage=memory",
        "--clang-tidy",
        "--suggest-missing-includes",
      },
      commands = {
        ClangdSwitchSourceHeader = {
          function()
            switch_source_header_splitcmd(0, "edit")
          end,
          description = "Open source/header in current buffer",
        },
        ClangdSwitchSourceHeaderVSplit = {
          function()
            switch_source_header_splitcmd(0, "vsplit")
          end,
          description = "Open source/header in a new vsplit",
        },
        ClangdSwitchSourceHeaderSplit = {
          function()
            switch_source_header_splitcmd(0, "split")
          end,
          description = "Open source/header in a new split",
        },
      },
    })
  elseif server == "tsserver" then
    local function organize_imports()
      local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = "",
      }
      vim.lsp.buf.execute_command(params)
    end
    nvim_lsp.tsserver.setup({
      on_attach = custom_attach,
      capabilities = capabilities,
      commands = {
        OrganizeImports = {
          organize_imports,
          description = "Organize Imports",
        },
      },
    })
  elseif server == "jsonls" then
    nvim_lsp.jsonls.setup({
      flags = { debounce_text_changes = 500 },
      capabilities = capabilities,
      on_attach = custom_attach,
      settings = {
        json = {
          -- Schemas https://www.schemastore.org
          schemas = {
            {
              fileMatch = { "package.json" },
              url = "https://json.schemastore.org/package.json",
            },
            {
              fileMatch = { "tsconfig*.json" },
              url = "https://json.schemastore.org/tsconfig.json",
            },
            {
              fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
                "prettier.config.json",
              },
              url = "https://json.schemastore.org/prettierrc.json",
            },
            {
              fileMatch = { ".eslintrc", ".eslintrc.json" },
              url = "https://json.schemastore.org/eslintrc.json",
            },
            {
              fileMatch = {
                ".babelrc",
                ".babelrc.json",
                "babel.config.json",
              },
              url = "https://json.schemastore.org/babelrc.json",
            },
            {
              fileMatch = { "lerna.json" },
              url = "https://json.schemastore.org/lerna.json",
            },
            {
              fileMatch = {
                ".stylelintrc",
                ".stylelintrc.json",
                "stylelint.config.json",
              },
              url = "http://json.schemastore.org/stylelintrc.json",
            },
            {
              fileMatch = { "/.github/workflows/*" },
              url = "https://json.schemastore.org/github-workflow.json",
            },
          },
        },
      },
    })
  else
    nvim_lsp[server].setup({
      capabilities = capabilities,
      on_attach = custom_attach,
    })
  end
end

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin

nvim_lsp.html.setup({
  filetypes = { "html" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = { css = true, javascript = true },
  },
  settings = {},
  single_file_support = true,
  flags = { debounce_text_changes = 500 },
  capabilities = capabilities,
  on_attach = custom_attach,
})

-- eslint

nvim_lsp.eslint.setup({})
