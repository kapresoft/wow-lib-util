--[[-----------------------------------------------------------------------------
Type: CoreNamespace
-------------------------------------------------------------------------------]]
--- @class CoreNamespace : Kapresoft_Base_Namespace
--- @field gameVersion GameVersion
--- @field pformat fun(fmt:string, ...)|fun(val:string)
--- @field sformat fun(fmt:string, ...)|fun(val:string)
--- @field log fun(...:any)
--- @field print fun(...:any)
--- @field logp fun(module:Name, ...:any)
--- @field chatFrame ChatLogFrameInterface

--[[-----------------------------------------------------------------------------
Namespace
-------------------------------------------------------------------------------]]
--- @type string
local addon
--- @type CoreNamespace
local ns

addon, ns = ...; ns.addon  = addon

--[[-----------------------------------------------------------------------------
Local Variables
-------------------------------------------------------------------------------]]
local K = ns.Kapresoft_LibUtil
local KO, M = K.Objects, K.M
local LibStub = K.LibStub
local ModuleName = M.CoreNamespaceMixin

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_CoreNamespaceMixin
local L = LibStub:NewLibrary(ModuleName, 1); if not L then return end

--[[-----------------------------------------------------------------------------
CoreNamespaceMixin
Usage: K:Mixin(any, KO.NamespaceAceLibraryMixin, ...)
-------------------------------------------------------------------------------]]
--- @see AceLibraryMixin.lua
--- @param o CoreNamespace
local function PropsAndMethods(o)

    o.sformat      = string.format
    o.pformat      = K.pformat

    --- @return Kapresoft_LibUtil
    function o:K() return K end

    --- @return Kapresoft_LibUtil_Objects
    function o:KO() return KO end

    --- @return Kapresoft_LibUtil_SequenceMixin
    --- @param startingSequence number|nil
    function o:CreateSequence(startingSequence) return KO.SequenceMixin:New(startingSequence) end

    --- @param colorDef Kapresoft_LibUtil_ColorDefinition | Kapresoft_LibUtil_ColorDefinition2
    --- @return Kapresoft_LibUtil_ConsoleHelper
    function o:NewConsoleHelper(colorDef) return KO.Constants:NewConsoleHelper(colorDef) end

    --- @return Kapresoft_LibUtil_AceLibraryObjects
    function o:AceLibrary() return KO.AceLibrary.O end

    function o:AceConfigDialog() return self:AceLibrary().AceConfigDialog end
    function o:AceDB() return self:AceLibrary().AceDB end

    --- @return Kapresoft_LibUtil_Assert
    function o:Assert() return KO.Assert end

    --- @return Kapresoft_LibUtil_ColorUtil
    function o:ColorUtil() return KO.ColorUtil end

    --- @return Kapresoft_LibUtil_Safecall
    function o:Safecall() return KO.Safecall end

    --- @return Kapresoft_LibUtil_String
    function o:String() return KO.String end

    --- @return Kapresoft_LibUtil_Table
    function o:Table() return KO.Table end

    --- @return Kapresoft_LibUtil_TimeUtil
    function o:TimeUtil() return KO.TimeUtil end

    --- @return GameVersion
    function o:IsVanilla() return self.gameVersion == 'classic' end
    --- @return GameVersion
    function o:IsTBC() return self.gameVersion == 'tbc_classic' end
    --- @return GameVersion
    function o:IsWOTLK() return self.gameVersion == 'wotlk_classic' end
    --- @return GameVersion
    function o:IsCataclysm() return self.gameVersion == 'cataclysm_classic' end
    --- @return GameVersion
    function o:IsRetail() return self.gameVersion == 'retail' end

    ---@param namesp CoreNamespace
    function o:RegisterChatFrame(namesp, chatFrame)
        namesp.chatFrame = chatFrame
        namesp.log     = function(...) namesp.chatFrame:log(...) end
        namesp.logp    = function(module, ...) namesp.chatFrame:logp(module, ...) end
        namesp.print   = namesp.log
    end

    ---------------------------------------------------------------
    -- Print Functions --
    ---------------------------------------------------------------
    o.print = print
    o.log   = o.print
    o.logp  = function(module, ...) print(module, ...) end

end; PropsAndMethods(L)
