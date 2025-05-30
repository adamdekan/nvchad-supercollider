return {
  { -- Plugin: scnvim
    "davidgranstrom/scnvim",
    lazy = false,
    dependencies = {
      "davidgranstrom/scnvim-tmux",
    },
    config = function()
      local scnvim = require "scnvim"
      local map = scnvim.map
      local map_expr = scnvim.map_expr
      local is_windows = vim.loop.os_uname().sysname:find "Windows" ~= nil

      local config = {
        documentation = {
          cmd = "pandoc", -- Linux default
        },
        keymaps = {
          ["<C-CR>"] = map("editor.send_line", { "i", "n" }),
          ["<A-e>"] = map("editor.send_line", { "i", "n" }),
          ["<A-CR>"] = map("editor.send_block", { "n", "i", "x", "v" }),
          ["<A-\\>"] = map("postwin.toggle", { "n", "x", "i" }),
          ["<A-s>"] = map("sclang.hard_stop", { "n", "x", "i" }),
          ["<leader>sk"] = map("sclang.recompile", { "n" }),
          ["<leader>sc"] = map("postwin.clear", { "n" }),
          ["<leader>sb"] = map_expr "s.boot",
          ["<leader>sr"] = map_expr "s.reboot",
          ["<leader>sm"] = map_expr "s.meter",
        },
        editor = {
          highlight = { color = "IncSearch" },
        },
        on_ready = function()
          require("scnvim.help").render_all()
        end,
      }

      if is_windows then
        config.sclang = {
          cmd = "C:/sc/sclang.exe",
        }
        config.documentation.cmd = "pandoc"
      else
        config.postwin = {
          cmd = "tmux",
        }
        config.extensions = {
          tmux = {
            cmd = "scnvim-tmux.sh",
            args = { "$1" },
            horizontal = false,
            size = "50%",
          },
        }
      end

      scnvim.setup(config)

      if not is_windows then
        scnvim.load_extension "tmux"
      end
    end,
    keys = {
      { "<C-l>", desc = "SCNvim: Hard Stop", mode = { "n", "x", "i" }, ft = "supercollider" },
      { "<leader>sk", desc = "SCNvim: Recompile Sclang", mode = "n", ft = "supercollider" },
      { "<leader>sb", desc = "SCNvim: s.boot()", mode = "n", ft = "supercollider" }, -- Assuming these map_expr are typically normal mode
      { "<leader>sr", desc = "SCNvim: s.reboot()", mode = "n", ft = "supercollider" },
      { "<leader>sm", desc = "SCNvim: s.meter()", mode = "n", ft = "supercollider" },
      { "<leader>sc", desc = "SCNvim: Postwin clear", mode = "n", ft = "supercollider" },
    },
  }, -- End of scnvim plugin spec, comma added

  {
    "davidgranstrom/telescope-scdoc.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "scdoc"
    end,
    keys = {
      {
        "<leader>sd",
        "<cmd>Telescope scdoc<CR>",
        desc = "Telescope SuperCollider Documentation",
      },
    },
  },

  {
    "madskjeldgaard/telescope-supercollider.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "supercollider"
    end,
    keys = {
      {
        "<leader>st",
        function()
          require("telescope").extensions.supercollider.sc_definitions()
        end,
        desc = "Telescope SuperCollider Definitions",
      },
      {
        "<F3>",
        function()
          require("telescope").extensions.supercollider.sc_definitions()
        end,
        mode = { "n", "x", "i" },
        desc = "Telescope SuperCollider Definitions (F3)",
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      vim.g.scnvim_snippet_format = "luasnip"
      local luasnip = require "luasnip"
      local scnvim_utils = require "scnvim.utils"
      luasnip.add_snippets("supercollider", scnvim_utils.get_snippets())
    end,
  },
}
