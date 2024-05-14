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
local sformat = string.format

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
--- @param addonName Name
--- @param silent boolean|nil Setting this to false will silence non-existing Locale Keys. [default: true]
function S:New(addonName, silent)
    return K:CreateAndInitFromMixinWithDefExc(S, addonName, silent)
end

--- @private
--- @param addonName Name
--- @param silent boolean Setting this to true will silence non-existing Locale Keys.
function S:Init(addonName, silent)
    assert(type(addonName) == 'string', 'Addon name is missing.')
    self.addonName = addonName

    local c1, c2 = K:cf(HEIRLOOM_BLUE_COLOR), K:cf(YELLOW_FONT_COLOR)
    self.printp = function(...) print(sformat('{{%s::%s}}', c1(addonName), c2(ModuleName)), ...)  end

    local success, result = pcall(function() return AceLocale:GetLocale(addonName) end)
    if not success then
        return self.printp(sformat('GetLocale(%s) failed with: %s', self.addonName, result))
    end; self.L = result
    assert(self.L, 'Failed to create Locale for: ' .. tostring(self.addonName))
    if silent ~= false then
        -- Override index so we don't get an error for non-existing keys
        local meta = getmetatable(self.L)
        meta.__index = function(self, key)
            rawset(self, key, key)
            return key
        end
    end

    self.globalSetting = c1(self.L['Global Setting'])
    self.charSetting   = c1(self.L['Character Setting'])
end

--[[-----------------------------------------------------------------------------
Instance Methods
-------------------------------------------------------------------------------]]
do
    --- @type Kapresoft_AceConfigUtil
    local o = S

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
        local descKey = localeKey .. '::Desc'
        if not self.L then
            opt.name, opt.desc = localeKey, descKey
            return
        end

        opt.name = self.L[localeKey]
        opt.desc = self:G(descKey)
    end

    --- @param opt AceConfigOption
    --- @param localeKey string
    function o:NameDescCharacter(opt, localeKey)
        local descKey = localeKey .. '::Desc'
        if not self.L then
            opt.name, opt.desc = localeKey, descKey
            return
        end

        opt.name = self.L[localeKey]
        opt.desc = self.L.C(descKey)
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

