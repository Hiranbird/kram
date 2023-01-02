function onCreate()
    scroll = require('mods/'..currentModDirectory..'/scripts/modules/modcharts')
end
function onEvent(n, v1, v2)
    if n == 'modchart' then
        local bf
        local dad
        if (tonumber(v2) == 1) or (tonumber(v2) == 2) then
            bf = true
        end
        if (tonumber(v2) == 0) or (tonumber(v2) == 2) then
            dad = true
        end
        if v1 == 'middle' then
            modcharts:middle(bf, dad)
        end
        if v1 == 'side' then
            modcharts:side(bf, dad)
        end
        if v1 == 'fused' then
            modcharts:fused(bf, dad)
        end
    end
end