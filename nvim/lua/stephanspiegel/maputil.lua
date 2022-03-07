-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

local default_opts = { noremap = true, silent = true }
local terminal_opts = { silent = true }

local function map(mode, shortcut, command, opts)
    opts = opts or default_opts
    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
    map('n', shortcut, command, opts)
end

local function imap(shortcut, command, opts)
    map('i', shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
    map('v', shortcut, command, opts)
end

local function tmap(shortcut, command, opts)
    opts = opts or terminal_opts
    vim.api.nvim_set_keymap('t', shortcut, command, opts)
end

local function bind_all(bind_function)
    local function bind_keys(keybinds)
        for _, keybind in ipairs(keybinds) do
            local shortcut, command, opts = unpack(keybind)
            bind_function(shortcut, command, opts)
        end
    end
    return bind_keys
end

return {
    map = map,
    imap = imap,
    nmap = nmap,
    vmap = vmap,
    tmap = tmap,
    nmap_all = bind_all(nmap),
    imap_all = bind_all(imap),
    vmap_all = bind_all(vmap),
    tmap_all = bind_all(tmap)
}
