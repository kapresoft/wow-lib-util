--[[-----------------------------------------------------------------------------
Notes:
-------------------------------------------------------------------------------]]
--- For additional info, @see Blizzard_FrameXMLBase/Cata/Constants.lua
-- WOW_PROJECT_MAINLINE = 1;
-- WOW_PROJECT_CLASSIC = 2;
-- WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5;
-- WOW_PROJECT_WRATH_CLASSIC = 11;
-- WOW_PROJECT_CATACLYSM_CLASSIC = 14;
-- WOW_PROJECT_MISTS_CLASSIC = 19;
-- WOW_PROJECT_ID = WOW_PROJECT_CATACLYSM_CLASSIC;

--- @alias Kapresoft-GameVersion-2-0 string | "classic-era" | "tbc" | "wotlk" | "cataclysm" | "mists" | "mainline"

--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-GameVersionMixin-2-0', 2

--- @class Kapresoft-GameVersionMixin-2-0 A mixin for WoW versions
--- @field gameVersion string @deprecated Use methods that does not use self.gameVersion
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
local mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR] end }
setmetatable(S, mt)

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local o = S

o.GAME_VERSION_CLASSIC_ERA = "classic-era"
o.GAME_VERSION_TBC         = "tbc"
o.GAME_VERSION_WOTLK       = "wotlk"
o.GAME_VERSION_CATACLYSM   = "cataclysm"
o.GAME_VERSION_MISTS       = "mists"
o.GAME_VERSION_MAINLINE    = "mainline"

--- See Also: [ExpansionLevel](https://warcraft.wiki.gg/wiki/ExpansionLevel)
--- @return boolean
function o:IsClassicEra() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CLASSIC end

--- @return boolean
function o:IsTBC() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE end
--- @return boolean
function o:IsTBCOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_BURNING_CRUSADE end
--- @return boolean
function o:IsTBCOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_BURNING_CRUSADE end

--- @return boolean
function o:IsWOTLK() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING end
--- @return boolean
function o:IsWOTLKOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_WRATH_OF_THE_LICH_KING end
--- @return boolean
function o:IsWOTLKOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WRATH_OF_THE_LICH_KING end

--- @return boolean
function o:IsCata() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_CATACLYSM end
--- @return boolean
function o:IsCataOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_CATACLYSM end
--- @return boolean
function o:IsCataOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_CATACLYSM end

--- @return boolean
function o:IsMists() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_MISTS_OF_PANDARIA end
--- @return boolean
function o:IsMistsOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_MISTS_OF_PANDARIA end
--- @return boolean
function o:IsMistsOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_MISTS_OF_PANDARIA end

--- @return boolean
function o:IsDraenor() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WARLORDS_OF_DRAENOR end
--- @return boolean
function o:IsDraenorOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_WARLORDS_OF_DRAENOR end
--- @return boolean
function o:IsDraenorOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WARLORDS_OF_DRAENOR end

--- @return boolean
function o:IsLegion() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_LEGION end
--- @return boolean
function o:IsLegionOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_LEGION end
--- @return boolean
function o:IsLegionOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_LEGION end

--- @return boolean
function o:IsBFA() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BATTLE_FOR_AZEROTH end
--- @return boolean
function o:IsBFAOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_BATTLE_FOR_AZEROTH end
--- @return boolean
function o:IsBFAOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_BATTLE_FOR_AZEROTH end

--- @return boolean
function o:IsShadowlands() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_SHADOWLANDS end
--- @return boolean
function o:IsShadowlandsOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_SHADOWLANDS end
--- @return boolean
function o:IsShadowlandsOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_SHADOWLANDS end

--- @return boolean
function o:IsDragonflight() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_DRAGONFLIGHT end
--- @return boolean
function o:IsDragonflightOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_DRAGONFLIGHT end
--- @return boolean
function o:IsDragonflightOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_DRAGONFLIGHT end

--- @return boolean
function o:IsWarWithin() return LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WAR_WITHIN end
--- @return boolean
function o:IsWarWithinOrEarlier() return LE_EXPANSION_LEVEL_CURRENT <= LE_EXPANSION_WAR_WITHIN end
--- @return boolean
function o:IsWarWithinOrLater() return LE_EXPANSION_LEVEL_CURRENT >= LE_EXPANSION_WAR_WITHIN end

--- @deprecated Use methods that does not use self.gameVersion
--- @return boolean
function o:IsMainline() return self.gameVersion == o.GAME_VERSION_MAINLINE end

--- @deprecated Use methods that does not use self.gameVersion
--- @return boolean
function o:IsRetail() return self:IsMainline() end
