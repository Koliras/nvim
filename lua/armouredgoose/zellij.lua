local s_dir_to_full_dir = {
	h = "left",
	j = "down",
	k = "up",
	l = "right",
}
local action = "move-focus"

local function nav(short_direction)
	local cur_winnr = vim.fn.winnr()
	vim.cmd.wincmd(short_direction)
	local new_winnr = vim.fn.winnr()

	-- if the window ID didn't change, then we didn't switch
	if cur_winnr == new_winnr then
		vim.fn.system("zellij action " .. action .. " " .. s_dir_to_full_dir[short_direction])
	end
end

vim.keymap.set("n", "<c-h>", function()
	nav("h")
end)
vim.keymap.set("n", "<c-j>", function()
	nav("j")
end)
vim.keymap.set("n", "<c-k>", function()
	nav("k")
end)
vim.keymap.set("n", "<c-l>", function()
	nav("l")
end)
