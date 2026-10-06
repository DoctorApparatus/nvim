return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          -- 1. Optional: Extend default Ollama properties (e.g. override default local URL or default model)
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = "mistral:latest", -- Replace with your desired Ollama model name
                },
              },
            })
          end,
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              env = { api_key = "MISTRAL_API_KEY" },
            })
          end,
          hermes = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "hermes",
              formatted_name = "Hermes Agent",
              env = {
                url = "http://localhost:8642",
                api_key = "a7b7b0610e9b3d5c547445ca4be2c0eaba60bafe14c7c6d2cc5cd1752e4c4e3d",
              },
              schema = {
                model = { default = "hermes-agent" },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "ollama", -- 2. Set Ollama as your default chat adapter
          tools = {
            ["editor"] = { opts = { user_approval = false } },
            ["cmd_runner"] = { opts = { user_approval = false } },
            ["inline"] = { opts = { user_approval = false } },
          },
        },
      },
    })
  end,
}

