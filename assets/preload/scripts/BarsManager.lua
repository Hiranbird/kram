return {
    bars={},
    barThing = {
        inverted = function(self, inverted)
            self['inverted'] = inverted
        end,
        vertical = function(self, vertical)
            self['vertical'] = vertical
        end,
        colors = function(self, main, bg, border)
            if not (main == nil or main == '') then
                setProperty(self.name..'-Bar.color', getColorFromHex(main))
                self['barColor'] = main
            end
            if not (bg == nil or bg == '') then
                setProperty(self.name..'-BarBG.color', getColorFromHex(bg))
                self['bgColor'] = bg
            end
            if not (border == nil or border == '') then
                setProperty(self.name..'-BarB.color', getColorFromHex(border))
                self['bColor'] = border
            end
        end,
        camera = function(self, camera)
            setObjectCamera(self.name..'-BarB', camera)
            setObjectCamera(self.name..'-BarBG', camera)
            setObjectCamera(self.name..'-Bar', camera)
            if self['isDisplaying'] then
                setObjectCamera(self.name..'-Display', camera)
                if camera == 'camGame' then
                    setProperty(self.name..'-Display.scrollFactor.y', 1)
                    setProperty(self.name..'-Display.scrollFactor.x', 1)
                else
                    setProperty(self.name..'-Display.scrollFactor.y', 0)
                    setProperty(self.name..'-Display.scrollFactor.x', 0)
                end
            end
            self['cameras'] = camera
        end,
        track = function(self,variable, max)
            self['curValue'] = variable
            self['maxValue'] = max
            setProperty(self.name..'-Bar.scale.x')
            setProperty(self.name..'-Bar.scale.'..((self['vertical'] == false) and 'x' or 'y'), ((self['inverted'] == false) and variable / max or 1 - (variable/max)))
            if getProperty(self.name..'-Bar.scale.x') > 1 then
                setProperty(self.name..'-Bar.scale.x', 1)
            end
            if getProperty(self.name..'-Bar.scale.x') < 0 then
                setProperty(self.name..'-Bar.scale.x', 0)
            end
            if getProperty(self.name..'-Bar.scale.y') > 1 then
                setProperty(self.name..'-Bar.scale.y', 1)
            end
            if getProperty(self.name..'-Bar.scale.y') < 0 then
                setProperty(self.name..'-Bar.scale.y', 0)
            end
            if self['curValue'] > self['maxValue'] then
                self['curValue'] = self['maxValue']
            end
            if self['isDisplaying'] then
                setTextString(self.name..'-Display', self['display']..': '..self['curValue']..'/'..self['maxValue'])
            end
        end,
        order = function(self, order)
            setObjectOrder(self.name..'-BarB', order)
            setObjectOrder(self.name..'-BarBG', order)
            setObjectOrder(self.name..'-Bar', order)
            if self['isDisplaying'] then
                setObjectOrder(self.name..'-Display', order)
            end
        end,
        setDisplay = function(self, display)
            self['display'] = display
        end,
        toggleDisplay = function(self, on, color)
            if on then
                makeLuaText(self.name..'-Display', self['display']..': '..self['curValue']..'/'..self['maxValue'], getProperty(self.name..'-BarB.width'), getProperty(self.name..'-BarB.x'), getProperty(self.name..'-BarB.y') + (getProperty(self.name..'-BarB.height') / 2) - 12)
                setTextAlignment(self.name..'-Display', 'center')
                addLuaText(self.name..'-Display')
                if not (color == nil or color == '') then
                    setTextColor(self.name..'-Display', getColorFromHex(color))
                end
            else
                if self['isDisplaying'] then
                    removeLuaText(self.name..'-Display')
                end
            end
            self['isDisplaying'] = on
            setObjectCamera(self.name..'-Display', self['cameras'])
            if self['cameras'] == 'camGame' then
                setProperty(self.name..'-Display.scrollFactor.y', 1)
                setProperty(self.name..'-Display.scrollFactor.x', 1)
            end
        end,
        move = function(self, x, y)
            if type(x) == 'number' then
                setProperty(self.name..'-BarB.x', x - self['borderSize'])
                setProperty(self.name..'-BarBG.x', x)
                setProperty(self.name..'-Bar.x', x)
                if self['isDisplaying'] then
                    setProperty(self.name..'-Display.x', getProperty(self.name..'-BarB.x'))
                    setProperty(self.name..'-Display.y', getProperty(self.name..'-BarB.y') + (getProperty(self.name..'-BarB.height') / 2) - 11)
                end
                self['xPos'] = x
            end
            if type(y) == 'number' then
                setProperty(self.name..'-BarB.y', y - self['borderSize'])
                setProperty(self.name..'-BarBG.y', y)
                setProperty(self.name..'-Bar.y', y)
                if self['isDisplaying'] then
                    setProperty(self.name..'-Display.y', getProperty(self.name..'-BarB.y'))
                end
                self['yPos'] = y
            end
        end,
        --[[resize = function(self, x, y)
            self['modifX'] = x
            self['modifY'] = y
            if self['isDisplaying'] then
                makeLuaText(self.name..'-Display', self['display']..': '..self['curValue']..'/'..self['maxValue'], getProperty(self.name..'-BarB.width'), getProperty(self.name..'-BarB.x'), getProperty(self.name..'-BarB.y') + (getProperty(self.name..'-BarB.height') / 2) - 12)
                setTextAlignment(self.name..'-Display', 'center')
                addLuaText(self.name..'-Display')
            end
            self:track(self['curValue'], self['maxValue'])
        end,]]
        property = function(self, property, value)
            setProperty(self.name..'-Bar.'..property, value)
            setProperty(self.name..'-BarB.'..property, value)
            setProperty(self.name..'-BarBG.'..property, value)
            if self['isDisplaying'] then
                setProperty(self.name..'-Display.'..property, value)
            end
        end,
        manualDisplay = function(self, string)
            if self['isDisplaying'] then
                setTextString(self.name..'-Display', string)
            end
        end
    },
    new = function(self,tag, x, y, width, height, border)
        makeLuaSprite(tag..'-BarB', nil, x - border, y - border)
        makeLuaSprite(tag..'-BarBG', nil, x, y)
        makeLuaSprite(tag..'-Bar', nil, x, y)
        
        makeGraphic(tag..'-BarB', width + (border * 2), height + (border * 2), 'ffffff')
        makeGraphic(tag..'-BarBG', width, height, 'ffffff')
        makeGraphic(tag..'-Bar', width, height, 'ffffff')

        setProperty(tag..'-BarB.origin.x', 0)
        setProperty(tag..'-BarBG.origin.x', 0)
        setProperty(tag..'-Bar.origin.x', 0)
        setProperty(tag..'-BarB.origin.y', 0)
        setProperty(tag..'-BarBG.origin.y', 0)
        setProperty(tag..'-Bar.origin.y', 0)

        addLuaSprite(tag..'-BarB')
        addLuaSprite(tag..'-BarBG')
        addLuaSprite(tag..'-Bar')

        self.bars[tag] = {
            ['name'] = tag,
            ['inverted'] = false,
            ['vertical'] = false,
            ['display'] = '',
            ['curValue'] = 0,
            ['maxValue'] = 1,
            ['isDisplaying'] = false,
            ['cameras'] = 'camGame',
            ['borderSize'] = border,
            ['barColor'] = 'ffffff',
            ['bgColor'] = 'ffffff',
            ['bColor'] = 'ffffff',
            ['xPos'] = x,
            ['yPos'] = y,
            ['modifX'] = 1,
            ['modifY'] = 1
        }
        setmetatable(self.bars[tag],{__index=self.barThing})
        return self.bars[tag]
    end,
}

