--[[-----------------------------------------------------------------------------
Blizzard Vars
-------------------------------------------------------------------------------]]
local EnableAddOn, DisableAddOn = EnableAddOn or C_AddOns.EnableAddOn, DisableAddOn or C_AddOns.DisableAddOn
local C_AddOns_GetAddOnEnableState = C_AddOns.GetAddOnEnableState

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local ns = select(2, ...)
local C = K_Constants
local sformat = string.format
local pformat = ns.Kapresoft_LibUtil.pformat

--- @type LibStub
local LibStub = LibStub

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local MAJOR_VERSION = 'Kapresoft-AddonUtil-1.0'
--- @class Kapresoft_AddonUtil
local L = LibStub:NewLibrary(MAJOR_VERSION, 1); if not L then return end
L.mt = { __tostring = function() return MAJOR_VERSION .. '.' .. LibStub.minors[MAJOR_VERSION]  end }
setmetatable(L, L.mt)

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

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
--- @param o Kapresoft_AddonUtil
local function PropsAndMethods(o)

    --- @param indexOrName IndexOrName
    --- @return Enabled
    function o:IsAddOnEnabled(indexOrName)
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
    function o:EnableAddOnForCharacter(name, charName)
        C:AssertType(name, 'string', 'AddonUtil:EnableAddOnForCharacter(name,charName)')

        charName = charName or UnitName("player")
        EnableAddOn(name, charName)
    end

    --- @param indexOrName IndexOrName The index from 1 to GetNumAddOns() or The name of the addon (as in TOC/folder filename), case insensitive.
    --- @return AddOnInfo
    function o:GetAddOnInfo(indexOrName)
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
    function o:LoadOnDemand(name, callbackFn)
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


end; PropsAndMethods(L)






