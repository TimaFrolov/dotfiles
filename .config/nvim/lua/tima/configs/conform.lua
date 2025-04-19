local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    vue = { 'prettierd' },
    css = { 'prettierd' },
    scss = { 'prettierd' },
    less = { 'prettierd' },
    html = { 'prettierd' },
    json = { 'prettierd' },
    jsonc = { 'prettierd' },
    yaml = { 'prettierd' },
    markdown = { 'prettierd' },
    graphql = { 'prettierd' },
    handlebars = { 'prettierd' },
    cmake = { 'cmake_format' },
    cs = { 'csharpier' },
  },
  formatters = {
    csharpier = {
      command = 'dotnet-csharpier',
      args = { '--write-stdout' },
      stdin = true,
    }
  }
})
