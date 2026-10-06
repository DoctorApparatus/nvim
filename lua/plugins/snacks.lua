return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = { enabled = true },
	dashboard = {
	  sections = {
		{ section = "header" },
		{ section = "keys", gap = 1, padding = 1 },
		{ section = "startup" },
	  },
    }
  },
  keys = {
    -- Find files with <leader>ff
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    -- Find word (grep) with <leader>fw
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- Optional: Live grep (search for text as you type)
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
  },
}
