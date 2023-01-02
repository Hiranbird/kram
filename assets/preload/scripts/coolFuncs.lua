local CFuncs = {}
function CFuncs:getCurModDir()
    return ((currentModDirectory == '') and '' or currentModDirectory..'/')
end
function CFuncs:setOnLuas(name, value)
    runHaxeCode([[
        game.setOnLuas(']]..name..[[', value)
    ]])
end