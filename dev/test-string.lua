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

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('StartsWith')
--assert(String.StartsWith("hello there", "hello"), "StartsWith() should pass")
local StartsWith = String.StartsWith
assertTrue(StartsWith("hello there", "hello"),
        '"hello there":StartsWith(hello)')
assertFalse(StartsWith("hello there", "HELLOx"),
        '"hello there":StartsWith(HELLO)')

_test('StartsWithIgnoreCase')
local StartsWithIgnoreCase = String.StartsWithIgnoreCase
assertTrue(StartsWithIgnoreCase("Hello there", "HELLO"),
        '"Hello There":StartsWithIgnoreCase(HELLO)')
assertFalse(StartsWithIgnoreCase("XHello there", "HELLO"),
        '"XHello There":StartsWithIgnoreCase(HELLO)')

_test('EndsWith')
local EndsWith = String.EndsWith
assertTrue(EndsWith("hello there", "there"), 'EndsWith("there")')
assertFalse(EndsWith("hello there", "THERE"), 'EndsWith("THERE")')

_test('Contains')
local Contains = String.Contains
assertTrue(Contains("hello there world", "there"), 'Contains("there")')
assertTrue(Contains("hello there world", "hello "), 'Contains("hello")')
assertTrue(Contains("hello there world", "o th"), 'Contains("o th")')
assertFalse(Contains("hello there world", "THERE"), 'Contains("THERE")')

_test('ContainsIgnoreCase')
local ContainsIgnoreCase = String.ContainsIgnoreCase
assertTrue(ContainsIgnoreCase("hello there world", "THERE"), 'Contains("THERE")')
assertTrue(ContainsIgnoreCase("hello there world", "LLO th"), 'Contains("LLO th")')
assertFalse(ContainsIgnoreCase("any word", "yyy xx"), 'Contains("yyy XX)')

_test('Truncate')
local Truncate = String.Truncate
assertEquals(Truncate('hello there world', 1), 'h...', "Truncate(str, 1)")
assertEquals(Truncate('hello there world', 6), 'hello...', "Truncate(str, 6)")
assertEquals(Truncate('hello there world', 50), 'hello there world', "Truncate(str, 50)")
assertEquals(Truncate('hello there world', 7, '**'), 'hello t**', "Truncate(str, 7)")

_test('TruncateReversed')
local TruncateReversed = String.TruncateReversed
assertEquals(TruncateReversed(nil, 5), '...', 'TruncateReversed(nil, 5)')
assertEquals(TruncateReversed('hello there world', 9), "...world", 'TruncateReversed(str, 9)')
assertEquals(TruncateReversed('hello there world', 4), "...d", 'TruncateReversed(str, 4)')
assertEquals(TruncateReversed('hello there world', 4, '$$'), "$$ld", "TruncateReversed(str, 4, '$$')")

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
