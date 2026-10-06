local opts = { buffer = true, silent = true }

-- 1. Normal Mode: Insert empty code block and place cursor inside
vim.keymap.set("n", "<leader>mc", function()
	-- Unpack the row (line number) properly
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

	-- nvim_buf_set_lines uses 0-indexed line numbers
	vim.api.nvim_buf_set_lines(0, row, row, false, { "```", "", "```" })

	-- Move the cursor into the empty line inside the code block and start typing
	vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
	vim.cmd("startinsert")
end, opts)

-- 2. Visual Mode: Wrap the selected text in a code block
vim.keymap.set("v", "<leader>mc", function()
	-- Exit visual mode to save the selection marks
	vim.cmd("normal! \x1b")

	-- Get the start and end line numbers from the visual selection marks
	local start_line = vim.api.nvim_buf_get_mark(0, "<")[1]
	local end_line = vim.api.nvim_buf_get_mark(0, ">")[1]

	-- Insert the closing fence first, then the opening fence
	vim.api.nvim_buf_set_lines(0, end_line, end_line, false, { "```" })
	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, { "```" })
end, opts)

local function insert_markdown_yaml()
	local buf = vim.api.nvim_get_current_buf()

	-- 1. Get the current filename (without extension and path) for a default title
	local filename = vim.fn.expand("%:t:r")
	if filename == "" then
		filename = "Untitled"
	else
		-- Replace dashes/underscores with spaces and capitalize words for a cleaner title
		filename = filename:gsub("[-_]", " "):gsub("(%a)([%w]*)", function(first, rest)
			return first:upper() .. rest:lower()
		end)
	end

	-- 2. Format the current date (YYYY-MM-DD)
	local current_date = os.date("%Y-%m-%d")

	-- 3. Define your structural YAML header layout
	local yaml_header = {
		"---",
		'title: "' .. filename .. '"',
		"date: " .. current_date,
		"tags: []",
		"categories: []",
		"draft: false",
		"---",
		"", -- Trailing blank line after the header
	}

	-- 4. Safely insert the header at the very top of the file
	vim.api.nvim_buf_set_lines(buf, 0, 0, false, yaml_header)
end

-- Create a user command so you can type `:InsertYAML` in command mode
vim.api.nvim_create_user_command("InsertYAML", insert_markdown_yaml, {})

local function insert_markdown_yaml()
	local buf = vim.api.nvim_get_current_buf()

	-- 1. Get the current filename (without extension and path) for a default title
	local filename = vim.fn.expand("%:t:r")
	if filename == "" then
		filename = "Untitled"
	else
		-- Replace dashes/underscores with spaces and capitalize words for a cleaner title
		filename = filename:gsub("[-_]", " "):gsub("(%a)([%w]*)", function(first, rest)
			return first:upper() .. rest:lower()
		end)
	end

	-- 2. Format the current date (YYYY-MM-DD)
	local current_date = os.date("%Y-%m-%d")

	-- 3. Define your structural YAML header layout
	local yaml_header = {
		"---",
		'title: "' .. filename .. '"',
		"date: " .. current_date,
		"tags: []",
		"categories: []",
		"draft: false",
		"---",
		"", -- Trailing blank line after the header
	}

	-- 4. Safely insert the header at the very top of the file
	vim.api.nvim_buf_set_lines(buf, 0, 0, false, yaml_header)
end

-- Create a user command so you can type `:InsertYAML` in command mode
vim.api.nvim_create_user_command("InsertYAML", insert_markdown_yaml, {})
