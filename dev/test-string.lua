#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
-- LibStub requires strmatch/string.match to be global
strmatch = string.match

local require, format = require, string.format

--[[-----------------------------------------------------------------------------
Setup: Same order as _Lib.xml
-------------------------------------------------------------------------------]]
require('LibStub.LibStub')
require('Constants')
require('pprint.pprint')
require('Assert')
require('Table')
require('String')
require('Incrementer')
require('Mixin')
require('LuaEvaluator')
require('LibFactoryMixin')
require('Ace3.AceLibrary')
require('Namespace')

-- ############################################################
-- Verifies that all libraries are loaded properly
-- ############################################################

--local pprint = Kapresoft_LibUtil.PrettyPrint
--assert(pprint, "Expected 'pprint' to be an existing variable, but was not.")
--pprint('hello:', { 'there', 'world' })

local String = Kapresoft_LibUtil.String
assert(String.StartsWith("hello there", "hello"), "StartsWith() should pass")
assert(not String.StartsWith("hello there", "HELLO"), "StartsWith() uppercase should not pass")
assert(String.StartsWithIgnoreCase("Hello there", "HELLO"), "StartsWithIgnoreCase() should pass")
assert(not String.StartsWithIgnoreCase("XHello there", "HELLO"), "StartsWithIgnoreCase() should not pass")

assert(String.EndsWith("hello there", "there"), "EndsWith() should pass")
assert(not String.EndsWith("hello there", "THERE"), "EndsWith() should not pass")

assert(String.EndsWithIgnoreCase("hello there", "THERE"), "EndsWithIgnoreCase() should pass")
assert(not String.EndsWithIgnoreCase("hello therex", "THERE"), "EndsWithIgnoreCase() should not pass")

assert(String.Contains("hello there world", "there"), "Contains() should pass")
assert(String.Contains("hello there world", "hello "), "Contains() should pass")
assert(String.Contains("hello there world", "o th"), "Contains() should pass")
assert(not String.Contains("hello there world", "THERE"), "Contains() should not pass")
assert(String.ContainsIgnoreCase("hello there world", "THERE"), "Contains() should pass")
assert(String.ContainsIgnoreCase("hello there world", "LLO TH"), "Contains() should pass")
