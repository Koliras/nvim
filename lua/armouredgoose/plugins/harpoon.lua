return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<C-c>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<C-x>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<C-z>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<C-\\>", function() harpoon:list():select(4) end)
	end,
}
