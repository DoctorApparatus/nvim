return {
  "echasnovski/mini.files",
  version = false, -- use main branch for latest features
  opts = {
    windows = { preview = true },
    options = { use_as_default_explorer = true }, -- Replaces netrw
  },
  keys = {
    { "<leader>e", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "Open mini.files (current file)" },
    { "<leader>E", function() require("mini.files").open(vim.uv.cwd(), true) end, desc = "Open mini.files (cwd)" },
  },
  -- Lazy-loaded via keys
}
