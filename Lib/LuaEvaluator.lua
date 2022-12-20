--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat, loadstring = string.format, loadstring

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub, K_LibName = LibStub, K_LibName
local MAJOR, MINOR = K_LibName("LuaEvaluator"), 1
local logPrefix = ''

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_LuaEvaluator
local L = LibStub:NewLibrary(MAJOR, MINOR)
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

--[[-----------------------------------------------------------------------------
Global Method
-------------------------------------------------------------------------------]]
function Kapresoft_LibUtil_LuaEvaluator() return LibStub(MAJOR, MINOR) end
