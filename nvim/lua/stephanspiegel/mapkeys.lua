-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

local opts = { noremap = true, silent = true }
local terminal_opts = { silent = true }

local function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, opts)
end

local function nmap(shortcut, command)
    map('n', shortcut, command)
end

local function imap(shortcut, command)
    map('i', shortcut, command)
end

local function vmap(shortcut, command)
    map('v', shortcut, command)
end

local function tmap(shortcut, command)
    vim.api.nvim_set_keymap('t', shortcut, command, terminal_opts)
end

local function bind_all(bind_function)
    local function bind_keys(keybinds)
        for _, keybind in ipairs(keybinds) do
            local shortcut, command = unpack(keybind)
            bind_function(shortcut, command)
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
