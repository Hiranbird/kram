function strumTweenX(tag, isBF, x, duration, ease)
    for i = 0, 3 do
      noteTweenX(tag..i, (isBF and i+4 or i), x + (110 * (i - 2)), duration, ease)
    end
end
function strumTweenY(tag, isBF, y, duration, ease)
    for i = 0, 3 do
      noteTweenY(tag..i, (isBF and i+4 or i), y, duration, ease)
    end
end
function strumTweenAlpha(tag, isBF, alpha, duration, ease)
    for i = 0, 3 do
      noteTweenAlpha(tag..i, (isBF and i+4 or i), alpha, duration, ease)
    end
end