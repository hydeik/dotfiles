------------------------------------------------------------------------------
-- Emacs keybindings
------------------------------------------------------------------------------

--- Utility function
local function keyCode(modifiers, key)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

--- Ctrl-j to SKK_JMODE in AquaSKK
--   keymap.conf for AquaSKK should be modified as
--   [~/Library/Application\ Support/AquaSKK/keymap.conf]
--   ...
--   SKK_JMODE               ctrl::j||ctrl::0
--   ...
--
local function aquaskkJmode()
    if hs.keycodes.currentSourceID():find('aquaskk') then
        keyCode({'ctrl'}, '0')()
    else
        keyCode({'ctrl'}, 'j')()
    end
end

--- Mimic kill-line in emacs
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

    -- Input method for Japanese
    {mods = {'ctrl'}, key = 'j', func = aquaskkJmode},
}

local emacsMarkMode = {
    {mods = {'ctrl'}, key = 'space', func = keyCode({}, 'escape')},
    {mods = {'ctrl'}, key = 'g', func = keyCode({}, 'escape')},
    {mods = {'ctrl'}, key = 'w', func = keyCode({'cmd'}, 'x')},
    {mods = {'alt'},  key = 'w', func = keyCode({'cmd'}, 'c')},
}

local function bindKeys(keymap, modal)
    for _, v in ipairs(keymap) do
        modal:bind(v.mods, v.key, v.func, nil, v.func)
    end
    return modal
end

emacsBindings = hs.hotkey.modal.new()
emacsBindings = bindKeys(emacsKeybinds, emacsBindings)

-- -- TODO: emulate mark mode (Ctrl-space)
-- markModeBindings = hs.hotkey.modal.new({'ctrl'}, 'space')
-- markModeBindings = bindKeys(emacsMarkMode, markModeBindings)
-- markModeBindings.entered = function(self)
--     markModeBindings._eventtap = hs.eventtap.new({
--         hs.eventtap.type.keyDown,
--         hs.eventtap.type.keyUp,
--     }, function(event)
--         flags = event:getFlags()
--         flags.shift = true
--         event:setFlags(flags)
--     end):start()
-- end
-- markModeBindings.exited = function(self)
--     markModeBindings._eventtap:stop()
--     markModeBindings._eventtap = nil
-- end

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
