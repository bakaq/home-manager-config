-- Handy aliases
local k = vim.keymap
local o = vim.o

-- Very magic by default
k.set("n", "/", [[/\v]])
k.set("n", "?", [[?\v]])

-- Center after page roll
k.set("n", "<C-u>", "M<C-u>zz")
k.set("n", "<C-d>", "M<C-d>zz")

-- Quickfix
k.set("n", "]q", ":cnext<CR>", { silent = true })
k.set("n", "[q", ":cprev<CR>", { silent = true})

vim.cmd [[
    " Open relevant files
    nnoremap <Leader>rc <C-w>v:edit ~/.vimrc<CR>
    nnoremap <Leader>ft <C-w>v:execute "edit ~/.vim/ftplugin/" . &filetype . ".vim"<CR>

    " Operations on whole files
    nnoremap <Leader>y mmggVG"+y`m
    nnoremap <Leader>i mmgg=G`m

    " Buffers
    nnoremap <Leader>b :ls<CR>:buffer<Space>
]]

-- Clear search highlights
k.set("n", "<C-l>", ":nohlsearch<CR>", { silent = true })

-- Toggle line wrapping
k.set("n", "<Leader>l", function()
    if o.textwidth == 0 then
        o.textwidth = 90
    else
        o.textwidth = 0
    end
end, { silent = true })


-- Toggle conceal level
k.set("n", "<Leader>l", function()
    if o.conceallevel == 0 then
        o.conceallevel = 2
    else
        o.conceallevel = 0
    end
end, { silent = true })

-- Toggle spell
k.set("n", "<Leader>s", ":set spell!<CR>", { silent = true})
