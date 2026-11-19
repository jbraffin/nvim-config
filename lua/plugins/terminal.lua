-- ╔═══════════════════════════════════════════════════════════╗
-- ║        Terminal Integration - ToggleTerm                  ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Taille du terminal
        size = 20,
        open_mapping = [[<C-\>]], -- Ctrl+\ pour ouvrir/fermer
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float", -- float, horizontal, vertical, tab
        close_on_exit = true,
        shell = vim.o.shell,
        autochdir = false,
      })

      -- Keymaps pratiques
      local opts = { noremap = true, silent = true }

      -- Escape pour sortir du mode terminal (revenir en mode command)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

      -- Terminal flottant
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)

      -- Terminal horizontal en bas
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", opts)

      -- Terminal vertical à droite
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", opts)

      -- Fonction pour lancer des commandes dans le terminal
      local Terminal = require("toggleterm.terminal").Terminal

      -- Terminal nodejs/npm
      local node_toggle = Terminal:new({
        cmd = "node",
        direction = "float",
        hidden = true,
        display_name = "Node",
      })

      vim.keymap.set("n", "<leader>tn", function() node_toggle:toggle() end, opts)

      local function send_k9s_input(term, input)
        if term.job_id then
          pcall(vim.api.nvim_chan_send, term.job_id, input)
        end
      end

      local k9s_bin = vim.fn.exepath("k9s")
      if k9s_bin == "" and vim.fn.executable("/opt/homebrew/bin/k9s") == 1 then
        k9s_bin = "/opt/homebrew/bin/k9s"
      end
      if k9s_bin == "" then
        k9s_bin = "k9s"
      end

      local k9s_environments = {
        {
          key = "d",
          name = "Dev",
          context = "gke_sp-scdp-nprd-dtep_europe-west1_gke-scdp-nprd-mdio",
          namespace = "scdp-receivit-dev",
        },
        {
          key = "q",
          name = "SIT",
          context = "gke_sp-scdp-nprd-dtep_europe-west1_gke-scdp-nprd-mdio",
          namespace = "scdp-receivit-sit",
        },
        {
          key = "r",
          name = "UAT",
          context = "gke_sp-scdp-nprd-dtep_europe-west1_gke-scdp-nprd-mdio",
          namespace = "scdp-receivit-uat1",
        },
        {
          key = "a",
          name = "Prep",
          context = "gke_sp-scdp-nprd-dtep_europe-west1_gke-scdp-nprd-mdio",
          namespace = "scdp-receivit-prep",
        },
        {
          key = "p",
          name = "Prod",
          context = "gke_sp-scdp-prod-dtep_europe-west1_gke-scdp-prod-yuio",
          namespace = "scdp-receivit-prod",
        },
        {
          key = "w",
          name = "West4 Prep",
          context = "gke_sp-scdp-nprd-dtep_europe-west4_gke-scdp-nprd-tyjo",
          namespace = "scdp-receivit-prep",
        },
        {
          key = "x",
          name = "West4 Prod",
          context = "gke_sp-scdp-prod-dtep_europe-west4_gke-scdp-prod-erdf",
          namespace = "scdp-receivit-prod",
        },
        {
          key = "t",
          name = "Tools",
          context = "gke_sp-scdp-prod-dtep_europe-west1_gke-scdp-prod-yuio",
          namespace = "scdp-receivit-tools-prod",
        },
      }

      local function k9s_environment_command(environment, writable)
        return table.concat({
          vim.fn.shellescape(k9s_bin),
          "--context", vim.fn.shellescape(environment.context),
          writable and "--write" or "--readonly",
          "-n", vim.fn.shellescape(environment.namespace),
          "-c pod",
        }, " ")
      end

      local function k9s_command_with_mode(command, writable)
        local base_command = command or vim.fn.shellescape(k9s_bin)
        base_command = base_command:gsub("%s+%-%-readonly", ""):gsub("%s+%-%-write", "")
        return base_command .. (writable and " --write" or " --readonly")
      end

      local function choose_k9s_mode(name, callback)
        local choice = vim.fn.confirm(
          "Mode K9s pour " .. name .. " ?",
          "&1 Lecture seule\n&2 Lecture-écriture\n&0 Annuler",
          1
        )
        if choice == 1 then
          callback(false)
        elseif choice == 2 then
          callback(true)
        end
      end

      local k9s
      local function k9s_is_running()
        return k9s.job_id and vim.fn.jobwait({ k9s.job_id }, 0)[1] == -1
      end

      local function launch_k9s_environment(environment, writable)
        local command = k9s_environment_command(environment, writable)

        if k9s_is_running() then
          -- Restart the single K9s session with the requested context/namespace.
          k9s.next_command = command
          send_k9s_input(k9s, ":q\r")
          return
        end

        if k9s.bufnr and vim.api.nvim_buf_is_valid(k9s.bufnr) then
          k9s:shutdown()
        end
        k9s.cmd = command
        k9s:open()
      end

      local function select_k9s_environment(environment)
        choose_k9s_mode(environment.name, function(writable)
          launch_k9s_environment(environment, writable)
        end)
      end

      -- K9s runs as a full-screen TUI, so give it a dedicated tab.
      k9s = Terminal:new({
        cmd = vim.fn.shellescape(k9s_bin),
        direction = "tab",
        hidden = true,
        display_name = "K9s",
        env = {
          EDITOR = "nvim",
          KUBE_EDITOR = "nvim",
          VISUAL = "nvim",
        },
        on_exit = function(term)
          local next_command = term.next_command
          if next_command then
            term.next_command = nil
            term.cmd = next_command
            vim.schedule(function()
              term:open()
            end)
          end
        end,
        on_open = function(term)
          -- The global terminal <Esc> mapping leaves terminal mode. Forward it
          -- to K9s so its TUI and the nested Neovim editor can use Escape.
          vim.keymap.set("t", "<Esc>", function()
            send_k9s_input(term, "\27")
          end, { buffer = term.bufnr, silent = true, desc = "Send Escape to K9s" })
          vim.keymap.set("t", "<F12>", function()
            term:toggle()
          end, { buffer = term.bufnr, silent = true, desc = "Hide K9s and return to Neovim" })
          vim.keymap.set("t", "<leader>kk", function()
            term:toggle()
          end, { buffer = term.bufnr, silent = true, desc = "Hide K9s" })
          vim.keymap.set("t", "<leader>kq", function()
            send_k9s_input(term, ":q\r")
          end, { buffer = term.bufnr, silent = true, desc = "Quit K9s" })
        end,
      })

      local function toggle_k9s()
        if k9s:is_open() then
          k9s:close()
          return
        end
        if k9s_is_running() then
          k9s:open()
          return
        end

        if k9s.bufnr and vim.api.nvim_buf_is_valid(k9s.bufnr) then
          k9s:shutdown()
        end
        choose_k9s_mode("session K9s", function(writable)
          k9s.cmd = k9s_command_with_mode(k9s.cmd, writable)
          k9s:open()
        end)
      end

      vim.keymap.set("n", "<leader>kk", toggle_k9s, { desc = "Toggle K9s" })
      vim.keymap.set("n", "<leader>kq", function()
        send_k9s_input(k9s, ":q\r")
      end, { desc = "Quit K9s" })
      vim.keymap.set("n", "<leader>kc", function()
        if k9s_is_running() then
          if not k9s:is_open() then
            k9s:open()
          end
          send_k9s_input(k9s, ":ctx\r")
          return
        end

        if k9s.bufnr and vim.api.nvim_buf_is_valid(k9s.bufnr) then
          k9s:shutdown()
        end
        choose_k9s_mode("sélecteur de contexte", function(writable)
          local command = vim.fn.shellescape(k9s_bin) .. " --command ctx"
          k9s.cmd = k9s_command_with_mode(command, writable)
          k9s:open()
        end)
      end, { desc = "Select Kubernetes context" })
      for _, environment in ipairs(k9s_environments) do
        local target = environment
        vim.keymap.set("n", "<leader>ka" .. target.key, function()
          select_k9s_environment(target)
        end, { desc = "K9s " .. target.name })
      end
      vim.api.nvim_create_user_command("K9s", toggle_k9s, { desc = "Toggle K9s" })
    end,
  }
}
