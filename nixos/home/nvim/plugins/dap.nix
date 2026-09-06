plugins: with plugins; [
  {
    pkg = nvim-dap;
    keys = "require('tima.mappings.dap')";
    config = "function() require('tima.configs.dap') end";
    dependencies = [
      nvim-dap-ui
      nvim-dap-virtual-text
    ];
  }
  {
    pkg = nvim-dap-ui;
    keys = "require('tima.mappings.dapui')";
    config = "function() require('dapui').setup() end";
    dependencies = [ nvim-nio ];
  }
  {
    pkg = nvim-dap-virtual-text;
    config = "function() require('nvim-dap-virtual-text').setup({}) end";
  }
]
