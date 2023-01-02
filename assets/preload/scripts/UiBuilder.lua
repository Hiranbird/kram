function onCreatePost()
    luaDebugMode = true

    bars = require('mods/'..currentModDirectory..'/scripts/modules/barsManager')
    colors = require('mods/'..currentModDirectory..'/scripts/modules/rgb-hex-converter')
    tweens = require('mods/'..currentModDirectory..'/scripts/modules/coolTweens')
    scroll = require('mods/'..currentModDirectory..'/scripts/modules/modcharts')

    bf = rgbToHex({getProperty('boyfriend.healthColorArray[0]'),getProperty('boyfriend.healthColorArray[1]'),getProperty('boyfriend.healthColorArray[2]')})
    dad = rgbToHex({getProperty('dad.healthColorArray[0]'),getProperty('dad.healthColorArray[1]'),getProperty('dad.healthColorArray[2]')})
    hp = bars:new('hp', getProperty('healthBar.x'), getProperty('healthBar.y'), getProperty('healthBar.width'), getProperty('healthBar.height'), 4)
    hp:colors(dad, bf, '000000')
    hp.inverted = true
    hp:camera('camHUD')
    hp:order(getObjectOrder('healthBar'))
    hp:setDisplay('Current Health')
    hp:toggleDisplay(true)

    time = bars:new('time', getProperty('timeBar.x'), getProperty('timeBar.y'), getProperty('timeBar.width'), getProperty('timeBar.height'), 4)
    time:colors('ffffff', '000000', '000000')
    time:camera('camHUD')
    time:order(getObjectOrder('timeBar'))
    time:toggleDisplay(true)
end
function onUpdatePost()
    if started then
        trackBars()
        modcharts:fixNotes()
        if difficulty == 0 then
            modcharts:middle(true, false)
        else
            modcharts:fused(true, true)
        end
        hp:move(getProperty('healthBar.x'), getProperty('healthBar.y'))
        for i = 0, getProperty('notes.length')-1 do
            setPropertyFromGroup('notes', i, 'copyAlpha', true)
        end
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('timeBar.visible', false)
        setProperty('timeBarBG.visible', false)

        time:property('alpha', getProperty('timeBar.alpha'))

        setProperty('timeTxt.visible', false)

        if getSongPosition() then
            timeString = ''
            curMinutes = math.floor(getSongPosition() / 60000)
            curSeconds = math.floor(getSongPosition() / 1000 - (curMinutes * 60))
            songMinutes = math.floor(songLength / 60000)
            songSeconds = math.floor(songLength / 1000 - (songMinutes * 60))
            timeString = curMinutes..':'..((curSeconds < 10) and '0'..curSeconds or curSeconds)..' / '..songMinutes..':'..((songSeconds < 10) and '0'..songSeconds or songSeconds)..' / '..songName
            time:manualDisplay(timeString)
        end
    end
end
function trackBars()
    hp:track(math.floor(getProperty('health') * 50), 100)
    time:track(getSongPosition(), songLength)
end
function onCountdownTick()
    started = true
end
function onSongStart()
    started = true
end