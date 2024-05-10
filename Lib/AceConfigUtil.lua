--[[-----------------------------------------------------------------------------
Return Type: Kapresoft_AceConfigUtil
-------------------------------------------------------------------------------]]
--- @class Kapresoft_AceConfigUtil

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local ns = select(2, ...)

local K = ns.Kapresoft_LibUtil
local AceLocale = K.Objects.AceLibrary.O.AceLocale
local LibStub = K.LibStub
local ModuleName = K.M.AceConfigUtil()

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_AceConfigUtil
local S = LibStub:NewLibrary(ModuleName, 1); if not S then return end

--[[-----------------------------------------------------------------------------
Library Methods
-------------------------------------------------------------------------------]]

--- ### Usage:
--- `--- @type Kapresoft_AceConfigUtil`
--- ```
--- local util = Kapresoft_LibUtil_AceConfigUtil:New()
--- ```
--- @return Kapresoft_AceConfigUtil
--- @param silent boolean|nil Setting this to false will silence non-existing Locale Keys. [default: true]
function S:New(silent)
    return K:CreateAndInitFromMixinWithDefExc(S, silent)
end

--- @private
--- @param silent boolean Setting this to true will silence non-existing Locale Keys.
function S:Init(silent)
    assert('Namespace ns.addon is missing.', ns.addon)
    self.L = AceLocale:GetLocale(ns.addon)
    assert(self.L, 'Failed to create Locale for: ' .. tostring(ns.addon))
    if silent ~= false then
        -- Override index so we don't get an error for non-existing keys
        local meta = getmetatable(self.L)
        meta.__index = function(self, key)
            rawset(self, key, key)
            return key
        end
    end

    local c1           = ns:K():cf(HEIRLOOM_BLUE_COLOR)
    self.globalSetting = c1(self.L['Global Setting'])
    self.charSetting   = c1(self.L['Character Setting'])
end

--[[-----------------------------------------------------------------------------
Instance Methods
-------------------------------------------------------------------------------]]
do
    --- @type Kapresoft_AceConfigUtil
    local o = S
    local sformat = string.format

    --- @param localeKey string
    function o:G(localeKey)
        return sformat('%s (%s)', self.L[localeKey], self.globalSetting)
    end

    --- @param localeKey string
    function o:Gn(localeKey)
        return sformat('%s\n(%s)', self.L[localeKey], self.globalSetting)
    end

    --- @param localeKey string
    function o:C(localeKey)
        return sformat('%s (%s)', self.L[localeKey], self.charSetting)
    end

    --- @param localeKey string
    function o:Cn(localeKey)
        return sformat('%s\n(%s)', self.L[localeKey], self.charSetting)
    end

    --- @param opt AceConfigOption
    --- @param localeKey string
    function o:NameDescGlobal(opt, localeKey)
        opt.name = self.L[localeKey]
        opt.desc = self:G(localeKey .. '::Desc')
    end

    --- @param opt AceConfigOption
    --- @param localeKey string
    function o:NameDescCharacter(opt, localeKey)
        opt.name = self.L[localeKey]
        opt.desc = self.L.C(localeKey .. '::Desc')
    end

    --- Create a Global Option
    --- @param localeKey string The locale key
    --- @param options AceConfigOption
    function o:CreateGlobalOption(localeKey, options)
        local option = {}; self:NameDescGlobal(option, localeKey)
        if options == nil or type(options) ~= 'table' then return option end
        for k in pairs(option) do options[k] = option[k] end
        return options
    end

    --- Create a Character-Specific Option
    --- @param localeKey string The locale key
    --- @param options AceConfigOption
    function o:CreateCharOption(localeKey, options)
        local option = {}; self:NameDescCharacter(option, localeKey)
        if options == nil or type(options) ~= 'table' then return option end
        for k in pairs(option) do options[k] = option[k] end
        return options
    end
end

