if vim.g.vscode then
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap('n', '<leader>e', "<Cmd>lua require('vscode').action('workbench.view.explorer')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>w', "<Cmd>lua require('vscode').action('workbench.action.files.save')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>x', "<Cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ff', "<Cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>c', "<Cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>l', "<Cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>h', "<Cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>", { noremap = true, silent = true })
end