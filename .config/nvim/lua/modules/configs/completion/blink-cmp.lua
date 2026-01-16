local icons = {
  kind = require('modules.utils.icons').get 'kind',
  type = require('modules.utils.icons').get 'type',
  cmp = require('modules.utils.icons').get 'cmp',
}

---@module 'blink.cmp'
---@type blink.cmp.Config
return {
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-h>'] = { 'show', 'hide' },
  },
  cmdline = {
    keymap = {
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = { auto_show = true },
    },
    sources = function()
      local type = vim.fn.getcmdtype()
      -- Search forward and backward
      if type == '/' or type == '?' then
        return { 'buffer' }
      end
      -- Commands
      if type == ':' or type == '@' then
        return { 'cmdline', 'buffer' }
      end
      return {}
    end,
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    list = { selection = { auto_insert = false } },
    trigger = {
      show_on_insert_on_trigger_character = false,
    },
    menu = {
      draw = {
        -- treesitter = { 'lsp' },
        gap = 2,
        -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
        columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'source_name' } },
        components = {
          label = {
            text = function(ctx)
              return require('colorful-menu').blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require('colorful-menu').blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  signature = { enabled = true },
  appearance = {
    nerd_font_variant = 'mono',
    kind_icons = {
      Text = icons.kind.Text,
      Method = icons.kind.Method,
      Function = icons.kind.Function,
      Constructor = icons.kind.Constructor,

      Field = icons.kind.Field,
      Variable = icons.kind.Variable,
      Property = icons.kind.Property,

      Class = icons.kind.Class,
      Interface = icons.kind.Interface,
      Struct = icons.kind.Struct,
      Module = icons.kind.Module,

      Unit = icons.kind.Unit,
      Value = icons.kind.Value,
      Enum = icons.kind.Enum,
      EnumMember = icons.kind.EnumMember,

      Keyword = icons.kind.Keyword,
      Constant = icons.kind.Constant,

      Snippet = icons.kind.Snippet,
      Color = icons.kind.Color,
      File = icons.kind.File,
      Reference = icons.kind.Reference,
      Folder = icons.kind.Folder,
      Event = icons.kind.Event,
      Operator = icons.kind.Operator,
      TypeParameter = icons.kind.TypeParameter,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer', 'css_vars', 'ripgrep' },
    providers = {
      lsp = {
        name = 'LSP',
        fallbacks = {},
        score_offset = 100,
      },
      path = { name = 'PATH' },
      buffer = { name = 'BUF', max_items = 5, score_offset = -3 },
      cmdline = { name = 'CL' },
      css_vars = {
        name = 'CSSV',
        module = 'css-vars.blink',
        async = true,
        opts = { search_extensions = { '.js', '.ts', '.jsx', '.tsx' } },
      },
      ripgrep = {
        name = 'RIP',
        module = 'blink-ripgrep',
        max_items = 10,
        async = true,
        opts = {
          project_root_marker = '.git',
          backend = {
            ripgrep = {
              project_root_fallback = false,
            },
          },
        },
        score_offset = 90,
      },
    },
  },
  fuzzy = {
    sorts = {
      'exact',

      'score',
      'sort_text',
    },
    implementation = 'prefer_rust_with_warning',
  },
}
