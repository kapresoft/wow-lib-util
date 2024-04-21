--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Name
local addon
--- @type Kapresoft_Base_Namespace
local ns
addon, ns = ...

local LibStub = LibStub
local LibUtil = ns.Kapresoft_LibUtil

--- This global var will be used by libraries for simplicity
--- @see _Init.lua#InitLazyLoaders()
--- @type Kapresoft_LibUtil_LibStub
Kapresoft_LibStub = LibUtil.LibStub

--- Note: Also add library to Kapresoft_LibUtil_Modules
--- @class Kapresoft_LibUtil_Objects
local Kapresoft_LibUtil_Objects = {
    --- @type Kapresoft_LibUtil_Constants
    Constants = {},
    --- @type Kapresoft_LibUtil_PrettyPrint
    PrettyPrint = {},
    --- @type Kapresoft_LibUtil_AceLibrary
    AceLibrary = {},
    --- @type Kapresoft_LibUtil_Assert
    Assert = {},
    --- @type Kapresoft_LibUtil_ColorUtil
    ColorUtil = {},
    --- @type Kapresoft_LibUtil_IncrementerBuilder
    Incrementer = {},
    --- @type Kapresoft_LibUtil_LuaEvaluator
    LuaEvaluator = {},
    --- @type Kapresoft_LibUtil_Mixin
    Mixin = {},
    --- @type Kapresoft_LibUtil_SequenceMixin
    SequenceMixin = {},
    --- @type Kapresoft_LibUtil_String
    String = {},
    --- @type Kapresoft_LibUtil_Table
    Table = {},
    --- @type Kapresoft_LibUtil_TimeUtil
    TimeUtil = {},
    --- @type Kapresoft_LibUtil_CategoryMixin
    CategoryMixin = {},
    --- @type Kapresoft_LibUtil_LoggerMixin
    LoggerMixin = {},
    --- @type Kapresoft_LibUtil_LibStubMixin
    LibStubMixin = {},
    --- @type Kapresoft_LibUtil_LibFactoryMixin
    LibFactoryMixin = {},
    --- @type Kapresoft_LibUtil_Safecall
    Safecall = {},

    --- @type Kapresoft_LibUtil_NamespaceAceLibraryMixin
    NamespaceAceLibraryMixin = {},
    --- @type Kapresoft_LibUtil_NamespaceKapresoftLibMixin
    NamespaceKapresoftLibMixin = {},
}

--- Note: Also add library to Kapresoft_LibUtil_Objects
--- @class Kapresoft_LibUtil_Modules
local M = {
    Constants = '',
    AceLibrary = '',
    Assert = '',
    ColorUtil = '',
    Incrementer = '',
    Mixin = '',
    String = '',
    Table = '',
    TimeUtil = '',
    LoggerMixin = '',
    CategoryMixin = '',
    Safecall = '',
    SequenceMixin = '',
    PrettyPrint = '',
    AceLibrary = '',
    LuaEvaluator = '',
    LibFactoryMixin = '',
    LibStubMixin = '',
    NamespaceAceLibraryMixin = '',
    NamespaceKapresoftLibMixin = '',
}; for module, _ in pairs(M) do M[module] = module end

LibUtil.M = M
local function Lib(moduleName) return LibUtil:Lib(moduleName) end

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
--- README: Increment the minor version whenever a library is added
--- @class Kapresoft_LibUtil_Library
local L = LibStub:NewLibrary(LibUtil:Lib('Library'), 8); if not L then return end

L.Names = {}
for _, module in pairs(M) do L.Names[module] = Lib(module) end

--[[-----------------------------------------------------------------------------
Namespace Objects
-------------------------------------------------------------------------------]]
---@type Kapresoft_LibUtil_LibFactoryMixin
local LibFactoryMixin = LibStub(Lib(M.LibFactoryMixin))
local libFactory = LibFactoryMixin:New(L.Names)
--- @type Kapresoft_LibUtil_Objects
L.Objects = libFactory:GetObjects()
