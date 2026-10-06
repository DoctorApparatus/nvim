return {
	"saghen/blink.cmp",
	-- Load a release tag to avoid breaking changes
	version = "v0.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("blink.cmp").setup({
			-- Keymap configuration
			keymap = {
				preset = "default", -- Uses <C-y> to accept, <C-n>/<C-p> to navigate
				-- For "super-tab" behavior, uncomment below
				-- preset = "super-tab",
			},

			appearance = {
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				nerd_font_variant = "mono",
			},

			-- Default sources included in blink.cmp
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- Enable documentation and ghost text
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
				menu = {
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
		})
	end,
}
