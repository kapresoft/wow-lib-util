#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
--K_VERBOSE = true
local require = require

require('test.Setup')
require('Assert.Assert')

---@type Kapresoft_Assert
local Assert = LibStub('Kapresoft-Assert-1.0')
_suite(tostring(Assert))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('IsNil')
assertTrue(Assert.IsNil(nil), 'IsNil')

_test('IsNotNil')
assertTrue(Assert.IsNotNil({}), 'IsNotNil')

_test('HasKey')
assertTrue(Assert.HasKey({ 1 }, 1), 'HasKey(1)')
local t = { hello='world' }
assertTrue(Assert.HasKey(t, 'hello'), 'HasKey(hello)')
assertFalse(Assert.HasKey(t, 'hellox'), 'HasKey(hellox)')

_test('HasNoKey')
assertTrue(Assert.HasNoKey(t, 'hellox'), 'HasNoKey(hellox)')

local hasError = false
xpcall(function() Assert.AssertNotNil(nil)  end,
        function(errMsg) hasError = true end)
assertTrue(hasError, 'AssertNotNil::AssertionShouldFail')

hasError = false
xpcall(function() Assert.AssertNotNil({})  end,
        function(errMsg) hasError = true end)
assertFalse(hasError, 'AssertNotNil::AssertionShouldPass')
