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

local nmap = map_mode('n')
local imap = map_mode('i')
local vmap = map_mode('v')
local tmap = map_mode('t', terminal_opts)

local function bind_all(bind_function)
    local function bind_keys(keybinds)
        for _, keybind in ipairs(keybinds) do
            local lhs, rhs, opts = unpack(keybind)
            bind_function(lhs, rhs, opts)
        end
    end
    return bind_keys
end

return {
    map = vim.keymap.set,
    imap = imap,
    nmap = nmap,
    vmap = vmap,
    tmap = tmap,
    nmap_all = bind_all(nmap),
    imap_all = bind_all(imap),
    vmap_all = bind_all(vmap),
    tmap_all = bind_all(tmap)
}
