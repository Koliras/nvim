return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"https://git.sr.ht/~swaits/zellij-nav.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {},
		config = function()
			local znav = require("zellij-nav")

			vim.keymap.set("n", "<c-h>", function()
				pcall(znav.left)
			end)
			vim.keymap.set("n", "<c-j>", function()
				pcall(znav.down)
			end)
			vim.keymap.set("n", "<c-k>", function()
				pcall(znav.up)
			end)
			vim.keymap.set("n", "<c-l>", function()
				pcall(znav.right)
			end)
		end,
	},
	{
		"https://github.com/fresh2dev/zellij.vim",
		-- Pin version to avoid breaking changes.
		-- tag = '0.3.*',
		lazy = false,
		init = function()
			-- Options:
			-- vim.g.zelli_navigator_move_focus_or_tab = 1
			-- vim.g.zellij_navigator_no_default_mappings = 1
		end,
	},
}
