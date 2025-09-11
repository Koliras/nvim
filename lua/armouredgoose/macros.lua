-- convert json field to proper Golang field
vim.fn.setreg("g", '_yiwvU:s/_\\(.\\)/\\U\\1/ge\A `json:"pa"`j')
