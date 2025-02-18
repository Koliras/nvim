local LITERAL_TYPE_TO_LSP_TYPE = {
	string = "string",
	number = "number",
	unary_expression = "number",
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
		--- @param options { bufnr: number }
		local function literal_type_to_type(node, options)
			local child = node:named_child(0)
			if child == nil then
				return
			end
			local content = LITERAL_TYPE_TO_LSP_TYPE[child:type()]
			local start_row, start_col, end_row, end_col = child:range()
			vim.api.nvim_buf_set_text(options.bufnr, start_row, start_col, end_row, end_col, { content })
		end
		--- @param node TSNode
		--- @param options { bufnr: number }
		local function handle_type_ann_insides(node, options)
			local node_type = node:type()
			if node_type == "literal_type" then
				literal_type_to_type(node, options)
			elseif node_type == "object_type" then
				for i = 0, node:named_child_count() - 1 do
					local property_signature = node:named_child(i)
					---@diagnostic disable-next-line: need-check-nil
					local type_annotation = property_signature:named_children()[2]
					if type_annotation == nil then
						return
					end
					local type = type_annotation:named_child(0)
					if type == nil then
						return
					end
					handle_type_ann_insides(type, options)
				end
			elseif node_type == "tuple_type" then
				local first_element_of_array = node:named_child(0)
				if first_element_of_array == nil then
					return
				end
				handle_type_ann_insides(first_element_of_array, options)
				local content = vim.treesitter.get_node_text(first_element_of_array, options.bufnr)
				local start_row, start_col, end_row, end_col = node:range()
				local lines = {}
				for s in content:gmatch("[^\r\n]+") do
					table.insert(lines, s)
				end
				lines[#lines] = lines[#lines] .. "[]"
				vim.api.nvim_buf_set_text(options.bufnr, start_row, start_col, end_row, end_col, lines)
			end
		end

		local function json_to_type()
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
			local type_annotation = node:named_children()[2] -- get type body
			if type_annotation == nil then
				return
			end
			local options = { bufnr = bufnr }
			handle_type_ann_insides(type_annotation, options)
		end

		vim.keymap.set("n", "<leader>js", json_to_type)
	end,
}
