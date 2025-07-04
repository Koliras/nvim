return {
	-- "folke/tokyonight.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- opts = {},
	-- config = function()
	-- 	require("tokyonight").setup({
	-- 		style = "moon",
	-- 		transparent = true,
	-- 		light_style = "day", -- The theme is used when the background is set to light
	-- 		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	-- 		styles = {
	-- 			comments = {},
	-- 			keywords = {},
	-- 			functions = {},
	-- 			variables = {},
	-- 			-- Background styles. Can be "dark", "transparent" or "normal"
	-- 			sidebars = "transparent", -- style for sidebars, see below
	-- 			floats = "transparent", -- style for floating windows
	-- 		},
	-- 		day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	-- 		dim_inactive = false, -- dims inactive windows
	-- 		lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
	--
	-- 		--- You can override specific color groups to use other groups or a hex color
	-- 		--- function will be called with a ColorScheme table
	-- 		---@param colors ColorScheme
	-- 		on_colors = function(colors) end,
	--
	-- 		--- You can override specific highlights to use other groups or a hex color
	-- 		--- function will be called with a Highlights and ColorScheme table
	-- 		---@param highlights tokyonight.Highlights
	-- 		---@param colors ColorScheme
	-- 		on_highlights = function(highlights, colors) end,
	--
	-- 		cache = true, -- When set to true, the theme will be cached for better performance
	--
	-- 		---@type table<string, boolean|{enabled:boolean}>
	-- 		plugins = {
	-- 			-- enable all plugins when not using lazy.nvim
	-- 			-- set to false to manually enable/disable plugins
	-- 			all = package.loaded.lazy == nil,
	-- 			-- uses your plugin manager to automatically enable needed plugins
	-- 			-- currently only lazy.nvim is supported
	-- 			auto = true,
	-- 			-- add any plugins here that you want to enable
	-- 			-- for all possible plugins, see:
	-- 			--   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
	-- 			telescope = true,
	-- 		},
	-- 	})
	-- 	vim.cmd.colorscheme("tokyonight")
	-- end,
	"zenbones-theme/zenbones.nvim",
	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	dependencies = "rktjmp/lush.nvim",
	lazy = false,
	priority = 1000,
	-- you can set set configuration options here
	config = function()
		vim.g.zenbones_darken_comments = 45
		vim.cmd.colorscheme("zenbones")
	end,
}
