require('options')
require('plugins')
require('theme')

if not vim.g.vscode then
    require('nvim-tree').setup()
    local nvim_tree_events = require('nvim-tree.events')
    local bufferline_api = require('bufferline.api')

    local function get_tree_size()
      return require'nvim-tree.view'.View.width
    end

    nvim_tree_events.subscribe('TreeOpen', function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('Resize', function()
      bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('TreeClose', function()
      bufferline_api.set_offset(0)
    end)

    require('lualine').setup()

end

local utils = require('utils.selection')

leaders = {'\\', ' '}

for i, leader in ipairs(leaders) do
    vim.g.mapleader = leader 

    if not vim.g.vscode then
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<cr>') -- Open file tree

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Search all files
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})  -- Perform a live grep
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})    -- Search through all open buffers
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})  -- Search through the help documentation
    end

    -- NAVIGATION
    vim.keymap.set('n', '<leader>h', '<C-w>h') -- Move to window LEFT
    vim.keymap.set('n', '<leader>j', '<C-w>j') -- Move to window DOWN
    vim.keymap.set('n', '<leader>k', '<C-w>k') -- Move to window UP
    vim.keymap.set('n', '<leader>l', '<C-w>l') -- Move to window RIGHT

    vim.keymap.set('v', '<leader>rev', utils.reverseLines) -- Reverse order of selected lines

    vim.keymap.set('v', '<leader>up', 'gU') -- Make selection uppercase
    vim.keymap.set('v', '<leader>lo', 'gu') -- Make selection lowercase
end

-- Auto close nvimtree when last buffer is closed
-- TODO: make it play nice with barbar. If multiple buffers are open as tabs,
--       then this function should NOT close nvim.
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
  end
})



