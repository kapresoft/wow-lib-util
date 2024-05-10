--[[-----------------------------------------------------------------------------
Blizzard Vars
-------------------------------------------------------------------------------]]
local EnableAddOn, DisableAddOn = EnableAddOn or C_AddOns.EnableAddOn, DisableAddOn or C_AddOns.DisableAddOn
local C_AddOns_GetAddOnEnableState = C_AddOns.GetAddOnEnableState
local GetAddOnMetadata = GetAddOnMetadata or C_AddOns.GetAddOnMetadata

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local ns = select(2, ...); local K = ns.Kapresoft_LibUtil
local KO = K.Objects
local C = K_Constants
local sformat = string.format
local pformat       = K.pformat

--- @type LibStub
local LibStub = LibStub

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local MAJOR_VERSION = 'Kapresoft-AddonUtil-1.0'
--- @class Kapresoft_AddonUtil
local S = LibStub:NewLibrary(MAJOR_VERSION, 1); if not S then return end
S.mt = { __tostring = function() return MAJOR_VERSION .. '.' .. LibStub.minors[MAJOR_VERSION]  end }
setmetatable(S, S.mt)

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
local NAME_REQUIRED_MSG = "AddonUtil::%s: Expected an addon index:number or name:string but was=%s"

--- @param indexOrName IndexOrName The AddOn Index or Name
--- @param methodName Name
local function assertIndexOrName(methodName, indexOrName)
    assert(type(indexOrName) == 'string' or type(indexOrName) == 'number',
           sformat(NAME_REQUIRED_MSG, methodName, tostring(indexOrName)))
end

---@param addonName string
local function GetLocale(addonName)
    return ns.Kapresoft_LibUtil.Objects.AceLibrary.O.AceLocale:GetLocale(addonName, true)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
--- @param addonName Name
--- @param consoleColors Kapresoft_LibUtil_ColorDefinition
--- @param command string The long version of the slash command, i.e. actionbarplus
--- @param commandShort string The short version of the slash command, i.e. abp
function S:GetMessageLoadedText(addonName, consoleColors, command, commandShort)
    local LL = KO.AceLocaleUtil:GetLocale(addonName, true)
    local availCmd = LL['Type %s or %s for available commands.']
    local kch = K.CH
    local consoleCommandMessageFormat = sformat(availCmd, command, commandShort)
    local author = GetAddOnMetadata(addonName, 'Author')
    return sformat("%s version %s by %s is loaded. %s",
                   kch:P(addonName) , self:GetVersion(addonName), kch:FormatColor(consoleColors.primary, author),
                   consoleCommandMessageFormat)
end

--- @return string The ActionbarPlus version string. Example: 2024.3.1
--- @param addonName Name
function S:GetVersion(addonName)
    local versionText = GetAddOnMetadata(addonName, 'Version')
    --@do-not-package@
    versionText = '1.0.0.dev'
    --@end-do-not-package@
    return versionText
end

--- @param indexOrName IndexOrName
--- @return Enabled
function S:IsAddOnEnabled(indexOrName)
    assert(indexOrName, 'IsAddOnEnabled(indexOrName): Addon Index or Name is required.')

    local charName = UnitName("player")
    local intVal = -1
    if C_AddOns_GetAddOnEnableState then
        intVal = C_AddOns_GetAddOnEnableState(indexOrName, charName)
    elseif GetAddOnEnableState then
        intVal = GetAddOnEnableState(charName, indexOrName)
    end
    return intVal == 2
end

--- @param name Name The addOn name
--- @param charName Name|nil The character name. Defaults to current
function S:EnableAddOnForCharacter(name, charName)
    C:AssertType(name, 'string', 'AddonUtil:EnableAddOnForCharacter(name,charName)')

    charName = charName or UnitName("player")
    EnableAddOn(name, charName)
end

--- @param indexOrName IndexOrName The index from 1 to GetNumAddOns() or The name of the addon (as in TOC/folder filename), case insensitive.
--- @return AddOnInfo
function S:GetAddOnInfo(indexOrName)
    assertIndexOrName('GetAddOnInfo()', indexOrName)
    local name, title, notes, loadable, reason, security = GetAddOnInfo(indexOrName)
    local index
    if type(indexOrName) == 'number' then index = indexOrName end

    --- @class AddOnInfo
    --- @field index Index
    --- @field name AddOnName
    --- @field title AddOnTitle
    --- @field notes Notes
    --- @field loadable Boolean
    --- @field reason AddOnIsNotLoadableReason
    --- @field security AddOnSecurity
    --- @field newVersion Boolean Unused
    local info = {
        name = name, title = title, loadable = loadable, notes = notes,
        reason = reason, security = security,
        index = index
    }
    return info
end

---@param name Name
---@param callbackFn fun(loadSuccess:boolean) | "function(loadSuccess) print('success:', loadSuccess) end"
function S:LoadOnDemand(name, callbackFn)
    C:AssertType(name, 'string', 'AddonUtil:LoadOnDemand(name)')

    if not self:IsAddOnEnabled(name) then
        self:EnableAddOnForCharacter(name)
        if not self:IsAddOnEnabled(name) then
            local info = pformat(self:GetAddOnInfo(name))
            return error(sformat('Failed to Enable Addon: %s info=%s', name, info), 2)
        end
    end
    if not IsAddOnLoaded(name) then LoadAddOn(name); end
    local loaded = select(2, IsAddOnLoaded(name))
    callbackFn(loaded)
end



