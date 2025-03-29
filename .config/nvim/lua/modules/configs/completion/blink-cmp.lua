return {
  keymap = {
    preset = "none",
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
  },
  cmdline = {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        auto_show = true,
      },
    },
  },
  completion = {
    menu = {
      draw = {
        gap = 10,
        treesitter = { "lsp" },
        columns = { { "kind_icon", gap = 1, "label", "label_description" }, { "source_name" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
    },
  },
  appearance = { nerd_font_variant = "normal" },
  sources = {
    default = { "lsp", "path", "buffer", "copilot", "css_vars", "ripgrep" },
    providers = {
      lsp = { name = "LSP", min_keyword_length = 1 },
      path = { name = "PATH" },
      buffer = { name = "BUF", min_keyword_length = 1 },
      cmdline = { name = "CL" },
      copilot = {
        name = "CT",
        module = "blink-copilot",
        async = true,
      },
      css_vars = {
        name = "CSSV",
        module = "css-vars.blink",
        min_keyword_length = 1,
        opts = {
          search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
        },
      },
      ripgrep = {
        name = "RIP",
        module = "blink-ripgrep",
        min_keyword_length = 1,
        opts = {
          prefix_min_len = 3,
          additional_rg_options = {
            "--hidden",
          },
        },
      },
    },
  },
  fuzzy = {
    sorts = {
      "exact",

      "score",
      "sort_text",
    },
    implementation = "prefer_rust_with_warning",
  },
}
