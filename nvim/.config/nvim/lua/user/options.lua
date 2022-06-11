local options = {
    expandtab = true,                       -- Convert tabs to spaces
    shiftwidth = 4,                         -- The number of spaces inserted for each indentation
    tabstop = 4,                            -- Number of spaces that a <Tab> in the file counts for.
    cmdheight = 1,                          -- Number of screen lines to use for the command-line.
    hlsearch = true,                        -- Highlight when searching.
    ignorecase = true,                      -- Ignore case when searching
    mouse = "a",                            -- Allow mouse in nvim
    swapfile = false,                       -- Don't use swap file, so annoying
    number = true,                          -- Show numbers
    numberwidth = 2,                        -- The minimal width of line, set to 2
    cursorline = true,                      -- Show a line under current line.
    scrolloff = 12,                         -- Keep editing in the middle of the screen
    clipboard = "unnamedplus",              -- Allow clipboard
    showtabline = 2,                        -- Show the tabline above
    termguicolors = true,                   -- Optioins for colorschemes
    timeoutlen = 300,                       -- Mapping delays
    ttimeoutlen = 0,                        -- key code delays
    updatetime = 300,                       -- faster completion
    signcolumn = "yes",                     -- column for lsp
    pumheight = 10,                         -- popup menu height

}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd [[set iskeyword+=-]]                -- treat "-" as one word in vim
