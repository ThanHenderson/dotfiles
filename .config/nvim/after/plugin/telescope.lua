local nnoremap = function(cmd, func) vim.keymap.set('n', cmd, func) end

nnoremap('<leader>s', function() 
    require('telescope.builtin').grep_string({ search = vim.fn.input('Search: ') }) 
end)
nnoremap('<leader>ff', function() 
    require('telescope.builtin').find_files() 
end)
nnoremap('<leader>fb', function() 
    require('telescope').extensions.file_browser.file_browser() 
end)

    
