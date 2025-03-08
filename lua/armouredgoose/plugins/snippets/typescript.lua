local ls = require("luasnip")

local snip = ls.snippet
local snip_n = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

return {
	snip("fn", {
		text({ "function " }),
		i(1, "foo"),
		text("("),
		i(2),
		text({ "): " }),
		i(3, "void"),
		text({ " {", "\t" }),
		i(0),
		text({ "", "}" }),
	}),
	snip("afn", {
		text({ "async function " }),
		i(1, "foo"),
		text("("),
		i(2),
		text({ "): Promise<" }),
		i(3, "void"),
		text({ "> {", "\t" }),
		i(0),
		text({ "", "}" }),
	}),
	snip("tc", {
		text({ "try {", "\t" }),
		i(1),
		text({ "", "} catch(err: any) {", "\t" }),
		i(0),
		text({ "", "}" }),
	}),
	snip("fetch", {
		text({ "fetch(" }),
		c(1, {
			i(1, "url"),
			snip_n(nil, {
				i(1, "url"),
				text({ ", {", '\tmethod: "' }),
				i(2, "POST"),
				text({ '",', "\theaders: {", '\t\tAccept: "' }),
				i(3, "application/json"),
				text({ '",', "\t},", "}" }),
			}),
		}),
		text({ ")" }),
	}),
}
