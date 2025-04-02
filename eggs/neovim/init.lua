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
vim.cmd("hi normal ctermbg=none guibg=none")
vim.cmd("hi linenr ctermbg=none")
vim.cmd("hi nontext ctermbg=none guibg=none")


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true

