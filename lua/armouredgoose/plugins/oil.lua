return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		vim.keymap.set("n", "<leader>x", "<cmd>Oil<CR>"),
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-s>"] = { "actions.select", opts = { vertical = true } },
			["<C-p>"] = "actions.preview",
			["<C-c>"] = { "actions.close", mode = "n" },
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["gs"] = { "actions.change_sort", mode = "n" },
			["gx"] = "actions.open_external",
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["g\\"] = { "actions.toggle_trash", mode = "n" },
		},
		use_default_keymaps = false,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
			-- This function defines what is considered a "hidden" file
			is_hidden_file = function(name, bufnr)
				local m = name:match("^%.")
				return m ~= nil
			end,
			-- This function defines what will never be shown, even when `show_hidden` is set
			is_always_hidden = function(name, bufnr)
				if name == ".git" then
					return true
				end
				return false
			end,
			-- Sort file names with numbers in a more intuitive order for humans.
			-- Can be "fast", true, or false. "fast" will turn it off for large directories.
			natural_order = "fast",
			-- Sort file and directory names case insensitive
			case_insensitive = false,
			sort = {
				-- sort order can be "asc" or "desc"
				-- see :help oil-columns to see which columns are sortable
				{ "type", "asc" },
				{ "name", "asc" },
			},
			-- Customize the highlight group for the file name
			highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
				return nil
			end,
		},
		skip_confirm_for_simple_edits = true,
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
}
