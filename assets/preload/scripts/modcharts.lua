modcharts = {}
angles = {}
alphas = {}
mode = ''
function modcharts:side(bf, dad)
    for i = 4, 7 do
        setPropertyFromGroup('playerStrums', i-4, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, (bf and 0 or 90), 0.25)
        noteTweenY('scrollup'..i, i, (screenHeight / 2) - (110 * ((i - 4) - 1)), 0.25)
        noteTweenX('scrollleft'..i, i, (bf and screenWidth -110 or screenWidth), 0.25)
        angles[i+1] = -90
    end
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, (dad and -180 or 0), 0.25)
        noteTweenY('scrollup'..i, i, (screenHeight / 2) - (110 * (i - 1)), 0.25)
        noteTweenX('scrollleft'..i, i, (dad and 0 or -250), 0.25)
        angles[i+1] = 90
        alphas[i] = (bf and 0.2 or 1)
    end
    mode = 'side'
end
function modcharts:middle(bf, dad)
    for i = 4, 7 do
        setPropertyFromGroup('playerStrums', i-4, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, (bf and 90 or -90), 0.25)
        noteTweenY('scrollup'..i, i, (bf and screenHeight - 110 - 50 or screenHeight + 250), 0.25)
        noteTweenX('scrollleft'..i, i, screenWidth / 2 + (110 * ((i - 4) - 2)), 0.25)
        angles[i+1] = 0
    end
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, -90, 0.25)
        noteTweenY('scrollup'..i, i, (dad and 50 or screenHeight), 0.25)
        noteTweenX('scrollleft'..i, i, screenWidth / 2 + (110 * (i - 2)), 0.25)
        angles[i+1] = 180
        alphas[i] = ((bf == true) and 0.2 or 1)
    end
    setProperty('timeBar.x', 0)
    mode = 'middle'
end
function modcharts:fused(bf, dad)
    for i = 4, 7 do
        setPropertyFromGroup('playerStrums', i-4, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, (bf and (90 + 45) or -90), 0.25)
        noteTweenY('scrollup'..i, i, (bf and screenHeight - 110 - 50 or screenHeight + 250), 0.25)
        noteTweenX('scrollleft'..i, i, screenWidth / 2 + (110 * ((i - 4) - 2)), 0.25)
        angles[i] = 45
    end
    for i = 0, 3 do
        setPropertyFromGroup('opponentStrums', i, 'downScroll', true)
        noteTweenDirection('scroll'..i, i, (dad and (90 - 45) or 90), 0.25)
        noteTweenY('scrollup'..i, i, (dad and screenHeight - 110 - 50 or screenHeight + 250), 0.25)
        noteTweenX('scrollleft'..i, i, screenWidth / 2 + (110 * (i - 2)), 0.25)
        angles[i] = -45
        alphas[i] = 1
    end
    mode = 'fused'
end
function modcharts:fixNotes()
    for i = 0, getProperty('notes.length')-1 do
        nd = getPropertyFromGroup('notes', i, 'noteData')
        setPropertyFromGroup('notes', i, 'angle', 0)
        if getPropertyFromGroup('notes', i, 'isSustainNote') then
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'angle', angles[nd + 4])
            else
                setPropertyFromGroup('notes', i, 'angle', angles[nd])
            end
        end
    end
end
return modcharts