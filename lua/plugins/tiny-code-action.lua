return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-telescope/telescope.nvim"},
        {"ibhagwan/fzf-lua"},
        {
          "folke/snacks.nvim",
          opts = {
            terminal = {},
          }
        }
    },
    event = "LspAttach",
    config = function()
	require("tiny-code-action").setup({
	    picker = "snacks"
	})
	vim.keymap.set({ "n", "x" }, "<leader>ca", function()
		require("tiny-code-action").code_action()
	end, { noremap = true, silent = true })
    end
}
