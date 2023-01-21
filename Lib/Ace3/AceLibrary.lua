--- @type Kapresoft_Base_Namespace
local _, ns = ...
local O, LibStub, M, pformat, LibUtil = ns.Kapresoft_LibUtil:LibPack()

local ModuleName = M.AceLibrary
local logPrefix = LibUtil.H:CreateLogPrefix(ModuleName)

---@class Kapresoft_LibUtil_AceLibrary
local L = LibStub:NewLibrary(ModuleName, 2)
-- return if already loaded (this object can exist in other addons)
if not L then return end

L.Names = {
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

---@type Kapresoft_LibUtil_LibFactoryMixin
local LibFactoryMixin = LibStub('LibFactoryMixin')
local libFactory = LibFactoryMixin:New(L.Names)

L.O = libFactory:GetObjects()
