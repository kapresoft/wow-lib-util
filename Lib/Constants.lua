-- Standalone and should not have any dependencies

--[[-----------------------------------------------------------------------------
Debugging
-------------------------------------------------------------------------------]]
Kapresoft_LibUtil_LogLevel_LibWrapper = 0
Kapresoft_LibUtil_LogLevel_LibFactory = 0
Kapresoft_LibUtil_LogLevel_LibStub = 0

local addOn, ns = ...

--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub = LibStub
local nameShort = 'KL'
local logPrefix = 'Kapresoft-LibUtil::Init:'

--[[-----------------------------------------------------------------------------
Support Functions: Console Colors
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_ColorDefinition
local consoleColors = {
    primary   = 'e3caaf',
    secondary = 'fbeb2d',
    tertiary = 'ffffff'
}

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_Constants
local L = LibStub:NewLibrary('Kapresoft-LibUtil-Constants-1.0', 1); if not L then return end

--[[-----------------------------------------------------------------------------
Support Types & Functions
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_ConsoleHelperMixin
local ConsoleHelperMixin = {
    sformat = string.format,

    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    --- @param colorDef Kapresoft_LibUtil_ColorDefinition
    Init = function(self, colorDef)
        self.colorDef = colorDef
    end,

    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    --- @param text string The hex color without the '#', i.e "0xfff000" would be "fff000"
    --- @param text string The text to format
    FormatColor = function(self, color, text) return sformat('|cfd%s%s|r', color, text) end,

    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    --- @param text string The text to format
    P = function(self, text) return self:FormatColor(self.colorDef.primary, text)  end,

    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    --- @param text string The text to format
    S = function(self, text) return self:FormatColor(self.colorDef.secondary, text)  end,

    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    --- @param text string The text to format
    T = function(self, text) return self:FormatColor(self.colorDef.tertiary, text)  end,

    --- Generate the colorized Log Prefix
    --- @param module string The module name
    --- @param self Kapresoft_LibUtil_ConsoleHelperMixin
    ---@param subPrefix string Defaults to the addOn name
    CreateLogPrefix = function(self, module, subPrefix)
        local addOnPrefix
        if subPrefix then
            addOnPrefix = subPrefix
        elseif ns and ns.nameShort then
            addOnPrefix = ns.nameShort
        elseif addOn then
            addOnPrefix = addOn
        end
        return self.sformat(
                self:T('{{') .. '%s::%s::%s' .. self:T('}}:'),
                self:P(addOnPrefix), self:P(nameShort), self:S(module))
    end,
}

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
---@param o Kapresoft_LibUtil_Constants
local function PropertiesAndMethods(o)
    --- ```
    --- local SomeMixin1 = {}
    --- local object = {}
    --- sameReturnedObject = Mixin(object, SomeMixin1, SomeMixinN)
    --- // or
    --- local object = Mixin({}, SomeMixin1, SomeMixinN)
    --- ```
    --- @param object any The target object of which mixins will be applied to
    function o:Mixin(object, ...)
        for i = 1, select("#", ...) do
            local mixin = select(i, ...);
            for k, v in pairs(mixin) do
                object[k] = v;
            end
        end
        return object;
    end

    --- @vararg any The mixins as arguments
    function o:CreateFromMixins(...)
        return self:Mixin({}, ...)
    end

    --- @param mixin any The mixin
    --- @vararg any The arguments to pass to the new instance Init() method
    function o:CreateAndInitFromMixin(mixin, ...)
        local object = self:CreateFromMixins(mixin)
        object:Init(...);
        return object;
    end

    function o:TableSize(t)
        if type(t) ~= 'table' then error(string.format("Expected arg to be of type table, but got: %s", type(t))) end
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
    end
end

PropertiesAndMethods(L)

--- @type Kapresoft_LibUtil_ConsoleHelper
K_ConsoleHelper = L:CreateAndInitFromMixin(ConsoleHelperMixin, consoleColors)
--- @type Kapresoft_LibUtil_Constants
K_Constants = L
