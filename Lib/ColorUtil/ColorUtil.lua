--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local ns = select(2, ...)
local sformat = string.format

--- @type LibStub
local LibStub = LibStub

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local MAJOR_VERSION = 'Kapresoft-ColorUtil-1.0'
--- @class Kapresoft_ColorUtil
local L = LibStub:NewLibrary(MAJOR_VERSION, 1); if not L then return end
L.mt = { __tostring = function() return MAJOR_VERSION .. '.' .. LibStub.minors[MAJOR_VERSION]  end }
setmetatable(L, L.mt)

--- @class ColorUtilMixin : Color
local ColorUtilMixin = {}
--- @param o ColorUtilMixin
local function ColorUtilMixin_Methods(o)

    ---@param color Color
    function o:Init(color)
        assert(color, 'Init(): Color is required.')
        self.color = color
    end

    --- Formatter
    --- @return fun(arg:any) : string The string wrapped in color code
    function o:f()
        return function(arg) return self.color:WrapTextInColorCode(tostring(arg)) end
    end

end; ColorUtilMixin_Methods(ColorUtilMixin)


--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
--- @param o Kapresoft_ColorUtil
local function PropsAndMethods(o)

    --- @param RRGGBBAA HexColor | "'fc565656'"
    --- @return ColorUtilMixin
    function o:NewColorFromHex(RRGGBBAA)
        --- @type Color
        local c = CreateColorFromRGBAHexString(RRGGBBAA)
        return CreateAndInitFromMixin(ColorUtilMixin, c)
    end

    --- @param color Color | "BLUE_FONT_COLOR"
    --- @return ColorUtilMixin
    function o:NewColor(color)
        --- @type Color
        return CreateAndInitFromMixin(ColorUtilMixin, color)
    end

    --- @param r RGBColor 0.0 to 1.0
    --- @param g RGBColor 0.0 to 1.0
    --- @param b RGBColor 0.0 to 1.0
    --- @param a Alpha|nil 0.0 to 1.0
    --- @return fun(arg:any) : string The string wrapped in color code
    function o:NewFormatterFromRGB(r, g, b, a)
        local color = CreateColor(r, g, b, a)
        return function(arg) return color:WrapTextInColorCode(tostring(arg)) end
    end

    --- @param RRGGBBAA HexColor | "'fc565656'"
    --- @return fun(arg:any) : string The string wrapped in color code
    function o:NewFormatterFromHex(RRGGBBAA)
        local color = self:NewColorFromHex(RRGGBBAA)
        --- @param arg any
        --- @return fun(arg:any) : string The string wrapped in color code
        return function(arg) return color:WrapTextInColorCode(tostring(arg)) end
    end

    --- @param color Color
    --- @return fun(arg:any) : string The string wrapped in color code
    function o:NewFormatterFromColor(color)
        --- @param arg any
        return function(arg) return color:WrapTextInColorCode(tostring(arg)) end
    end

end; PropsAndMethods(L)
