-- Hit command+q twice to quit an application
local quitModal = hs.hotkey.modal.new('cmd','q')

function quitModal:entered()
    -- hs.alert.show("Press Cmd+Q again to quit", 1)
    hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function killApp()
    hs.console.printStyledtext('killApp')
    hs.application.frontmostApplication():kill()
    quitModal:exit()
end

quitModal:bind('cmd', 'q', killApp)
quitModal:bind('', 'escape', function() quitModal:exit() end)
