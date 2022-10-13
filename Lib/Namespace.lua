local LibStub = LibStub

--[[-----------------------------------------------------------------------------
Namespace Initialization
-------------------------------------------------------------------------------]]
---This is so that EmmyLua can function properly in IDEs
---@class Kapresoft_LibUtil_Objects
local Kapresoft_LibUtil_Objects = {
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
    Table = {}
}

---@type Kapresoft_LibUtil_Objects
Kapresoft_LibUtil = {
    ['Assert'] = LibStub('Kapresoft-LibUtil-Assert-1.0'),
    ['Incrementer'] = LibStub('Kapresoft-LibUtil-Incrementer-1.0'),
    ['LuaEvaluator'] = LibStub('Kapresoft-LibUtil-LuaEvaluator-1.0'),
    ['Mixin'] = LibStub('Kapresoft-LibUtil-Mixin-1.0'),
    ['String'] = LibStub('Kapresoft-LibUtil-String-1.0'),
    ['Table'] = LibStub('Kapresoft-LibUtil-Table-1.0'),
}
