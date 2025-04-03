require("config.lazy")

---Plug('rhaiscript/vim-rhai')
---Plug('imsnif/kdl.vim')
---Plug('vim-airline/vim-airline')
---Plug('vim-airline/vim-airline-themes')

---vim.opt_global.airline_theme = 'molokai'
---vim.opt_global.airline_powerline_fonts = 1
---vim.opt_global.airline#extensions#tabline#enabled = 1
---vim.opt_global.airline#extensions#whitespace#mixed_indent_algo = 1

vim.cmd("nnoremap <Tab> :bnext<CR>")
vim.cmd("nnoremap <S-Tab> :bprevious<CR>")
-- TODO keybind to toggle normal to below bg/fg and back
vim.cmd("hi normal ctermbg=none guibg=none")
vim.cmd("hi LineNr guibg=#222436 guifg=#c8d3f5")
vim.cmd("hi LineNrAbove guibg=#222436 guifg=#c8d3f5")
vim.cmd("hi LineNrBelow guibg=#222436 guifg=#c8d3f5")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true

