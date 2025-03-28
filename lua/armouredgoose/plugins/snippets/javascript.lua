local ls = require("luasnip")

local snip = ls.snippet
local snip_n = ls.snippet_node
local text = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

local function copy(args)
	return args[1]
end

return {
	snip("resok", {
		text({ "if (!" }),
		i(1, "response"),
		text({ ".ok) {", "\tthrow new Error(" }),
		f(copy, 1),
		text({ ".statusText)", "}" }),
	}),
	snip("fetch", {
		text({ "await fetch(" }),
		c(1, {
			i(1, "url"),
			snip_n(1, {
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
	snip("fc", {
		text({ "await fetch(" }),
		c(1, {
			i(1, "url"),
			snip_n(1, {
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
