nnoremap <leader>s <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Search: ") })<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
