--[[-----------------------------------------------------------------------------
This file is not needed to function. It is solely for EmmyLua / IDE functionality
-------------------------------------------------------------------------------]]
--- @alias PostConstructHandler fun(libName:string, newLibInstance:any) : void

--- @class Kapresoft_LibUtil_AceLibraryObjects
local Objects = {
    --- @type AceAddon
    AceAddon = nil,
    --- @type AceBucket
    AceBucket = nil,
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
    --- @type AceLocale
    AceLocale = nil,
}

--- @class Kapresoft_LibUtil_LibStub : Kapresoft_LibUtil_LibStubMixin
local Kapresoft_LibUtil_LibStub = {

}

--- @class Kapresoft_Base_Namespace
--- @field Kapresoft_LibUtil Kapresoft_LibUtil

--- @class Kapresoft_LibUtil_BaseLibrary
local Kapresoft_LibUtil_BaseLibrary = {}

--- @class Kapresoft_LibUtil_ColorDefinition
local Kapresoft_LibUtil_ColorDefinition = {
    --- @type string
    primary   = 'e3caaf',
    --- @type string
    secondary = 'fbeb2d',
    --- @type string
    tertiary = 'ffffff'
}

--- @class Kapresoft_LibUtil_ColorDefinition2
local Kapresoft_LibUtil_ColorDefinition2 = {
    --- @type Color
    primary   = CreateColorFromHexString('ffaabbcc'),
    --- @type Color
    secondary = CreateColorFromHexString('ffbbbbcc'),
    --- @type Color
    tertiary = CreateColorFromHexString('ffccbbcc'),
}

--- @class Kapresoft_LibUtil_ConsoleHelper : Kapresoft_LibUtil_ConsoleHelperMixin
local ConsoleColor = {}
