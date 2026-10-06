return {
        "MeanderingProgrammer/render-markdown.nvim", -- Enhanced markdown rendering
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown", "codecompanion" },
	config = function()
		require('render-markdown').setup({
		    file_types = { 'markdown', 'codecompanion' },
		})
	end
}
