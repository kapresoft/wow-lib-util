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

