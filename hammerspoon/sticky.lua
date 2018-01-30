-- Sticky shift
--   ;a -> A, ;1 -> !, ;; -> :, ;<space> -> ;

local function keyCode(modifiers, key)
    modifiers = modifiers or {}
    return function()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
        hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
    end
end

-- sticky key mode: use ';' as a trigger key
sticky = hs.hotkey.modal.new({}, ';')

local function remapKeyInStickyMode(key)
    sticky:bind({}, key, function()
        keyCode({'shift'}, key)
        sticky:exit()
    end)
end

-- Global keybind for ';'
hs.hotkey.bind({}, ';', function()
    if hs.keycodes.currentMethod():find('AquaSKK') then
        sticky:enter()
    else
        keyCode({}, ';')()
    end
end)

remapKeyInStickyMode('1')    -- '!'
remapKeyInStickyMode('2')    -- '@'
remapKeyInStickyMode('3')    -- '#'
remapKeyInStickyMode('4')    -- '$'
remapKeyInStickyMode('5')    -- '%'
remapKeyInStickyMode('6')    -- '^'
remapKeyInStickyMode('7')    -- '&'
remapKeyInStickyMode('8')    -- '*'
remapKeyInStickyMode('9')    -- '('
remapKeyInStickyMode('0')    -- ')'
remapKeyInStickyMode('-')    -- '_'
remapKeyInStickyMode('=')    -- '+'
remapKeyInStickyMode('`')    -- '~'
remapKeyInStickyMode('[')    -- '{'
remapKeyInStickyMode(']')    -- '}'
remapKeyInStickyMode('\\')   -- '|'
remapKeyInStickyMode(';')    -- ':'
remapKeyInStickyMode("'")    -- '"'
remapKeyInStickyMode(",")    -- '<'
remapKeyInStickyMode(".")    -- '>'
remapKeyInStickyMode("/")    -- '?'

remapKeyInStickyMode('a')
remapKeyInStickyMode('b')
remapKeyInStickyMode('c')
remapKeyInStickyMode('d')
remapKeyInStickyMode('e')
remapKeyInStickyMode('f')
remapKeyInStickyMode('g')
remapKeyInStickyMode('h')
remapKeyInStickyMode('i')
remapKeyInStickyMode('j')
remapKeyInStickyMode('k')
remapKeyInStickyMode('l')
remapKeyInStickyMode('m')
remapKeyInStickyMode('n')
remapKeyInStickyMode('o')
remapKeyInStickyMode('p')
remapKeyInStickyMode('q')
remapKeyInStickyMode('r')
remapKeyInStickyMode('s')
remapKeyInStickyMode('t')
remapKeyInStickyMode('u')
remapKeyInStickyMode('v')
remapKeyInStickyMode('w')
remapKeyInStickyMode('x')
remapKeyInStickyMode('y')
remapKeyInStickyMode('z')

