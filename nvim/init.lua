-- TODO: stop depending on .vimrc
--[[
vim.cmd [[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]]
--]]

require"general-config"
require"mappings"
require"plugins"
require"highlighting"
