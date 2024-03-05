--- @type Kapresoft_Base_Namespace
local ns = select(2, ...)
local LU = ns.Kapresoft_LibUtil
local O, M = LU.Objects, LU.M
local LibStub = LU.LibStub

local ModuleName = M.NamespaceKapresoftLibMixin
local pformat = ns.Kapresoft_LibUtil.pformat

--[[-----------------------------------------------------------------------------
Type: LibPackMixin
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_NamespaceKapresoftLibMixin
local L = LibStub:NewLibrary(ModuleName, 1)

-- return if already loaded (this object can exist in other addons)
if not L then return end

---@param o Kapresoft_LibUtil_NamespaceKapresoftLibMixin
local function MethodsAndProps(o)

    --- @return Kapresoft_LibUtil
    function o:K() return ns.Kapresoft_LibUtil end
    --- @return Kapresoft_LibUtil_Objects
    function o:KO() return ns.Kapresoft_LibUtil.Objects  end

    --- @return Kapresoft_LibUtil_SequenceMixin
    --- @param startingSequence number|nil
    function o:CreateSequence(startingSequence)
        return self:KO().SequenceMixin:New(startingSequence)
    end

end; MethodsAndProps(L)
