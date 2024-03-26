---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jameslendrem.
--- DateTime: 24/03/2024 10:43
---

local pd <const> = playdate
local gfx <const> = pd.graphics

class("View").extends(gfx.sprite)

function View:init(content, params)

    self._defaultParams = {
        width = "auto",
        borderTopWidth = 0,
        borderBottomWidth = 0,
        borderLeftWidth = 0,
        borderRightWidth = 0,
        borderCollapse = false,
        paddingTop = 0,
        paddingLeft = 0,
        paddingBottom = 0,
        paddingRight = 0,
        marginTop = 0,
        marginLeft = 0,
        marginBottom = 0,
        marginRight = 0,
        top = 0,
        left = 0,
        color = gfx.kColorBlack,
    }

    self.params = self:inflateParams(params);
    self.content = content;

end

function View:getOuterHeight()

    local height = self:getInnerHeight();

    height = height + self.params.marginTop;
    height = height + self.params.marginBottom;

    return height;

end

function View:getOuterWidth()

    local width = self:getInnerWidth()

    width = width + self.params.marginLeft
    width = width + self.params.marginRight

    return width;

end

function View:getInnerHeight()

    local height = 0

    height = height + self.params.borderTopWidth
    height = height + self.params.borderBottomWidth
    height = height + self.params.paddingTop
    height = height + self.params.paddingBottom

    if (type(self.content) == "table") then

        if (is_array(self.content)) then

            for key, value in pairs(self.content) do
                height = height + value:getOuterHeight()
                height = height - self:getBorderCollapseOffset("vertical", key)
            end

        else
            height = height + self.content:getHeight();
        end
    end

    if (type(self.content) == "string") then
        local font <const> = gfx.getFont()
        height = height + font:getHeight()
    end

    return height
end

function View:getInnerWidth()

    local width = 0

    print("Type of Width", type(self.params.width));

    if (type(self.params.width) == "number") then
        return self.params.width;
    end

    --- do the other stuff

    width = width + self.params.borderLeftWidth
    width = width + self.params.borderRightWidth
    width = width + self.params.paddingLeft
    width = width + self.params.paddingRight

    -- Assume view for now
    if (type(self.content) == "table") then

        if (is_array(self.content)) then

            local maxWidth = 0

            for key, value in pairs(self.content) do

                local outerWidth <const> = value:getOuterWidth()

                if outerWidth > maxWidth then
                    maxWidth = outerWidth
                end

            end

            width = width + maxWidth
            -- Do stuff
        else
            width = width + self.content:getWidth();
        end

    end

    if (type(self.content) == "string") then
        local font <const> = gfx.getFont()
        width = width + font:getTextWidth(self.content)
    end

    print("Width", width)

    return width
end

function View:drawBorders()

    local width <const> = self:getInnerWidth()
    local height <const> = self:getInnerHeight()

    if (self.params.borderTopWidth > 0) then
        gfx.fillRect(0, 0, width, self.params.borderTopWidth)
    end

    if (self.params.borderBottomWidth > 0) then
        gfx.fillRect(0, height - self.params.borderBottomWidth, width, self.params.borderBottomWidth)
    end

    if (self.params.borderLeftWidth > 0) then
        gfx.fillRect(0, 0, self.params.borderLeftWidth, height)
    end

    if (self.params.borderRightWidth > 0) then
        gfx.fillRect(width - self.params.borderRightWidth, 0, width, height)
    end

end

function View:getBorderCollapseOffset(direction, key)

    if (not self.params.borderCollapse) then
        return 0
    end

    if (key == #self.content) then
        return 0
    end

    local currentBorderProperty = "borderBottomWidth"
    local nextBorderProperty = "borderTopWidth"

    if (direction == "horizontal") then
        currentBorderProperty = "borderRightWidth"
        nextBorderProperty = "borderLeftWidth"
    end

    local nextChildTopBorderWidth = self.content[key].params[nextBorderProperty]
    local smallestBorderWidth = self.params[currentBorderProperty]

    if (nextChildTopBorderWidth < smallestBorderWidth) then
        smallestBorderWidth = nextChildTopBorderWidth
    end

    return smallestBorderWidth

end

function View:setChildInnerViewWidth(isMultiple)

    if (not isMultiple) then

        if (self.content.params.width == "100%") then
            self.content:setParam("width", self:getInnerWidth())
        end

    end

    for key, value in pairs(self.content) do

        if (value.params.width == "100%") then
            self.content.setParam("width", self:getInnerWidth())
        end

    end

end

function View:drawArrayOfViews(contentPositionLeft, contentPositionTop)

    local positionX = self.params.left + self.params.borderLeftWidth + self.params.paddingLeft;
    local positionY = self.params.top + self.params.borderTopWidth + self.params.paddingTop;

    for key, value in pairs(self.content) do

        local isPercent = false
        value:setParam("top", positionY)
        value:setParam("left", positionX)

        if (value.params.width == "100%") then
            value.params.width = self:getInnerWidth() - self.params.borderLeftWidth - self.params.borderRightWidth
                - self.params.paddingLeft - self.params.paddingRight

            isPercent = true;
        end

        value:drawView()

        if (isPercent) then
            value.params.width = "100%"
        end

        positionY = positionY + value:getOuterHeight()
        positionY = positionY - self:getBorderCollapseOffset("vertical", key);

    end

end

function View:drawInnerContent()

    local contentPositionLeft = self.params.borderLeftWidth + self.params.paddingLeft;
    local contentPositionTop = self.params.borderTopWidth + self.params.paddingTop;

    if (type(self.content) == "string") then
        gfx.drawText(self.content, contentPositionLeft, contentPositionTop)
        return;
    end

    if (type(self.content) == "table") then

        if (not is_array(self.content)) then
            self.content:drawView();
        end

        self:drawArrayOfViews(contentPositionLeft, contentPositionTop)

    end

end

function View:drawView()

    local width <const> = self:getInnerWidth()
    local height <const> = self:getInnerHeight()

    local viewImage = gfx.image.new(width, height);

    gfx.pushContext(viewImage)

    self:drawBorders()
    self:drawInnerContent()

    gfx.popContext()

    local topPosition = self.params.top + self.params.marginTop
    local leftPosition = self.params.left + self.params.marginLeft

    self:setCenter(0, 0)
    self:setImage(viewImage)
    self:moveTo(leftPosition, topPosition)
    self:add()

end

function View:printParams()

    for key, value in pairs(self.params) do
        print(key, ":", value)
    end

end

function View:inflateParams(params)

    local inflatedParams = {};

    for key, value in pairs(self._defaultParams) do
        inflatedParams[key] = value;
    end

    for key, value in pairs(params) do
        inflatedParams[key] = value;
    end

    return inflatedParams;

end

function View:setParam(name, value)
    self.params[name] = value;
end

function View:getParams()
    return self.params;
end