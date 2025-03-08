local ls = require("luasnip")

local snip = ls.snippet
local snip_n = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

return {
	snip("fn", {
		i(1, "foo"),
		text({ " :: proc(" }),
		i(2),
		text({ ") " }),
		c(3, { snip_n(nil, { text("-> "), i(1, "int"), text(" ") }), text("") }),
		text({ "{", "\t" }),
		i(0),
		text({ "", "}" }),
	}),
}
