function onCreatePost()
    makeLuaSprite('rooom', 'gfs 5 star apartment', 0, 0)
    scaleObject('rooom', 0.75, 0.75)
    addLuaSprite('rooom')

    setProperty('gf.visible', false)
    doTweenX('gfgo', 'gf', 1500, 0.25)
end
function onUpdate()
    scaleObject('gf', 0.75, 0.75)
    setProperty('camZooming', true)
    if getSongPosition() > 0 and curBeat > 4 then
        if mustHitSection then
            setProperty('defaultCamZoom', 0.9)
        else
            setProperty('defaultCamZoom', 1.3)
        end
    end
end
function onStepHit()
    if curStep == 1215 then
        setProperty('gf.visible', true)
        doTweenX('gfcum', 'gf', 1200, 0.5, 'linear')
        doTweenX('bfcum', 'boyfriend', 300, 0.5, 'linear')
    end
end