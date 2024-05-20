-- Hack the clipboard function on nvim startup
-- because _some_ plugin is messing up with clipboard on nvim startup
local function get_reg(char)
	-- return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true):gsub("[\n\r]", "^J")
	return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true)
end

local before = get_reg("+")
vim.opt.clipboard = "unnamedplus"
require("phorak")
vim.fn.setreg('"', before)
