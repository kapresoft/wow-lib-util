#!/usr/bin/env lua
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
-- LibStub requires strmatch/string.match to be global
strmatch = string.match

local require, format = require, string.format

--[[-----------------------------------------------------------------------------
Setup
-------------------------------------------------------------------------------]]
require('LibStub.LibStub')
require('Mixin')

---@class Mix
local mix = {
    Init = function(self, x,y)
        self.x = x
        self.y = y
    end,
    Hello = function(self) print('hello world. x:', self.x, 'y:', self.y)  end
}


---@class V : Mix
local v = K_CreateAndInitFromMixin(mix, 1, 2)
v:Hello()