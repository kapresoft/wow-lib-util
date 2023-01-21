--[[-----------------------------------------------------------------------------
Blizzard Vars
-------------------------------------------------------------------------------]]
local CreateAndInitFromMixin = CreateAndInitFromMixin

--[[-----------------------------------------------------------------------------
Global Vars
-------------------------------------------------------------------------------]]
-- Set Log Level Default
Kapresoft_LibUtil_LogLevel = 0

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local sformat = string.format
local LibPrefix = 'Kapresoft-LibUtil'
local nameShort = 'KL'

--- @type Kapresoft_Base_Namespace
local addOn, ns = ...

--[[-----------------------------------------------------------------------------
Support Functions: Console Colors
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_ColorDefinition
local consoleColors = ns.consoleColors or {
    primary   = 'e3caaf',
    secondary = 'fbeb2d',
    tertiary = 'ffffff'
}

--- @class Kapresoft_LibUtil_ConsoleColorMixin
local ConsoleColorMixin = {
    sformat = string.format,

    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    --- @param colorDef Kapresoft_LibUtil_ColorDefinition
    Init = function(self, colorDef)
        self.colorDef = colorDef
    end,

    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    --- @param text string The hex color without the '#', i.e "0xfff000" would be "fff000"
    --- @param text string The text to format
    FormatColor = function(self, color, text) return sformat('|cfd%s%s|r', color, text) end,

    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    --- @param text string The text to format
    P = function(self, text) return self:FormatColor(self.colorDef.primary, text)  end,

    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    --- @param text string The text to format
    S = function(self, text) return self:FormatColor(self.colorDef.secondary, text)  end,

    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    --- @param text string The text to format
    T = function(self, text) return self:FormatColor(self.colorDef.tertiary, text)  end,

    --- Generate the colorized Log Prefix
    --- @param module string The module name
    --- @param self Kapresoft_LibUtil_ConsoleColorMixin
    ---@param subPrefix string Defaults to the addOn name
    CreateLogPrefix = function(self, module, subPrefix)
        local addOnPrefix = subPrefix or ns.nameShort or addOn
        return self.sformat(
                self:T('{{') .. '%s::%s::%s' .. self:T('}}:'),
                self:P(addOnPrefix), self:P(nameShort), self:S(module))
    end,
}

--[[-----------------------------------------------------------------------------
Kapresoft_LibUtil Initialization
-------------------------------------------------------------------------------]]
--- @type Kapresoft_LibUtil
local LibUtil = {
    LibPrefix = LibPrefix,
    --- @param self Kapresoft_LibUtil
    --- @param moduleName string
    Lib = function(self, moduleName) return sformat('%s-%s-1.0', self.LibPrefix, moduleName) end,

    --- @type Kapresoft_LibUtil_Objects
    Objects = {},
    --- @type Kapresoft_LibUtil_ConsoleColor
    H = CreateAndInitFromMixin(ConsoleColorMixin, consoleColors),

    LogLevel = Kapresoft_LibUtil_LogLevel or 0,
    --- @param self Kapresoft_LibUtil
    --- @param logLevel number A zero or positive number
    ShouldLog = function(self, logLevel) return self.LogLevel <= (logLevel or 0)  end,
}

--- ```
--- @type Kapresoft_Base_Namespace
--- local _, ns = ...
--- local O, LibStub, M, pformat, LibUtil = ns.Kapresoft_LibUtil:LibPack()
--- ```
--- @return Kapresoft_LibUtil_Objects, Kapresoft_LibUtil_LibStub, Kapresoft_LibUtil_Modules, fun(fmt:string, ...)|fun(val:string), Kapresoft_LibUtil
function LibUtil:LibPack() return self.Objects, self.LibStub, self.M, self.pformat, self end

ns.Kapresoft_LibUtil = LibUtil
