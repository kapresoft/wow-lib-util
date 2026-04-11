--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-ColorFormatter-2-0', 1

--- @class Kapresoft-ColorFormatter-2-0
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
S.mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR]  end }
setmetatable(S, S.mt)

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local o = S

--- @param hexColorRRGGBBAA HexColor |"'fc565656'"
--- @return colorRGBA
function o.ColorFromHex(hexColorRRGGBBAA)
  local color = CreateColorFromHexString(hexColorRRGGBBAA)
  assert(type(color) == 'table', 'Hex color is invalid: ' .. tostring(hexColorRRGGBBAA))
  return color
end

--- Create a new color formatter function
--- @param color colorRGBA
--- @return cfFn
function o.cf(color)
  return function(arg) return color:WrapTextInColorCode(tostring(arg)) end
end

--- Create a new color formatter function
--- @param hexColorRRGGBBAA HexColor |"'fc565656'"
--- @return cfFn, colorRGBA
function o.cfhex(hexColorRRGGBBAA)
  local color = o.ColorFromHex(hexColorRRGGBBAA)
  return function(arg) return color:WrapTextInColorCode(tostring(arg)) end, color
end
