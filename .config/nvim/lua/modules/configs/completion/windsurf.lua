return function()
  require('codeium').setup {
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      key_bindings = {
        accept = '<C-i>',
      },
    },
  }
end
