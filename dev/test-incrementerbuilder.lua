#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('IncrementerBuilder.IncrementerBuilder')

---@type Kapresoft_IncrementerBuilder
local IncrementerBuilder = LibStub('Kapresoft-IncrementerBuilder-1.0')
_suite(tostring(IncrementerBuilder))
-- LibStub('Kapresoft-LibUtil-IncrementerBuilder-1.0')

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('New(start:0, increment:1)')
local a = IncrementerBuilder:New(0, 1)
assertEquals(a:get(), 0, 'Incrementer:get():0')

_test('next()')
assertEquals(a:next(), 1, 'Incrementer:next():1')

_test('next(custom)')
assertEquals(a:next(10), 11, 'Incrementer:next(10):11')

_test('next(), then reset()')
a:next(); a:reset()
assertEquals(a:get(), 0, 'Incrementer:next():reset:0')

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
