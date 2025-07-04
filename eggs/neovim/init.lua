require("config.lazy")

vim.cmd("nnoremap <Tab> :bnext<CR>")
vim.cmd("nnoremap <S-Tab> :bprevious<CR>")
-- TODO keybind to toggle normal to below bg/fg and back
-- vim.cmd("hi normal ctermbg=none guibg=none")
vim.cmd("hi LineNr guibg=#222436 guifg=#c8d3f5")
vim.cmd("hi LineNrAbove guibg=#222436 guifg=#c8d3f5")
vim.cmd("hi LineNrBelow guibg=#222436 guifg=#c8d3f5")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.wrap = false

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
