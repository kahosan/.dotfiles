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
    ['<C-n>'] = { 'show', 'fallback' },
    ['<C-p>'] = { 'cancel', 'fallback' },
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
  },
  completion = {
    accept = { auto_brackets = { enabled = false } },
    list = { selection = { auto_insert = false } },
    trigger = {
      show_on_insert_on_trigger_character = false,
    },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        gap = 2,
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
      },
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 250,
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
    default = { 'lsp', 'path', 'buffer', 'copilot', 'css_vars', 'ripgrep', 'lazydev' },
    providers = {
      lsp = {
        name = 'LSP',
        fallbacks = {},
        score_offset = 100,
      },
      path = { name = 'PATH' },
      buffer = { name = 'BUF', max_items = 5, score_offset = -3 },
      cmdline = { name = 'CL' },
      copilot = {
        name = 'CT',
        module = 'blink-copilot',
        async = true,
      },
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
          project_root_fallback = false,
        },
        score_offset = 90,
      },
      lazydev = {
        name = 'LD',
        module = 'lazydev.integrations.blink',
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
