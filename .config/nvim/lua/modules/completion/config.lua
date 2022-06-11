local config = {}

function config.nvim_lsp()
  require("modules.completion.lsp")
end

function config.cmp()
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local cmp = require("cmp")
  cmp.setup({
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      format = function(entry, vim_item)
        local lspkind_icons = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        }
        -- load lspkind icons
        vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

        vim_item.menu = ({
          -- cmp_tabnine = "[TN]",
          buffer = "[BUF]",
          orgmode = "[ORG]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[LUA]",
          path = "[PATH]",
          tmux = "[TMUX]",
          luasnip = "[SNIP]",
          spell = "[SPELL]",
        })[entry.source.name]

        return vim_item
      end,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-h>"] = function(fallback)
        if require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end,
      ["<C-l>"] = function(fallback)
        if require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        else
          fallback()
        end
      end,
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "spell" },
      { name = "tmux" },
      { name = "orgmode" },
      { name = "buffer" },
      { name = "latex_symbols" },
      -- {name = 'cmp_tabnine'}
    },
  })
end

function config.luasnip()
  vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
  require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
  })
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
end

function config.autopairs()
  require("nvim-autopairs").setup({})

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local cmp = require("cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
end

function config.null_ls()
  local null_ls = require("null-ls")
  local sources = {
    null_ls.builtins.formatting.prettier.with({
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
          "~/.config/nvim/lua/modules/completion/linter-config/.prettierrc.json"
        ),
      },
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
        "md",
        "txt",
      },
    }),
    null_ls.builtins.formatting.stylua.with({
      filetypes = {
        "lua",
      },
      args = { "--indent-width", "2", "--indent-type", "Spaces", "-" },
    }),
  }

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  require("null-ls").setup({
    sources = sources,
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.formatting_seq_sync()
          end,
        })
      end
    end,
  })
end

return config
