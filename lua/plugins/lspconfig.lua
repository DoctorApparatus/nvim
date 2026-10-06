return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      markdown_oxide = {
        -- Custom settings for markdown-oxide
        settings = {
          -- Example: if you want to specify a workspace root
          -- markdown_oxide = {
          --   workspace_roots = { "path/to/notes" }
          -- }
        },
        -- Optional: Ensure it only attaches to markdown files
        filetypes = { "markdown" },
      },
    },
  },
  config = function(_, opts)
	vim.lsp.config('markdown_oxide', {
	  cmd = { 'markdown-oxide' },
	  filetypes = { 'markdown' },
	  root_markers = { '.git', '.obsidian', '.moxide.toml' },
	  -- Required for markdown-oxide's advanced features
	  capabilities = {
	    workspace = {
	      didChangeWatchedFiles = {
		dynamicRegistration = true,
	      },
	    },
	  },
	})
	vim.lsp.config('qmlls', {})
	vim.lsp.enable('ty')
  end,
}
