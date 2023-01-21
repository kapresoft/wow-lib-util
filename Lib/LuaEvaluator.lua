--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat, loadstring = string.format, loadstring

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local _, ns = ...
local O, LibStub, M, pformat = ns.Kapresoft_LibUtil:LibPack()
local logPrefix = ''

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_LuaEvaluator
local L = LibStub:NewLibrary(M.LuaEvaluator, 2)
-- return if already loaded and no upgrade necessary
if not L then return end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
---@param literalVarName string
function L:Eval(literalVarName)
    if not literalVarName then return end
    --print(logPrefix, 'eval:', literalVarName)

    local scriptToEval = sformat([[ return %s]], literalVarName)
    local func, errorMessage = loadstring(scriptToEval, "Eval-Variable")
    if errorMessage then print(logPrefix, 'Error:', pformat(errorMessage)) end

    local val = func()
    if type(val) == 'function' then
        local status, pcallError = pcall(function() val = val() end)
        if not status then
            val = nil
        end
        if pcallError then print(logPrefix, 'Error:', pformat(pcallError)) end
    end
    return val
end
