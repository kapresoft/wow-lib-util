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
local ns = select(2, ...)
local K = ns.Kapresoft_LibUtil
local LibStub = K.LibStub
local C = K.Objects.Constants
local sformat = string.format
local pformat       = K.pformat
local ModuleName = K.M.AddonUtil()

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_AddonUtil
local S = LibStub:NewLibrary(ModuleName, 2); if not S then return end

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

--- @param name Name
--- @param callbackFn fun(loadSuccess:boolean, info:AddOnInfo, errorMsg:string) | "function(loadSuccess, info, errorMsg) print('success:', loadSuccess) end"
function S:LoadOnDemand(name, callbackFn)
    C:AssertType(name, 'string', 'AddonUtil:LoadOnDemand(name)')

    local info = self:GetAddOnInfo(name)
    if not self:IsAddOnEnabled(name) then
        self:EnableAddOnForCharacter(name)
        if not self:IsAddOnEnabled(name) then
            local infoText = pformat(info)
            return callbackFn(false, info, sformat('Failed to Enable Addon: %s info=%s', name, infoText))
        end
    end
    if not IsAddOnLoaded(name) then LoadAddOn(name); end
    local loaded = select(2, IsAddOnLoaded(name))
    callbackFn(loaded, info)
end



