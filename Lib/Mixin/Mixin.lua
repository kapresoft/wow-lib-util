--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub = Kapresoft_LibStub

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_Mixin : Kapresoft_LibUtil_BaseMixin
local L = LibStub:NewLibrary('Mixin', 4); if not L then return end
local B = LibStub('BaseMixin'); if not B then return end
getmetatable(L).__index = B
