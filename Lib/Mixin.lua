---This is a customized version of Mixin based of Blizzards Mixin.lua
---@see also Blizzard's Interface/SharedXML/Mixin.lua

--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local addon, ns = ...
local LibStub = LibStub
local WRONG_TYPE_MSG = 'Expecting table to be source of mixin but got type [%s] instead'
local WRONG_ARG_TYPE_MSG = 'Expected arg #2 to be a list of string properties.'
local MIXIN_OBJ_REQUIRED_MSG = "Can't mixin to a nil object in Mixin(object, ...)"
local MAJOR, MINOR = "Kapresoft-LibUtil-Mixin-1.0", 1
local LOG_PREFIX = '|cfdffffff{{|r|cfd2db9fb' .. addon .. '|r|cfdfbeb2d%s|r|cfdffffff}}|r'

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]

---@class Kapresoft_LibUtil_Mixin
local L = LibStub:NewLibrary(MAJOR, MINOR)

function Kapresoft_LibUtil_Mixin() return L end

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
---@param source table The source table
---@param match string The string to match
local function listContains(source, match)
    for _,v in ipairs(source) do if match == v then return true end end
    return false
end

---@param object any The target object
function L:MixinAll(object, ...)
    for i = 1, select("#", ...) do
        local mixin = select(i, ...)
        for k, v in pairs(mixin) do
            object[k] = v
        end
    end

    return object
end

---Example:
---```
---local o = {}
---local String = String()
---Mixin:(o, String)
---```
---@param object any
function L:Mixin(object, ...)
    if not object then error(MIXIN_OBJ_REQUIRED_MSG) end
    return self:MixinExcept(object, { 'GetName', 'mt', 'log' }, ...)
end

---```
---local MyObj = MixinAndInit(MyMixin, arg1, arg2, argN)
---```
---@param object any
function L:MixinAndInit(object, ...)
    if not object then error(MIXIN_OBJ_REQUIRED_MSG) end
    local o = self:MixinExcept(object, { 'GetName', 'mt', 'log' }, ...)
    if o.Init then o:Init(...) end
    return o
end

---Mixin the ... with target object
---otherwise mixin selfObj if no args {...} are provided
function L:MixinOrElseSelf(target, selfObj, ...)
    local arg = {...}
    if 0 == #arg then self:Mixin(target, selfObj) else self:Mixin(target, ...) end
    return target
end

---@param propertySkipItems table local items = { 'Property1', 'Property2' }
function L:MixinExcept(object, propertySkipItems, ...)
    if 'table' ~= type(propertySkipItems) then error(WRONG_ARG_TYPE_MSG) end
    local arg = {...}
    if 0 == #arg then
        print(sformat(LOG_PREFIX .. ':: %s', 'Mixin', 'No objects were passed to mixin.'))
        return
    end
    for i = 1, select("#", ...) do
        local mixin = select(i, ...)
        local objectType = type(mixin)
        if 'table' ~= objectType then error(sformat(WRONG_TYPE_MSG, tostring(objectType))) end
        for k, v in pairs(mixin) do
            -- Apply skipList to key of string types only
            if 'string' == type(k) then
                if not listContains(propertySkipItems, k) then object[k] = v end
            else
                print('non-string')
                object[k] = v
            end
        end
    end
    return object
end

---@see also Blizzard's Interface/SharedXML/Mixin.lua
function K_CreateFromMixins(...)
    return L:Mixin({}, ...)
end

---Create New instance of mixin and call Init() with parameters
---@param mixin any The object to mixin the new instance
---@see also Blizzard's Interface/SharedXML/Mixin.lua
function K_CreateAndInitFromMixin(mixin, ...)
    local object = K_CreateFromMixins(mixin);
    object:Init(...);
    return object;
end