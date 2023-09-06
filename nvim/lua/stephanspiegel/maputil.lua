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

local function map_mode(mode, opts)
    opts = opts or default_opts
    local function bind_mode(lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    return bind_mode
end

local function bind_all(bind_function)
    local function bind_keys(keybinds)
        for _, keybind in ipairs(keybinds) do
            local lhs, rhs, opts = unpack(keybind)
            bind_function(lhs, rhs, opts)
        end
    end
    return bind_keys
end

local function bind_all_mode(mode)
    return bind_all(map_mode(mode))
end

local function tmap_all(lhs, rhs, opts)
    opts = opts or terminal_opts
    bind_all_mode(t, opts)
end

return {
    map = vim.keymap.set,
    imap = map_mode('i'),
    nmap = map_mode('n'),
    vmap = map_mode('v'),
    tmap = map_mode('t', terminal_opts),
    nmap_all = bind_all_mode('n'),
    imap_all = bind_all_mode('i'),
    vmap_all = bind_all_mode('v'),
    tmap_all = tmap_all
}
