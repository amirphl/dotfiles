local dap = require("dap")

-- Scala configurations (for nvim-metals)
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

-- C/C++/Rust configurations
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  -- command = "/home/amirphl/.cursor/extensions/ms-vscode.cpptools-1.23.6-darwin-arm64/debugAdapters/bin/OpenDebugAD7",
  command = "/home/amirphl/.cursor/extensions/anysphere.cpptools-2.0.0-linux-x64/debugAdapters/bin/OpenDebugAD7",
}

dap.adapters.codelldb = {
  type = "executable",
  command = "/home/amirphl/.cursor/extensions/vadimcn.vscode-lldb-1.11.4/adapter/codelldb",
}

dap.configurations.cpp = {
  -- Your C++ debug configurations here (from your snippet)
  -- Example:
  {
    name = "rabbiter",
    type = "codelldb",
    request = "launch",
    program = function()
      return "/home/amirphl/sources/cipherTrader/arbitrage/build/bin/arbitrage_bot"
    end,
    -- args = { '--gtest_filter=-StrategyLoaderTest.*' },
    -- "environment": [],
    -- "externalConsole": false,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    MIMode = "lldb",
    MIDebuggerPath = "/usr/bin/lldb",
    -- setupCommands = {
    -- 	{
    -- 		text = '-enable-pretty-printing',
    -- 		description = 'enable pretty printing',
    -- 		ignoreFailures = false
    -- 	},
    -- },
  },
  {
    name = "CipherTrader_tests",
    type = "codelldb",
    request = "launch",
    program = function()
      return "/home/amirphl/sources/cipherTrader/build/CipherTrader_tests"
    end,
    -- args = { "--gtest_filter=StrategyLoaderTest.CreateFallbackValid" },
    -- args = { '--gtest_filter=DynamicBlazeArrayTest.EdgeCases' },
    -- args = { '--gtest_filter=-StrategyLoaderTest.*' },
    -- args = { '--gtest_filter=ExchangeTest.OrderSubmissionWithInsufficientBalance' },
    args = function()
      local filter = vim.fn.input("Enter gtest_filter: ")
      if filter == "" then
        filter = "-StrategyLoaderTest.*" -- Default filter if none provided
      end
      return { "--gtest_filter=" .. filter }
    end,
    -- "environment": [],
    -- "externalConsole": false,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    MIMode = "lldb",
    MIDebuggerPath = "/usr/bin/lldb",
    -- setupCommands = {
    -- 	{
    -- 		text = '-enable-pretty-printing',
    -- 		description = 'enable pretty printing',
    -- 		ignoreFailures = false
    -- 	},
    -- },
  },
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      return vim.fn.input("Path to executable: " .. vim.fn.getcwd() .. "/")
    end,
    -- args = { "--gtest_filter=StrategyLoaderTest.CreateFallbackValid" },
    -- "environment": [],
    -- "externalConsole": false,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    MIMode = "lldb",
    MIDebuggerPath = "/usr/bin/lldb",
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "127.0.0.1:1234",
    miDebuggerPath = "/usr/bin/gdb",
    cwd = "${workspaceFolder}",
    program = function()
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      return vim.fn.input("Path to executable: " .. vim.fn.getcwd() .. "/")
    end,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Go configurations (using Delve)
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
    -- add this if on windows, otherwise server won't open successfully
    -- detached = false
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "My - Debug TMS",
    request = "launch",
    program = "/home/amirphl/sources/tms/cmd/executor/",
    dlvFlags = {
      "--log",
      "--log-output=debugger,rpc",
      "--log-dest=/home/amirphl/sources/tms/delve_tms.log",
    },
  },
  {
    type = "delve",
    name = "My - Debug Simple Trader",
    request = "launch",
    program = "/home/amirphl/sources/simple-trader/cmd/",
    -- dlvFlags = {
    --   "--log",
    --   "--log-output=debugger,rpc",
    --   "--log-dest=/home/amirphl/sources/simple-trader/delve_trader.log",
    -- },
  },
  {
    type = "delve",
    name = "My - Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "My - Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua
-- language config
--
for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "dev debug",
      -- program           = '${file}',
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      -- cwd        = vim.fn.getcwd(),
      -- runtimeExecutable = 'APP_ENV_MODE=DEV nest', -- TODO
      runtimeExecutable = "nest",
      runtimeArgs = { "start", "--watch" },
      stopOnEntry = false,
      sourceMaps = true,
      outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
      protocol = "inspector",
      console = "integratedTerminal",
      -- args                      = { "${file}" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "debug prod",
      -- program           = '${file}',
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      -- cwd        = vim.fn.getcwd(),
      -- runtimeExecutable         = 'APP_ENV_MODE=PROD node', -- TODO
      runtimeExecutable = "node",
      runtimeArgs = { "-r", "source-map-support/register", "dist/main" },
      stopOnEntry = false,
      sourceMaps = true,
      outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
      protocol = "inspector",
      console = "integratedTerminal",
      -- args                      = { "${file}" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      host = "localhost",
      port = 9229,
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      processId = 842142,
      -- processId  = require('dap.utils').pick_process,
      console = "integratedTerminal",
    },
  }
end

if not dap.adapters["codelldb"] then
  require("dap").adapters["codelldb"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = {
        "--port",
        "${port}",
      },
    },
  }
end

-- Python configurations
dap.adapters.python = {
  type = "executable",
  command = "python3",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return "python3"
    end,
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "launch",
    name = "Launch file with arguments",
    program = "${file}",
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      return vim.split(args_string, " ")
    end,
    pythonPath = function()
      return "python3"
    end,
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to running process",
    connect = {
      host = "localhost",
      port = 5678,
    },
    mode = "remote",
    cwd = "${workspaceFolder}",
    pathMappings = {
      {
        localRoot = "${workspaceFolder}",
        remoteRoot = "/app",
      },
    },
  },
}

-- for _, lang in ipairs({ "c", "cpp" }) do
--   dap.configurations[lang] = {
--     {
--       type = "codelldb",
--       request = "launch",
--       name = "Launch file",
--       program = function()
--         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--       end,
--       cwd = "${workspaceFolder}",
--     },
--     {
--       type = "codelldb",
--       request = "attach",
--       name = "Attach to process",
--       pid = require("dap.utils").pick_process,
--       cwd = "${workspaceFolder}",
--     },
--   }
-- end
