#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
--VERBOSE = true
local require = require

require('test.Setup')
require('Mixin.MixinBase')

---@type Kapresoft_LibUtil_BaseMixin
local Mixin = LibStub('Kapresoft-LibUtil-BaseMixin-1.0')
_suite(tostring(Mixin))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
local Mixin1 = {
    Init = function(self, name) self.name = name end,
    Purpose = 'To mix in',
    hello = function(self)  return "Hello World: " .. tostring(self.name)  end
}
assertNil(getmetatable(Mixin1))

--print('Mixin1:', pformat(Mixin1))

-- ###############################################
_test('Mixin')

local c = {}
local cprime = Mixin:Mixin(c, Mixin1)
--print('c:', pformat(c))

assertNotNil(c, 'C exists')
assertNil(getmetatable(c), 'Metatable should be abset')
assertNotEquals(c, Mixin1, 'C is different from Mixin1')
assertEquals(c, cprime, 'C table hash')
assertType(c.Init, 'function', 'c.Init')
assertType(c.Purpose, 'string', 'c.Purpose')

-- ###############################################
_test('CreateAndInitFromMixin')

local a = Mixin:CreateAndInitFromMixin(Mixin1, 'John')
--print('a:', pformat(a))

--- Verify hash is not the same
local mixinHash = tostring(Mixin1)
assert(mixinHash, "Mixin1 Hash is missing")
local aHash = tostring(a)
assertNotEquals(aHash, mixinHash, 'Hash Values')

--- Verify args was passed
assertEquals('Hello World: John', a:hello(), 'Hello()')

-- ###############################################
_test('CreateFromMixins')

local b = Mixin:CreateFromMixins(Mixin1)
assertNil(b.name)
assertEquals('Hello World: nil', b:hello())

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
