--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_LibUtil
local LibUtil = select(2, ...).Kapresoft_LibUtil

--[[-----------------------------------------------------------------------------
New Instance
LibStub Example:
local o = LibStub('Kapresoft-LibUtil-AddonUtil-1.0')
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_AddonUtil : Kapresoft_AddonUtil
local W = LibUtil:CreateLibWrapper('AddonUtil', 1, 'Kapresoft-AddonUtil-1.0')
