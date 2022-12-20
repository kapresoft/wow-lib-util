local LibStub = LibStub
local C = Kapresoft_LibUtil_Constants

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
    ['PrettyPrint'] = C:KLibStub('PrettyPrint'),
    ['AceLibrary'] = C:KLibStub('AceLibrary'),
    ['Assert'] = C:KLibStub('Assert'),
    ['Incrementer'] = C:KLibStub('Incrementer'),
    ['LuaEvaluator'] = C:KLibStub('LuaEvaluator'),
    ['Mixin'] = C:KLibStub('Mixin'),
    ['String'] = C:KLibStub('String'),
    ['Table'] = C:KLibStub('Table'),
    ['LibFactoryMixin'] = C:KLibStub('LibFactoryMixin'),
}

--- @type Kapresoft_LibUtil_Namespace
local namespace = LibStub(MAJOR, MINOR)
--[[-----------------------------------------------------------------------------
Global
-------------------------------------------------------------------------------]]
Kapresoft_LibUtil = namespace.Objects