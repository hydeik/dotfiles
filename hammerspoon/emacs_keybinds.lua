local function keyCode(key, modifiers)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.timer.usleep(1000)
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

local function remapKey(modifiers, key, keyCode)
    hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function killLine()
    keyCode('e', {'shift', 'ctrl'})()
    keyCode('x', {'cmd'})()
end

local function disableAllHotkeys()
    for k, v in pairs(hs.hotkey.getHotkeys()) do
        v['_hk']:disable()
    end
end

local function enableAllHotkeys()
    for k, v in pairs(hs.hotkey.getHotkeys()) do
        v['_hk']:enable()
    end
end

local function handleGlobalAppEvent(name, event, app)
    if event == hs.application.watcher.activated then
        -- hs.alert.show(name)
        -- if name == "Microsoft Word" then
        if string.find(name, "Microsoft") then
            enableAllHotkeys()
        else
            disableAllHotkeys()
        end
    end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- Cursor move
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'a', keyCode('left',  {'cmd'}))
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))

-- Edit
remapKey({'ctrl'}, 'h', keyCode('delete')) -- backspace
remapKey({'ctrl'}, 'd', keyCode('forwarddelete')) -- delete
remapKey({'ctrl'}, 'k', killLine) -- kill-line (ctrl-k)

remapKey({'alt'},  'w', keyCode('c', {'cmd'})) -- copy
remapKey({'ctrl'}, 'w', keyCode('x', {'cmd'})) -- cut
remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'})) -- paste

-- command
remapKey({'ctrl'}, 's', keyCode('f', {'cmd'})) -- search
remapKey({'ctrl'}, '/', keyCode('z', {'cmd'})) -- undo
remapKey({'ctrl'}, 'g', keyCode('escape'))

-- Page scroll
remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'alt'},  'v', keyCode('pageup'))
remapKey({'alt', 'shift'}, ',', keyCode('home'))
remapKey({'alt', 'shift'}, '.', keyCode('end'))


