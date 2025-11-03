-- ~/.config/nvim/lua/plugins/examify-tasks.lua
return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
    keys = {
      { "<leader>tt", "<cmd>OverseerToggle<cr>", desc = "Tasks: Toggle list" },
      { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Tasks: Run template" },
      { "<leader>eN", "<cmd>ExamifyNoPy<cr>", desc = "Start Examify (no Python)" },
      { "<leader>eA", "<cmd>ExamifyAll<cr>", desc = "Start Examify (all services)" },
    },
    opts = {
      templates = { "builtin" }, -- ship with a few handy presets
      task_list = {
        direction = "bottom",
        min_height = 10,
        max_height = 18,
        bindings = { ["q"] = "Close" },
      },
      -- sensible defaults for small, spammy dev servers
      strategy = {
        "toggleterm", -- or "job" if you don't want terminals (see note below)
        -- direction, size, etc. are configured in the toggleterm plugin if you use it
      },
      -- add timestamps so you can see restarts/reloads clearly
      log = { {
        type = "echo",
        level = vim.log.levels.WARN,
      } },
    },
    config = function(_, opt)
      local overseer = require("overseer")
      overseer.setup(opt)

      -- Helper to create a task
      local function mk(name, cmd, args, cwd)
        return overseer.new_task({
          name = name,
          cmd = cmd,
          args = args or {},
          cwd = cwd,
          components = {
            "default",
            "on_output_summarize",
            { "on_output_quickfix", open = false },
            "unique", -- prevents accidental duplicate starts by name
            "display_duration",
            "restart_on_save", -- handy for servers you want to bounce on file save (optional)
          },
        })
      end

      -- If you're using LazyVim's rooter, feel free to swap vim.fn.getcwd()
      local root = vim.fn.getcwd()
      local paths = {
        backend = root .. "/examify-backend",
        frontend = root .. "/examify",
        docsvc = root, -- python paths are project-root per your tasks.json
        logic = root,
      }

      -- :ExamifyNoPy -> backend + frontend
      vim.api.nvim_create_user_command("ExamifyNoPy", function()
        local t1 = mk("Run npm dev (examify-backend)", "npm", { "run", "dev" }, paths.backend)
        local t2 = mk("Run yarn dev (examify)", "yarn", { "dev" }, paths.frontend)
        t1:start()
        t2:start()
        overseer.open({ direction = "bottom" })
      end, {})

      -- :ExamifyAll -> backend + frontend + doc service + logic service
      vim.api.nvim_create_user_command("ExamifyAll", function()
        local t1 = mk("Run npm dev (examify-backend)", "npm", { "run", "dev" }, paths.backend)
        local t2 = mk("Run yarn dev (examify)", "yarn", { "dev" }, paths.frontend)
        local t3 = mk(
          "Run Python app (examify-document-service)",
          "python",
          { "examify-document-service/src/app.py" },
          paths.docsvc
        )
        local t4 = mk("Run Python app (examify-logic)", "python", { "examify-logic/src/app.py" }, paths.logic)
        t1:start()
        t2:start()
        t3:start()
        t4:start()
        overseer.open({ direction = "bottom" })
      end, {})

      -- Optional: integrate with nvim-dap so tasks can run before debugging sessions
      -- require("overseer").patch_dap(true)
    end,
  },

  -- OPTIONAL: nice terminals per task (Overseer strategy = "toggleterm" above)
  -- If you prefer plain job buffers, remove this plugin and set strategy = "job"
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shade_terminals = false,
      persist_mode = false,
      start_in_insert = true,
      -- You can tune sizes/directions globally here
    },
  },

  -- OPTIONAL (advanced): Node/TS debug like VS Code launch.json
  -- Install js-debug and wire dap for Node backends if you want breakpoints, etc.
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     "mxsdev/nvim-dap-vscode-js",
  --     "jay-babu/mason-nvim-dap.nvim",
  --   },
  --   config = function()
  --     require("mason-nvim-dap").setup({ ensure_installed = { "js" } })
  --     require("dap-vscode-js").setup({
  --       debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
  --       adapters = { "pwa-node" },
  --     })
  --     local dap = require("dap")
  --     dap.configurations.typescript = {
  --       {
  --         name = "Attach to Examify Backend",
  --         type = "pwa-node",
  --         request = "attach",
  --         port = 9229, -- start backend with --inspect=9229
  --         cwd = "${workspaceFolder}/examify-backend",
  --         -- With Overseer-DAP patched, you can auto-run the backend task before attach
  --         -- preLaunchTask = "Run npm dev (examify-backend)",
  --       },
  --     }
  --   end,
  -- },
}
