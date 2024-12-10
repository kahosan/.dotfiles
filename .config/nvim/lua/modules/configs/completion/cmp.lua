return function()
  local cmp = require("cmp")

  local border = function(hl)
    return {
      { "┌", hl },
      { "─", hl },
      { "┐", hl },
      { "│", hl },
      { "┘", hl },
      { "─", hl },
      { "└", hl },
      { "│", hl },
    }
  end

  cmp.setup({
    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    window = {
      completion = {
        border = border("PmenuBorder"),
        winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
        scrollbar = false,
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", vim_item.kind or "")

        vim_item.menu = setmetatable({
          copilot = "[CT]",
          buffer = "[BUF]",
          orgmode = "[ORG]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[LUA]",
          path = "[PATH]",
          treesitter = "[TS]",
          spell = "[SPELL]",
        }, {
          __index = function()
            return "[BTN]" -- builtin/unknown source names
          end,
        })[entry.source.name]

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. "..."
        end

        -- deduplicate results from nvim_lsp
        if entry.source.name == "nvim_lsp" then
          vim_item.dup = 0
        end

        return vim_item
      end,
    },
    performance = {
      async_budget = 1,
      max_view_entries = 120,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-w>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      {
        name = "nvim_lsp",
        max_item_count = 120,
        entry_filter = function(entry, _)
          return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
        end,
      },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "treesitter" },
      { name = "spell" },
      { name = "tmux" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_buf_line_count(0) < 7500 and vim.api.nvim_list_bufs() or {}
          end,
        },
      },
    },
  })
end
