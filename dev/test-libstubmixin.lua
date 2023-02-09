#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('Constants')
require('LibStubMixin.LibStubMixin')

---@type Kapresoft_LibStubMixin
local LibStubMixin = LibStub('Kapresoft-LibStubMixin-1.0')
_suite(tostring(LibStubMixin))

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
local Mixin1 = {
    Init = function(self, name) self.name = name end,
    Purpose = 'To mix in',
    hello = function(self)  return "Hello World: " .. tostring(self.name)  end
}

_test("New")
local LibStub = LibStubMixin:New('Test', 1)

_test("NewLibrary")
local A = LibStub:NewLibrary('A', 1)
local B = LibStub:NewLibrary('B', 1)
assertNotNil(A, 'A exists')
assertNotNil(B, 'B exists')

_test('LibStub("<Lib>")')
assertNotNil(LibStub('A'), 'LibStub("A") exists')
assertNotNil(LibStub('B'), 'LibStub("B") exists')


--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
