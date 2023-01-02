function onGameOver()
    openCustomSubstate('death', true)
    return Function_Stop
end
gone = false
function onCustomSubstateCreate(state)
    if state == 'death' then
        makeLuaSprite('deathbg', nil, 0, 0)
        makeGraphic('deathbg', screenWidth, screenHeight, '000000')
        setObjectCamera('deathbg', 'camOther')
        addLuaSprite('deathbg', true)

        makeLuaSprite('bf', 'ohno he fucking died', screenWidth / 2, 400)
        setObjectCamera('bf', 'camOther')
        setProperty('bf.origin.x', getProperty('bf.width') / 2)
        addLuaSprite('bf', true)
        doTweenAngle('bfFall', 'bf', -90, 0.5)
        doTweenY('bfDown', 'bf', screenHeight, 0.5)

        playSound('so sad', 1, 'he dead')
    end
end
function onCustomSubstateUpdate(state)
    if state == 'death' then
        if (not gone) then
            if keyboardJustPressed('ENTER') then
                doTweenAngle('bfGetup', 'bf', 0, 0.5)
                doTweenY('bfUp', 'bf', 400)
                gone = true
                loadSong('kramped', difficulty)
            end
            if keyboardJustPressed('BACKSPACE') then
                exitSong()
            end
        end 
    end
end
function onSoundFinished(t)
    if t == 'he dead' then
        playMusic('alexa play despacito', 1, true)
    end
end