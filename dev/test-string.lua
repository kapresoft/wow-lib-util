#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
--VERBOSE = true
local require = require

require('test.Setup')
require('String.StringBase')

---@type Kapresoft_LibUtil_BaseString
local String = LibStub('Kapresoft-LibUtil-BaseString-1.0')
_suite(tostring(String))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('StartsWith')
--assert(String.StartsWith("hello there", "hello"), "StartsWith() should pass")
assertTrue(String.StartsWith("hello there", "hello"),
        '"hello there":StartsWith(hello)')
assertFalse(String.StartsWith("hello there", "HELLOx"),
        '"hello there":StartsWith(HELLO)')

_test('StartsWithIgnoreCase')
assertTrue(String.StartsWithIgnoreCase("Hello there", "HELLO"),
        '"Hello There":StartsWithIgnoreCase(HELLO)')
assertFalse(String.StartsWithIgnoreCase("XHello there", "HELLO"),
        '"XHello There":StartsWithIgnoreCase(HELLO)')

_test('EndsWith')
assertTrue(String.EndsWith("hello there", "there"), 'EndsWith("there")')
assertFalse(String.EndsWith("hello there", "THERE"), 'EndsWith("THERE")')

_test('Contains')
assertTrue(String.Contains("hello there world", "there"), 'Contains("there")')
assertTrue(String.Contains("hello there world", "hello "), 'Contains("hello")')
assertTrue(String.Contains("hello there world", "o th"), 'Contains("o th")')
assertFalse(String.Contains("hello there world", "THERE"), 'Contains("THERE")')

_test('ContainsIgnoreCase')
assertTrue(String.ContainsIgnoreCase("hello there world", "THERE"), 'Contains("THERE")')
assertTrue(String.ContainsIgnoreCase("hello there world", "LLO th"), 'Contains("LLO th")')
assertFalse(String.ContainsIgnoreCase("any word", "yyy xx"), 'Contains("yyy XX)')
