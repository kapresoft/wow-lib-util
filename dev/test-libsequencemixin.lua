#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('Constants')
require('SequenceMixin.SequenceMixin')

---@type Kapresoft_SequenceMixin
local SequenceMixin = LibStub('Kapresoft-SequenceMixin-1.0')
_suite(tostring(String))

assertNotNil(SequenceMixin, 'SequenceMixin')
assertNotNil(SequenceMixin.New, 'SequenceMixin')

--- can't test properly because of CreateColorFromHexString (a Blizzard function)

if true then return end
--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('New')
--assert(String.StartsWith("hello there", "hello"), "StartsWith() should pass")

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
