vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nord_borders = true

options = {
    nu = true,
    relativenumber = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    wrap = false,
    swapfile = false,
    backup = false,
    incsearch = true,
    scrolloff = 8,
    termguicolors = true,
}

for option, value in pairs(options) do
    vim.opt[option] = value
end
