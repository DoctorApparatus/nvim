return {
	"ray-x/yamlmatter.nvim",
	config = function()
		require("yamlmatter").setup({
			icon_mappings = {
				title = "",
				idea = "",
				default = "󰦨",
			},
			key_value_padding = 4, -- Less space
			conceallevel = 1, -- on what level start conceal the yaml text
		})
	end,
}
