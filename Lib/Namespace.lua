local C = Kapresoft_LibUtil_Constants

--[[-----------------------------------------------------------------------------
Namespace Initialization
-------------------------------------------------------------------------------]]
---This is so that EmmyLua can function properly in IDEs
---@class Kapresoft_LibUtil_Objects
local Kapresoft_LibUtil_Objects = {
    ---@type Kapresoft_LibUtil_PrettyPrint
    PrettyPrint = {},
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

---The keys need to be the same as Kapresoft_LibUtil_Objects table so that EmmyLua will know the type.
---@type Kapresoft_LibUtil_Objects
Kapresoft_LibUtil = {
    ['PrettyPrint'] = C:KLibStub('PrettyPrint'),
    ['Assert'] = C:KLibStub('Assert'),
    ['Incrementer'] = C:KLibStub('Incrementer'),
    ['LuaEvaluator'] = C:KLibStub('LuaEvaluator'),
    ['Mixin'] = C:KLibStub('Mixin'),
    ['String'] = C:KLibStub('String'),
    ['Table'] = C:KLibStub('Table'),
}
