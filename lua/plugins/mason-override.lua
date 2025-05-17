-- lua/custom/plugins/mason_override.lua
return {
  {
    "williamboman/mason.nvim",
    -- Force lazy.nvim to use the SSH URL instead of HTTPS
    url = "git@github.com:williamboman/mason.nvim.git",
    opts = {
      ensure_installed = {
        "pyright",
      },
    },
    -- You can also add other mason.nvim specific configurations here if needed
    -- For example:
    -- build = ":MasonUpdate",
    -- opts = {
    --   ui = {
    --     border = "rounded",
    --   },
    -- },
  },
}
