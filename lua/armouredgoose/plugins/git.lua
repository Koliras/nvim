return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		'tpope/vim-fugitive',
		config = function()
			vim.keymap.set("n", "<leader>d", ":Gvdiff ")
			vim.keymap.set("n", "<leader>dv", ":Gvdiff develop<cr>")
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},
}
