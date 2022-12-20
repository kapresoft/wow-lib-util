local LibStub = LibStub
local logPrefix = Kapresoft_LibUtil_Constants:CreateLogPrefix('AceLibrary')

local MAJOR,MINOR = "Kapresoft-LibUtil-AceLibrary-1.0", 1
---@class Kapresoft_LibUtil_AceLibrary
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded (this object can exist in other addons)
if not L then return end

local Names = {
    AceAddon = "AceAddon-3.0",
    AceConsole = 'AceConsole-3.0',
    AceConfig = 'AceConfig-3.0',
    AceConfigDialog = 'AceConfigDialog-3.0',
    AceDB = 'AceDB-3.0',
    AceDBOptions = 'AceDBOptions-3.0',
    AceEvent = 'AceEvent-3.0',
    AceHook = 'AceHook-3.0',
    AceGUI = 'AceGUI-3.0',
    AceLibSharedMedia = 'LibSharedMedia-3.0'
}
L.Names = Names

---@class Kapresoft_LibUtil_AceLibraryObjects
local Objects = {
    ---@type AceAddon
    AceAddon = nil,
    ---@type AceConsole
    AceConsole = nil,
    ---@type AceConfig
    AceConfig = nil,
    ---@type AceConfigDialog
    AceConfigDialog = nil,
    ---@type AceDB
    AceDB = nil,
    ---@type AceDBOptions
    AceDBOptions = nil,
    ---@type AceEvent
    AceEvent = nil,
    ---@type AceHook
    AceHook = nil,
    ---@type AceGUI
    AceGUI = nil,
    ---@type AceLibSharedMedia
    AceLibSharedMedia = nil,
}

---@type Kapresoft_LibUtil_LibFactoryMixin
local libFactory = Kapresoft_LibUtil_LibFactoryMixin():New(Names)

---@type Kapresoft_LibUtil_AceLibraryObjects
local O = libFactory:GetObjects()
L.O = O

---@return Kapresoft_LibUtil_AceLibrary
function Kapresoft_LibUtil_AceLibrary() return LibStub(MAJOR, MINOR) end
