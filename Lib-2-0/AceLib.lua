--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-AceLib-2-0', 1

--- @class Kapresoft_AceLib_2_0
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
S.mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR] end }
setmetatable(S, S.mt)

--- @type Kapresoft_AceLib_2_0
local o = S

--- @return AceAddon_3_0
function o:AceAddon() return LibStub('AceAddon-3.0') end

--- @return AceBucket_3_0
function o:AceBucket() return LibStub('AceBucket-3.0') end

--- @return AceConfig_3_0
function o:AceConfig() return LibStub('AceConfig-3.0') end

--- @return AceConfigDialog_3_0
function o:AceConfigDialog() return LibStub('AceConfigDialog-3.0') end

--- @return AceConfigRegistry_3_0
function o:AceConfigRegistry() return LibStub('AceConfigRegistry-3.0') end

--- @return AceConsole_3_0
function o:AceConsole() return LibStub('AceConsole-3.0') end

--- @return AceDB_3_0
function o:AceDB() return LibStub('AceDB-3.0') end

--- @return AceDBOptions_3_0
function o:AceDBOptions() return LibStub('AceDBOptions-3.0') end

--- @return AceEvent_3_0
function o:AceEvent() return LibStub('AceEvent-3.0') end

--- @return AceGUI_3_0
function o:AceGUI() return LibStub('AceGUI-3.0') end

--- @return AceHook_3_0
function o:AceHook() return LibStub('AceHook-3.0') end

--- @return AceLocale_3_0
function o:AceLocale() return LibStub('AceLocale-3.0') end
