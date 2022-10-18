local config = {}

function config.nvim_lsp()
  require("modules.completion.lsp")
end

function config.cmp()
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local compare = require("cmp.config.compare")
  local lspkind = require("lspkind")
  local cmp = require("cmp")

  cmp.setup({
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,
        require("copilot_cmp.comparators").score,
        compare.offset,
        compare.exact,
        compare.score,
        require("cmp-under-comparator").under,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        symbol_map = { Copilot = "" },
      }),
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    --   if require("luasnip").jumpable(-1) then
    --     vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<C-l>"] = function(fallback)
    --   if require("luasnip").expand_or_jumpable() then
    --     vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
    --   else
    --     fallback()
    --   end
    -- end,
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
      { name = "copilot" },
      -- {name = 'cmp_tabnine'}
    },
  })
end

function config.luasnip()
  local snippet_path = os.getenv("HOME") .. "/.config/nvim/my-snippets/"
  if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
    vim.opt.rtp:append(snippet_path)
  end

  require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged,InsertLeave",
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
  local handlers = require("nvim-autopairs.completion.handlers")
  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
      filetypes = {
        -- "*" is a alias to all filetypes
        ["*"] = {
          ["("] = {
            kind = {
              cmp.lsp.CompletionItemKind.Function,
              cmp.lsp.CompletionItemKind.Method,
            },
            handler = handlers["*"],
          },
        },
        -- Disable for tex
        tex = false,
      },
    })
  )
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
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        "markdown",
        "md",
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
  null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    end,
  })
end

function config.lspsaga()
  local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
      Error = " ",
      Warn = " ",
      Info = " ",
      Hint = " ",
    }
    for type, icon in pairs(diagnostic_icons) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
  end

  local function get_palette()
    if vim.g.colors_name == "catppuccin" then
      -- If the colorscheme is catppuccin then use the palette.
      return require("catppuccin.palettes").get_palette()
    else
      -- Default behavior: return lspsaga's default palette.
      local palette = require("lspsaga.lspkind").colors
      palette.peach = palette.orange
      palette.flamingo = palette.orange
      palette.rosewater = palette.yellow
      palette.mauve = palette.violet
      palette.sapphire = palette.blue
      palette.maroon = palette.orange

      return palette
    end
  end

  set_sidebar_icons()

  local colors = get_palette()

  require("lspsaga").init_lsp_saga({
    code_action_icon = "",
    code_action_lightbulb = {
      enable = true,
      virtual_text = false,
    },
    diagnostic_header = { " ", " ", "  ", " " },
    custom_kind = {
      File = { " ", colors.rosewater },
      Module = { " ", colors.blue },
      Namespace = { " ", colors.blue },
      Package = { " ", colors.blue },
      Class = { "ﴯ ", colors.yellow },
      Method = { " ", colors.blue },
      Property = { "ﰠ ", colors.teal },
      Field = { " ", colors.teal },
      Constructor = { " ", colors.sapphire },
      Enum = { " ", colors.yellow },
      Interface = { " ", colors.yellow },
      Function = { " ", colors.blue },
      Variable = { " ", colors.peach },
      Constant = { " ", colors.peach },
      String = { " ", colors.green },
      Number = { " ", colors.peach },
      Boolean = { " ", colors.peach },
      Array = { " ", colors.peach },
      Object = { " ", colors.yellow },
      Key = { " ", colors.red },
      Null = { "ﳠ ", colors.yellow },
      EnumMember = { " ", colors.teal },
      Struct = { " ", colors.yellow },
      Event = { " ", colors.yellow },
      Operator = { " ", colors.sky },
      TypeParameter = { " ", colors.maroon },
      -- ccls-specific icons.
      TypeAlias = { " ", colors.green },
      Parameter = { " ", colors.blue },
      StaticMethod = { "ﴂ ", colors.peach },
      Macro = { " ", colors.red },
    },
    symbol_in_winbar = {
      enable = true,
      click_support = function(node, clicks, button, modifiers)
        -- To see all avaiable details: vim.pretty_print(node)
        local st = node.range.start
        local en = node.range["end"]
        if button == "l" then
          if clicks == 2 then
            -- double left click to do nothing
          else -- jump to node's starting line+char
            vim.fn.cursor(st.line + 1, st.character + 1)
          end
        elseif button == "r" then
          if modifiers == "s" then
            print("lspsaga") -- shift right click to print "lspsaga"
          end -- jump to node's ending line+char
          vim.fn.cursor(en.line + 1, en.character + 1)
        elseif button == "m" then
          -- middle click to visual select node
          vim.fn.cursor(st.line + 1, st.character + 1)
          vim.cmd("normal v")
          vim.fn.cursor(en.line + 1, en.character + 1)
        end
      end,
    },
  })
end

return config
