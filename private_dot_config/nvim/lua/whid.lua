-- lua/whid.lua
local api = vim.api

local function Hello()
    local pos = api.nvim_win_get_cursor(0)[2]
    local line = api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. 'hello' .. line:sub(pos + 1)
    api.nvim_set_current_line(nline)
end

local function Bye()
    local pos = api.nvim_win_get_cursor(0)[2]
    local line = api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. 'bye' .. line:sub(pos + 1)
    api.nvim_set_current_line(nline)
end

return {
    hello = Hello,
    bye = Bye
}
