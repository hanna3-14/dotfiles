vim.cmd("inoremap ¿ <esc>")
vim.cmd("vnoremap ¿ <esc>")
vim.cmd("set number")
vim.cmd("autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us")

-- open terminal
vim.keymap.set("n", "<C-m>", ":vertical belowright terminal<CR>i")
vim.keymap.set('t', '¿', '<C-\\><C-n>') -- keymap for exiting terminal mode

vim.keymap.set("n", "<C-r>", ":MarkdownPreviewToggle<CR>")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
