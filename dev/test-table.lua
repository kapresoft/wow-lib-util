#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
--K_VERBOSE = true
local require = require

require('test.Setup')
require('Table.Table')

---@type Kapresoft_Table
local Table = LibStub('Kapresoft-Table-1.0')
_suite(tostring(Table))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('Keys')
local t = { 1, 3, ['hello'] = 'world', Ren='Stimpy'}
local keys = Table.Keys(t)
--print('Keys:', pformat(keys))
assertEquals(keys[1], 1, 'Key[1]: 1')
assertEquals(keys[2], 2, 'Key[2]: 3')
assertEquals(keys[3], 'hello', 'Key[3]: hello')
assertEquals(keys[4], 'Ren', 'Key[4]: Ren')

_test('Values')
local values = Table.Values(t)
--print('Values:', pformat(values))
assertEquals(values[1], 1, 'Values[1]: 1')
assertEquals(values[2], 3, 'Values[1]: 2')
assertEquals(values[3], 'world', 'Values[3]: world')
assertEquals(values[4], 'Stimpy', 'Values[4]: Stimpy')

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
