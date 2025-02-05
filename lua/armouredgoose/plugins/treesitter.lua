local lit_type_to_lsp_type = {
	string = "string",
	number = "number",
	["true"] = "boolean",
	["false"] = "boolean",
	null = "null",
}

return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
	config = function(_, opts)
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)
		local ts = require("nvim-treesitter.ts_utils")

		--- @param node TSNode
		--- @param buf number
		local function literal_type_to_type(node, buf)
			local child = node:named_child(0)
			if child == nil then
				return
			end
			local content = lit_type_to_lsp_type[child:type()]
			local start_row, start_col, end_row, end_col = child:range()
			vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, { content })
		end
		--- @param node TSNode
		--- @param buf number
		local function handle_type_ann_insides(node, buf)
			if node:type() == "literal_type" then
				literal_type_to_type(node, buf)
			elseif node:type() == "object_type" then
				for _, property_signature in ipairs(node:named_children()) do
					Prop_signature_to_type(property_signature, buf)
				end
			elseif node:type() == "tuple_type" then
				local first_child = node:named_child(0)
				if first_child == nil then
					return
				end
				handle_type_ann_insides(first_child, buf)
				local content = vim.treesitter.get_node_text(first_child, buf)
				local start_row, start_col, end_row, end_col = node:range()
				vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, { content .. "[]" })
			end
		end
		---@param node TSNode
		--- @param buf number
		function Prop_signature_to_type(node, buf)
			local type_annotation = node:named_children()[2]
			if type_annotation == nil then
				return
			end
			local type = type_annotation:named_child(0)
			if type == nil then
				return
			end
			handle_type_ann_insides(type, buf)
		end

		local function json_to_type()
			vim.cmd.w()
			local bufnr = vim.api.nvim_get_current_buf()
			local node = ts.get_node_at_cursor()
			if node == nil then
				return
			end
			local root = ts.get_root_for_node(node)
			while node:type() ~= "type_alias_declaration" and node:type() ~= "interface_declaration" do
				local parent = node:parent()
				if parent == nil or root:equal(parent) then
					return
				end
				node = parent
			end
			local object_type = node:named_children()[2] -- get type body
			if object_type == nil then
				return
			end
			for _, property_signature in ipairs(object_type:named_children()) do
				Prop_signature_to_type(property_signature, bufnr)
			end
		end

		vim.keymap.set("n", "<leader>js", json_to_type)
	end,
}
