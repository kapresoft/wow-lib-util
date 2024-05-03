--[[-----------------------------------------------------------------------------
Type: CoreNamespace
-------------------------------------------------------------------------------]]
--- @class CoreNamespace : Kapresoft_Base_Namespace
--- @field gameVersion GameVersion
--- @field chatFrame ChatLogFrame

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
local ModuleName = M.CoreNamespaceMixin()

--[[-----------------------------------------------------------------------------
New Library
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_CoreNamespaceMixin
local L = LibStub:NewLibrary(ModuleName, 2); if not L then return end

--[[-----------------------------------------------------------------------------
Type: ChatLogFrameMixin
-------------------------------------------------------------------------------]]
local ChatLogFrameMixin = {}; do
    local m = ChatLogFrameMixin
    --- @param o CoreNamespace
    function m:Mixin(o)
        ------ @return ChatLogFrame
        function o:ChatFrame() return self.chatFrame end

        --- @return boolean
        function o:HasChatFrame() return self:ChatFrame() ~= nil end

        --- @return boolean
        function o:IsChatFrameTabShown()
            return self:HasChatFrame() and self:ChatFrame():IsShown()
        end
    end
end;

--[[-----------------------------------------------------------------------------
CoreNamespaceMixin
Usage: K:Mixin(any, KO.NamespaceAceLibraryMixin, ...)
-------------------------------------------------------------------------------]]
--- @see AceLibraryMixin.lua
--- @param o CoreNamespace
local function PropsAndMethods(o)

    o.sformat      = string.format
    o.pformat      = K.pformat

    local function ts() return o.sformat('[%s]', ns:TimeUtil():NowInHoursMinSeconds()) end

    -- global print/logger ('c')
    local function _LogFn(...)
        if ns:IsChatFrameTabShown() then
            return ns:ChatFrame():log(ts(), ...)
        end
        print(ts(), ...)
    end

    --- @param module Name
    local function _LogpFn(module, ...)
        if ns:IsChatFrameTabShown() then return ns:ChatFrame():log(ts(), module, ...) end
        print(ts(), module, ...)
    end

    local function _PrintFn(...)
        print(ts(), ...)
    end

    --- @param module Name
    local function _PrintpFn(module, ...)
        print(ts(), module, ...)
    end

    --- @return Kapresoft_LibUtil
    function o:K() return K end

    --- @return Kapresoft_LibUtil_Modules
    function o:KO() return KO end

    --- @return Kapresoft_LibUtil_SequenceMixin
    --- @param startingSequence number|nil
    function o:CreateSequence(startingSequence) return KO.SequenceMixin:New(startingSequence) end

    --- @param colorDef Kapresoft_LibUtil_ColorDefinition | Kapresoft_LibUtil_ColorDefinition2
    --- @return Kapresoft_LibUtil_ConsoleHelper
    function o:NewConsoleHelper(colorDef) return KO.Constants:NewConsoleHelper(colorDef) end

    --- @return Kapresoft_LibUtil_AceLibraryObjects
    function o:AceLibrary() return KO.AceLibrary.O end

    --- @return AceConfigDialog
    function o:AceConfigDialog() return self:AceLibrary().AceConfigDialog end

    --- @return AceDB
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

    --- @param moduleName Name | "libName"
    --- @return fun(...:any) : void
    function o:logfn(moduleName) return function(...) self.logp(moduleName, ...)  end end

    ---@param chatFrame ChatLogFrame
    function o:RegisterChatFrame(chatFrame) self.chatFrame = chatFrame end

    ---------------------------------------------------------------
    -- Print Functions --
    ---------------------------------------------------------------
    o.log   = _LogFn
    o.logp  = _LogpFn
    o.print = _PrintFn
    o.printp = _PrintpFn

    ChatLogFrameMixin:Mixin(o)

end; PropsAndMethods(L)

