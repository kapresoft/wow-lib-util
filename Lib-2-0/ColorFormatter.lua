--[[-----------------------------------------------------------------------------
DEPENDENCIES:
-------------------------------------------------------------------------------]]
local CreateColorFromHexString = CreateColorFromHexString
local CreateColorFromRGBAHexString = CreateColorFromRGBAHexString
local CreateColorFromRGBHexString = CreateColorFromRGBHexString

--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version

-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-ColorFormatter-2-0', 1

--- @class Kapresoft-ColorFormatter-2-0
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
local mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR]  end }
setmetatable(S, mt)

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local o = S

o.COLOR_FORMAT_RGBA = "RRGGBBAA";
o.COLOR_FORMAT_RGB = "RRGGBB";
o.COLOR_FORMAT_ARGB = "AARRGGBB";

--- Create a new color formatter function.
--- @param color colorRGBA|HexRGBA|HexRGB|HexRGBA | 'RED_THREAT_COLOR' | '565656fc' | '565656' | 'fc565656'
--- @return cfFn, colorRGBA?
function o:ColorFn(color)
  assertsafe(color, "ColorFormatter:ColorFn(color): The function arg color is a required field, but was [%s]", tostring(color))
  local c = color
  if type(c) == 'string' then c = self:ColorFromHex(color) end
  assertsafe(color, "ColorFormatter:ColorFn(color): Could not resolve color from [%s], type=[%]", tostring(c), type(c))
  return function(arg) return c:WrapTextInColorCode(tostring(arg)) end
end

--- @param hexColorRBA HexRGBA|HexRGB|HexARGB | '565656fc' | '565656' | 'fc565656'
--- @return colorRGBA
function o:ColorFromHex(hexColorRBA)
  assertsafe(hexColorRBA, "ColorFromHex:hexColor): {hexColor} should be a string, but was [%s]",
    type(hexColorRBA))
  local color = self:_ColorFromHexARGB(hexColorRBA)
  tr('ColorFromHex', 'str=', hexColorRBA, 'color=color')
  if not color then
    color = self:_ColorFromHexRGB(hexColorRBA)
    tr('ColorFromHex(ARGB|', 'str=', hexColorRBA, 'color=color')
  end
  assert(type(color) == 'table', 'ColorFromHex:hexColor): {hexColor} is invalid: ' .. tostring(hexColorRBA))
  return color
end

--- @private
--- @param hexColorARGB HexARGB | 'fc565656'
function o:_ColorFromHexARGB(hexColorARGB)
	return CreateColorFromHexString(hexColorARGB);
end

--- @private
--- @param hexColor HexRGBA|HexRGB | '565656fc' | '565656'
--- @return colorRGBA?
function o:_ColorFromHexRGB(hexColor)
	if #hexColor == #COLOR_FORMAT_RGBA then
		return CreateColorFromRGBAHexString(hexColor);
	elseif #hexColor == #COLOR_FORMAT_RGB then
		return CreateColorFromRGBHexString(hexColor);
	end
	assertsafe(false, "CreateColorFromBestRGBHexString input must be hexadecimal digits in either of these formats: %s / %s", COLOR_FORMAT_RGBA, COLOR_FORMAT_RGB);
	return nil;
end
