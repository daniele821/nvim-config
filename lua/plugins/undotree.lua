return {
    'mbbill/undotree',
    config = function()
        local function toggleUndo()
            vim.cmd(':UndotreeToggle')
            vim.cmd(':UndotreeFocus')
        end
        vim.keymap.set('n','<F5>',toggleUndo)
        vim.g.undotree_WindowLayout=3
    end
}
