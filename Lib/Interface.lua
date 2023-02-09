--[[-----------------------------------------------------------------------------
This file is not needed to function. It is solely for EmmyLua / IDE functionality
-------------------------------------------------------------------------------]]
--- @alias PostConstructHandler fun(libName:string, newLibInstance:any) : void

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
    --- @type Kapresoft_LibUtil_IncrementerBuilder
    Incrementer = {},
    --- @type Kapresoft_LibUtil_LuaEvaluator
    LuaEvaluator = {},
    --- @type Kapresoft_LibUtil_Mixin
    Mixin = {},
    --- @type Kapresoft_LibUtil_String
    String = {},
    --- @type Kapresoft_LibUtil_Table
    Table = {},
    --- @type Kapresoft_LibUtil_LibStubMixin
    LibStubMixin = {},
    --- @type Kapresoft_LibUtil_LibFactoryMixin
    LibFactoryMixin = {},
    --- @type Kapresoft_LibUtil_Safecall
    Safecall = {},
}

--- @class Kapresoft_LibUtil_AceLibraryObjects
local Objects = {
    --- @type AceAddon
    AceAddon = nil,
    --- @type AceConsole
    AceConsole = nil,
    --- @type AceConfig
    AceConfig = nil,
    --- @type AceConfigDialog
    AceConfigDialog = nil,
    --- @type AceDB
    AceDB = nil,
    --- @type AceDBOptions
    AceDBOptions = nil,
    --- @type AceEvent
    AceEvent = nil,
    --- @type AceHook
    AceHook = nil,
    --- @type AceGUI
    AceGUI = nil,
    --- @type AceLibSharedMedia
    AceLibSharedMedia = nil,
}

--- @class Kapresoft_LibUtil_LibStub : Kapresoft_LibUtil_LibStubMixin
local Kapresoft_LibUtil_LibStub = {

}

--- @class Kapresoft_LibUtil
local Kapresoft_LibUtil = {

    --- @type string Kapresoft-LibUtil
    LibPrefix = '',
    --- @type Kapresoft_LibUtil_Modules
    M = {},
    --- @type Kapresoft_LibUtil_ConsoleHelper
    CH = {},
    --- @type number
    LogLevel = 0,
    --- @type fun(self:Kapresoft_LibUtil, logLevel:number) : boolean
    ShouldLog = {},
    --- @type fun(self:Kapresoft_LibUtil, moduleName:string) :string
    Lib = {},
    --- @type Kapresoft_LibUtil_LibStubMixin
    LibStubMixin = {},
    --- @type Kapresoft_LibUtil_LibStub
    LibStub = {},
    --- @type Kapresoft_LibUtil_Objects
    Objects = {},
    --- @type fun(fmt:string, ...)|fun(val:string)
    pformat = {},

    --- `local LibStub, pformat = Kapresoft_LibUtil:LibPack()`
    --- @type fun(self:Kapresoft_LibUtil) : Kapresoft_LibUtil_LibStub, fun(fmt:string, ...)|fun(val:string)
    LibPack = {},

    --- Creates a library wrapper specifically for the World of Warcraft
    --- Usage: local L = CreateLibWrapper('Table', 5, 'Kapresoft-Table-1.0')
    --- @type fun(self:Kapresoft_LibUtil, moduleName:ModuleName, moduleRevision:number, targetLibraryMajorVersion:TargetLibraryMajorVersion) : any
    CreateLibWrapper = {},

    --- Create an incrementer
    --- @type fun(self:Kapresoft_LibUtil, start:number, increment:number) : Kapresoft_Incrementer
    CreateIncrementer = {},

    --- @type fun(self:Kapresoft_LibUtil, object:any, ...) : any
    Mixin = {},
    --- @type fun(self:Kapresoft_LibUtil, ...) : any
    CreateFromMixins = {},
    --- @type fun(self:Kapresoft_LibUtil, mixin:any, ...) : any
    CreateAndInitFromMixin = {}

}

--- @class Kapresoft_Base_Namespace
local Kapresoft_Namespace = {
    --- @type Kapresoft_LibUtil
    Kapresoft_LibUtil = {},
}

--- @class Kapresoft_LibUtil_LibFactoryMixin : Kapresoft_LibFactoryMixin
local Kapresoft_LibUtil_LibFactoryMixin = {
    --- @type fun(self:Kapresoft_LibUtil_LibFactoryMixin) : table
    GetObjects = {}
}

--- @class Kapresoft_LibUtil_BaseLibrary
local Kapresoft_LibUtil_BaseLibrary = {}

--- @class Kapresoft_LibUtil_ConsoleHelper : Kapresoft_LibUtil_ConsoleHelperMixin
local ConsoleColor = {}
