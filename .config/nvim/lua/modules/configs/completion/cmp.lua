return function()
  local icons = {
    kind = require("modules.utils.icons").get("kind"),
    type = require("modules.utils.icons").get("type"),
    cmp = require("modules.utils.icons").get("cmp"),
  }
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local cmp = require("cmp")
  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        -- cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(_, vim_item)
        local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
        -- load lspkind icons
        vim_item.kind =
          string.format(" %s  %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. "..."
        end

        return vim_item
      end,
    },
    matching = {
      disallow_partial_fuzzy_matching = true,
    },
    performance = {
      async_budget = 1,
      max_view_entries = 120,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-w>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require("luasnip").expand_or_locally_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"))
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
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = "nvim_lsp", max_item_count = 350 },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      {
        name = "treesitter",
        entry_filter = function(entry)
          local ignore_list = {
            "Error",
            "Comment",
          }
          local kind = entry:get_completion_item().cmp.kind_text
          return not vim.tbl_contains(ignore_list, kind)
        end,
      },
      -- { name = "spell" },
      { name = "tmux" },
      -- { name = "orgmode" },
      { name = "buffer" },
      -- { name = "latex_symbols" },
      { name = "copilot" },
    },
    experimental = {
      ghost_text = {
        hl_group = "Whitespace",
      },
    },
  })
end
