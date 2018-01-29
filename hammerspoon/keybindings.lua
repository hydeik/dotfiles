------------------------------------------------------------------------------
-- Emacs keybindings
------------------------------------------------------------------------------

local function keyCode(modifiers, key)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

local function killLine()
    keyCode({'shift', 'ctrl'}, 'e')()
    keyCode({'cmd'}, 'x')()
end

local emacsKeybinds = {
    -- Cursor move
    {mods = {'ctrl'}, key = 'b', func = keyCode({}, 'left')},
    {mods = {'ctrl'}, key = 'f', func = keyCode({}, 'right')},
    {mods = {'ctrl'}, key = 'p', func = keyCode({}, 'up')},
    {mods = {'ctrl'}, key = 'n', func = keyCode({}, 'down')},

    -- Jump to beggining/enf of line
    {mods = {'ctrl'}, key = 'a', func = keyCode({'cmd'}, 'left')},
    {mods = {'ctrl'}, key = 'e', func = keyCode({'cmd'}, 'right')},

    -- Jump to the beggining/end of documents
    {mods = {'alt', 'shift'}, key = ',', func = keyCode({}, 'home')},
    {mods = {'alt', 'shift'}, key = '.', func = keyCode({}, 'end')},

    -- Page scroll
    {mods = {'ctrl'}, key = 'v', func = keyCode({}, 'pagedown')},
    {mods = {'alt'},  key = 'v', func = keyCode({}, 'pageup')},

    -- Delete / backspace
    {mods = {'ctrl'}, key = 'd', func = keyCode({}, 'forwarddelete')},
    {mods = {'ctrl'}, key = 'h', func = keyCode({}, 'delete')},

    -- Kill line
    {mods = {'ctrl'}, key = 'k', func = killLine},

    -- Copy
    {mods = {'ctrl'}, key = 'w', func = keyCode({'cmd'}, 'x')},
    {mods = {'alt'},  key = 'w', func = keyCode({'cmd'}, 'c')},

    -- Paste
    {mods = {'ctrl'}, key = 'y', func = keyCode({'cmd'}, 'v')},
    {mods = {'alt'},  key = 'y', func = keyCode({'ctrl', 'cmd'}, 'v')},

    -- Undo
    {mods = {'ctrl'}, key = '/', func = keyCode({'cmd'}, 'z')},

    -- Search
    {mods = {'ctrl'}, key = 's', func = keyCode({'cmd'}, 'f')},

    -- Escape
    {mods = {'ctrl'}, key = 'g', func = keyCode({}, 'escape')},
}

-- emacsMarkMode = hs.hotkey.modal({'ctrl'}, 'space')
-- emacsMarkMode:entered() = 

local function bindKeys(keymap, modal)
    for _, v in ipairs(keymap) do
        modal:bind(v.mods, v.key, v.func, nil, v.func)
    end
    return modal
end

emacsBindings = hs.hotkey.modal.new()
emacsBindings = bindKeys(emacsKeybinds, emacsBindings)

-- Enable emacs keybindings on Microsoft Office
wf_office = hs.window.filter.new({'Microsoft Word', 'Microsoft Excel', 'Microsoft PowerPoint'})
wf_office:subscribe(hs.window.filter.windowFocused,
    function() 
        emacsBindings:enter()
    end)
wf_office:subscribe(hs.window.filter.windowUnfocused,
    function() 
        emacsBindings:exit()
    end)
