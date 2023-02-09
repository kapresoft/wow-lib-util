#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('LuaEvaluator.LuaEvaluator')

---@type Kapresoft_LuaEvaluator
local LuaEval = LibStub('Kapresoft-LuaEvaluator-1.0')
_suite(tostring(LuaEval))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('Eval::Global-Var-Name "xvar"')
xvar = 10
local xvarVal = LuaEval:Eval('xvar')
assertEquals(xvarVal, xvar, "Global xvar value should be: 10")

_test('Eval::Function')
local fnVal = LuaEval:Eval('function() return "hi" end')
assertEquals(fnVal, 'hi', "Evaluated fn should return value: hi")

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
