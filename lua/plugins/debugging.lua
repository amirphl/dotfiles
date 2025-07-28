return {
  -- Vimspector (Debugger)
  { "puremourning/vimspector" },
  -- nvim-dap (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    optional = true,
  },
  -- DAP for Go
  {
    "leoluz/nvim-dap-go",
    ft = "go", -- Only load for Go files
    dependencies = "mfussenegger/nvim-dap",
    opts = {},
    config = function()
      require("dap-go").setup({
        -- Additional dap configurations can be added.
        -- dap_configurations accepts a list of tables where each entry
        -- represents a dap configuration. For more details do:
        -- :help dap-configuration
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "My - Attach remote",
            mode = "remote",
            request = "attach",
          },
          {
            type = "go",
            name = "Debug Current File",
            request = "launch",
            mode = "debug",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug Test",
            request = "launch",
            mode = "test",
            program = "${file}",
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = "dlv",
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port.
          -- if you set a port in your debug configuration, its value will be
          -- assigned dynamically.
          port = "${port}",
          -- additional args to pass to dlv
          -- args = { "--log", "--log-output=debugger,rpc", "--log-dest=/home/amirphl/sources/delve_nvim_dap_go.log" },
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          -- avaliable ui interactive function to prompt for arguments get_arguments
          build_flags = {},
          -- whether the dlv process to be created detached or not. there is
          -- an issue on delve versions < 1.24.0 for Windows where this needs to be
          -- set to false, otherwise the dlv server creation will fail.
          -- avaliable ui interactive function to prompt for build flags: get_build_flags
          detached = vim.fn.has("win32") == 0,
          -- the current working directory to run dlv from, if other than
          -- the current working directory.
          cwd = nil,
        },
        -- options related to running closest test
        tests = {
          -- enables verbosity when running the test.
          verbose = true,
        },
      })
    end,
  },
  -- Python debugging
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
      end
    end,
  },
  -- DAP for JavaScript/TypeScript (VSCode JS Debugger)
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
        -- Alternative paths (uncomment if needed):
        -- debugger_path = "/home/amirphl/vscode-js-debug",
        -- debugger_path = '/home/amirphl/.vscode-oss/extensions/kylinideteam.js-debug-0.1.3-universal',
        -- debugger_cmd      = { 'js-debug-adapter' },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        log_file_path = "/tmp/dap_vscode_js.log", -- Simpler log path
        log_file_level = vim.log.levels.DEBUG,
        log_console_level = vim.log.levels.DEBUG,
      })
    end,
  },

  { "rcarriga/nvim-dap-ui" }, -- UI (optional but recommended)
}
