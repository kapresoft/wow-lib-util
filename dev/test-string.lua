#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('String.String')

---@type Kapresoft_String
local String = LibStub('Kapresoft-String-1.0')
_suite(tostring(String))

function f1()
    return "f1", "f2"
end

local a, b = f1() do
    print('a.i:', tostring(a), 'b.i:', b)

    print('hello')
    b = 'there'
    a = 'hi'

end
print('a:', tostring(a), 'b:', b, 'c:', tostring(c))

if true then return end
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

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
