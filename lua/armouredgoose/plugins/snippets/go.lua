local ls = require("luasnip")

local snip = ls.snippet
local snip_n = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

return {
	snip("nerr", {
		text({ "if " }),
		i(1, "err"),
		text({ " != nil {", "\t" }),
		i(0),
		text({ "", "}" }),
	}),
}
