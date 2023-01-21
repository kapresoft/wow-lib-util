--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local _, ns = ...
local O, LibStub, M = ns.Kapresoft_LibUtil:LibPack()

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_Constants
local L = LibStub:NewLibrary(M.Constants, 2)
-- return if already loaded and no upgrade necessary
if not L then return end
