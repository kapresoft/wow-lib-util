--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub = Kapresoft_LibStub

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_String : Kapresoft_LibUtil_BaseString
local L = LibStub:NewLibrary('String', 4); if not L then return end
local B = LibStub('BaseString'); if not B then return end
getmetatable(L).__index = B
