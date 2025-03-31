return {
  presets = {
    lsp_doc_border = false,
  },
  cmdline = {
    enabled = false,
  },
  messages = {
    enabled = false,
  },
  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  notify = {
    enabled = false,
  },
}
