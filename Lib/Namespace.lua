local LibStub = LibStub
local C = Kapresoft_LibUtil_Constants
local K_LibStub = K_LibStub

local MAJOR, MINOR = "Kapresoft-LibUtil-Namespace-1.0", 1

---@class Kapresoft_LibUtil_Namespace
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded and no upgrade necessary
if not L then return end

--[[-----------------------------------------------------------------------------
Namespace Initialization
-------------------------------------------------------------------------------]]
---This is so that EmmyLua can function properly in IDEs
---@class Kapresoft_LibUtil_Objects
local Kapresoft_LibUtil_Objects = {
    ---@type Kapresoft_LibUtil_PrettyPrint
    PrettyPrint = {},
    ---@type Kapresoft_LibUtil_AceLibrary
    AceLibrary = {},
    ---@type Kapresoft_LibUtil_Assert
    Assert = {},
    ---@type Kapresoft_LibUtil_Incrementer
    Incrementer = {},
    ---@type Kapresoft_LibUtil_LuaEvaluator
    LuaEvaluator = {},
    ---@type Kapresoft_LibUtil_Mixin
    Mixin = {},
    ---@type Kapresoft_LibUtil_String
    String = {},
    ---@type Kapresoft_LibUtil_Table
    Table = {},
    ---@type Kapresoft_LibUtil_LibFactoryMixin
    LibFactoryMixin = {}
}

---The keys need to be the same as Kapresoft_LibUtil_Objects table so that EmmyLua will know the type.
---@type Kapresoft_LibUtil_Objects
L.Objects = {
    ['PrettyPrint'] = K_LibStub('PrettyPrint'),
    ['AceLibrary'] = K_LibStub('AceLibrary'),
    ['Assert'] = K_LibStub('Assert'),
    ['Incrementer'] = K_LibStub('Incrementer'),
    ['LuaEvaluator'] = K_LibStub('LuaEvaluator'),
    ['Mixin'] = K_LibStub('Mixin'),
    ['String'] = K_LibStub('String'),
    ['Table'] = K_LibStub('Table'),
    ['LibFactoryMixin'] = K_LibStub('LibFactoryMixin'),
}

--- @type Kapresoft_LibUtil_Namespace
local namespace = LibStub(MAJOR, MINOR)
--[[-----------------------------------------------------------------------------
Global
-------------------------------------------------------------------------------]]
Kapresoft_LibUtil = namespace.Objects