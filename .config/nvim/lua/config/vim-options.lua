vim.cmd("inoremap ¿ <esc>")
vim.cmd("vnoremap ¿ <esc>")
vim.cmd("set number")
vim.cmd("set tabstop=4")
vim.cmd("autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us,de")

-- open terminal
vim.keymap.set("n", "<C-m>", ":vertical belowright terminal<CR>i")
vim.keymap.set('t', '¿', '<C-\\><C-n>') -- keymap for exiting terminal mode

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
