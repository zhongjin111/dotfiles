-- lua/plugins/nvim-dap-ui.lua
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 虚拟文本
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = true,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, _, _, _, _, _, _)
          local value = variable.value
          if #value > 50 then
            value = value:sub(1, 50) .. "..."
          end
          return " " .. variable.name .. " = " .. value
        end,
      })

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 0.3,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.9,
          border = "rounded",
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- 使用 mason-registry 获取调试器路径
      local registry = require("mason-registry")
      local function get_mason_path(package, binary)
        local ok, pkg = pcall(registry.get_package, package)
        if ok and pkg:is_installed() then
          return pkg:get_install_path() .. "/" .. binary
        end
        return nil
      end

      -- ============ 通用键位（<leader>d + 动作键） ============
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "调试继续" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "单步跳过" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "单步进入" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "单步跳出" })

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "切换断点" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("断点条件: "))
      end, { desc = "条件断点" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "打开 REPL" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "终止调试" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "切换 DAP UI" })

      require("which-key").add({
        { "<leader>d", group = "调试" },
      })

      -- ============ C / C++ / Rust (codelldb) ============
      local codelldb_path = get_mason_path("codelldb", "codelldb")
          or vim.fn.exepath("codelldb")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      local codelldb_config = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = codelldb_config
      dap.configurations.cpp = codelldb_config
      dap.configurations.rust = codelldb_config

      -- ============ Python (debugpy) ============
      local debugpy_path = get_mason_path("debugpy", "bin/debugpy-adapter")
          or "python"

      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          cb({ type = "server", port = config.port, host = config.host or "127.0.0.1" })
        else
          local cmd = debugpy_path
          local args
          if cmd == "python" then
            args = { "-m", "debugpy.adapter", "--port", "${port}" }
          else
            args = { "--port", "${port}" }
          end
          cb({
            type = "server",
            port = "${port}",
            executable = { command = cmd, args = args },
          })
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3")
                or vim.fn.exepath("python")
                or "python"
          end,
        },
        {
          type = "python",
          request = "launch",
          name = "Launch with args",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
        },
      }

      -- ============ Go (delve) ============
      local dlv_path = get_mason_path("delve", "dlv")
          or vim.fn.exepath("dlv")

      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = dlv_path,
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          program = "${file}",
          args = { "-test.run", ".*" },
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },
}
