#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
Kapresoft_LibUtil_LogLevel = 10

local require = require

require('test.Setup')
require('Constants')
require('LibFactoryMixin.LibFactoryMixin')

---@type Kapresoft_LibFactoryMixin
local LibFactoryMixin = LibStub('Kapresoft-LibFactoryMixin-1.0')
_suite(tostring(LibFactoryMixin))

--[[-----------------------------------------------------------------------------
Setup Data
-------------------------------------------------------------------------------]]
local oneLib = LibStub:NewLibrary('One-1.0', 1)
setmetatable(oneLib, { __tostring = function () return 'One' end })
function oneLib:GetName() return tostring(self) end

local twoLib = LibStub:NewLibrary('Two-1.0', 1)
function twoLib:GetName() return tostring(self) end
setmetatable(twoLib, { __tostring = function () return 'Two' end })

local libNames = { One = 'One-1.0', Two = 'Two-1.0' }

local libFactory = LibFactoryMixin:New(libNames)
local O = libFactory:GetObjects()

--[[-----------------------------------------------------------------------------
Tests
-------------------------------------------------------------------------------]]
_test('GetObjects')
assertNotNil(O, 'GetObjects()')

_test('GetObjects::OneLib')
assertNotNil(O.One, 'One Instance')
assertType(O.One.GetName, 'function', 'GetName() is a function')
assertEquals(O.One:GetName(), 'One', 'GetName()::One')

_test('GetObjects::TwoLib')
assertNotNil(O.Two, 'Two Instance')
assertType(O.Two.GetName, 'function', 'GetName() is a function')
assertEquals(O.Two:GetName(), 'Two', 'GetName()::Two')

--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
