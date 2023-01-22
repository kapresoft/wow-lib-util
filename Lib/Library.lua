--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local addon, ns = ...
local LibStub = LibStub
local LibUtil = ns.Kapresoft_LibUtil

--- @class Kapresoft_LibUtil_Modules
local M = {
    Constants = 'Constants',

    AceLibrary = 'AceLibrary',
    Assert = 'Assert',
    Incrementer = 'Incrementer',
    Mixin = 'Mixin',
    String = 'String',
    Table = 'Table',
    PrettyPrint = 'PrettyPrint',
    AceLibrary = 'AceLibrary',
    LuaEvaluator = 'LuaEvaluator',
    LibFactoryMixin = 'LibFactoryMixin',
    LibStubMixin = 'LibStubMixin',
}
LibUtil.M = M
local function Lib(moduleName) return LibUtil:Lib(moduleName) end

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_Library
local L = LibStub:NewLibrary(LibUtil:Lib('Library'), 2)
-- return if already loaded and no upgrade necessary
if not L then return end

L.libPrefix = LibUtil.libPrefix

L.Names = {
    Constants = Lib(M.Constants),
    AceLibrary = Lib(M.AceLibrary),
    Assert = Lib(M.Assert),
    Incrementer = Lib(M.Incrementer),
    Mixin = Lib(M.Mixin),
    String = Lib(M.String),
    Table = Lib(M.Table),
    PrettyPrint = Lib(M.PrettyPrint),
    AceLibrary = Lib(M.AceLibrary),
    LuaEvaluator = Lib(M.LuaEvaluator),
    LibStubMixin = Lib(M.LibStubMixin),
    LibFactoryMixin = Lib(M.LibFactoryMixin),
}

--[[-----------------------------------------------------------------------------
Namespace Objects
-------------------------------------------------------------------------------]]
---@type Kapresoft_LibUtil_LibFactoryMixin
local LibFactoryMixin = LibStub(Lib(M.LibFactoryMixin))
local libFactory = LibFactoryMixin:New(L.Names)
--- @type Kapresoft_LibUtil_Objects
L.Objects = libFactory:GetObjects()
