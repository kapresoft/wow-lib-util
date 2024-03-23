#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('TimeUtil.TimeUtil')

---@type Kapresoft_TimeUtil
local TimeUtil = LibStub('Kapresoft-TimeUtil-1.0')
_suite(tostring(TimeUtil))

function f1()
    return "f1", "f2"
end

Kapresoft_TimeUtil_Debug = true
--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('IsoDateToTimestamp')

assertEquals(TimeUtil:IsoDateToTimestamp('2024-03-22T17:34:00Z'), 1711182840)
assertEquals(TimeUtil:IsoDateToTimestamp('2024-01-27T17:34:00Z'), 1706434440)

_test('IsOutOfDate')
assertTrue(TimeUtil:IsOutOfDate('2024-03-10T17:34:00Z', '2024-03-21T00:00:00Z'))
