-- Handy Aliases
local o = vim.o
local g = vim.g

-- Basic config
o.number = true
o.relativenumber = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.splitright = true

-- Leaders 
vim.keymap.set("n", "<Space>", "<nop>")
g.mapleader = " "
g.maplocalleader = [[\]]

-- Text width
--o.textwidth = 90
o.colorcolumn = "100"
o.breakindent = true
o.showbreak = "➥"
o.linebreak = true

-- Command aliases
vim.cmd [[
    command W w
    command Q q
    command Wq wq
    command WQ wq
]]

-- Fold
o.foldmethod = "syntax"
o.foldlevel = 10

-- Netrw
g.netrw_banner = 0
g.netrw_liststyle = 3

-- Turn off arrows
vim.keymap.set({"n", "i"}, "<Left>", "<nop>")
vim.keymap.set({"n", "i"}, "<Right>", "<nop>")
vim.keymap.set({"n", "i"}, "<Up>", "<nop>")
vim.keymap.set({"n", "i"}, "<Down>", "<nop>")

-- Disable mouse
o.mouse = ""

-- Disable preview
o.completeopt = "menu"

-- Language specific
-- TODO: Figure out if I need this given I have Treesitter and LSP
g.fortran_free_source = 1
g.fortran_do_enddo = 1
g.asmsyntax = "nasm"
--g.rust_fold = 1
g.tex_fold_enabled = 1
g.tex_flavor = "latex"
g.zig_fmt_autosave = 0

-- Spell
o.spelllang = "pt"
