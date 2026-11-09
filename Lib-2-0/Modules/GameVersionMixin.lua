--[[-----------------------------------------------------------------------------
Notes:
-------------------------------------------------------------------------------]]
--- For additional info, @see Blizzard_FrameXMLBase/Cata/Constants.lua
-- WOW_PROJECT_MAINLINE = 1;
-- WOW_PROJECT_CLASSIC = 2;
-- WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5;
-- WOW_PROJECT_WRATH_CLASSIC = 11;
-- WOW_PROJECT_CATACLYSM_CLASSIC = 14;
-- WOW_PROJECT_CAMELOT = 18; (WoW Forever only)
-- WOW_PROJECT_MISTS_CLASSIC = 19;
-- WOW_PROJECT_ID = WOW_PROJECT_CATACLYSM_CLASSIC;

--- @deprecated Use the Is* methods
--- @alias Kapresoft-GameVersion-2-0 string | "classic-era" | "tbc" | "wotlk" | "cataclysm" | "mists" | "mainline"

--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version
-- 3: IsForever(); Is* methods treat Forever as retail code;
--    IsMainline() checks the client, not self.gameVersion
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-GameVersionMixin-2-0', 3

--- @class Kapresoft-GameVersionMixin-2-0 A mixin for WoW versions
--- @field gameVersion string @deprecated Use the Is* methods
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
local mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR] end }
setmetatable(S, mt)

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
local function IsForever() return WOW_PROJECT_ID == WOW_PROJECT_CAMELOT end

--- @param exp number @LE_EXPANSION_* constant
--- @return boolean
local function LevelIs(exp)
  if IsForever() then return false end
  return LE_EXPANSION_LEVEL_CURRENT == exp
end

--- @param exp number @LE_EXPANSION_* constant
--- @return boolean
local function LevelAtLeast(exp)
  if IsForever() then return true end
  return LE_EXPANSION_LEVEL_CURRENT >= exp
end

--- @param exp number @LE_EXPANSION_* constant
--- @return boolean
local function LevelAtMost(exp)
  if IsForever() then return false end
  return LE_EXPANSION_LEVEL_CURRENT <= exp
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local o = S

--- @deprecated Use the Is* methods
o.GAME_VERSION_CLASSIC_ERA = "classic-era"
--- @deprecated Use the Is* methods
o.GAME_VERSION_TBC         = "tbc"
--- @deprecated Use the Is* methods
o.GAME_VERSION_WOTLK       = "wotlk"
--- @deprecated Use the Is* methods
o.GAME_VERSION_CATACLYSM   = "cataclysm"
--- @deprecated Use the Is* methods
o.GAME_VERSION_MISTS       = "mists"
--- @deprecated Use the Is* methods
o.GAME_VERSION_MAINLINE    = "mainline"

--- WoW Forever (game type camelot). Runs retail code, so the
--- Is* methods ignore LE_EXPANSION_LEVEL_CURRENT here.
--- @return boolean
function o:IsForever() return IsForever() end

--- See Also: [ExpansionLevel](https://warcraft.wiki.gg/wiki/ExpansionLevel)
--- @return boolean
function o:IsClassicEra() return LevelIs(LE_EXPANSION_CLASSIC) end

--- @return boolean
function o:IsTBC() return LevelIs(LE_EXPANSION_BURNING_CRUSADE) end
--- @return boolean
function o:IsTBCOrLater() return LevelAtLeast(LE_EXPANSION_BURNING_CRUSADE) end
--- @return boolean
function o:IsTBCOrEarlier() return LevelAtMost(LE_EXPANSION_BURNING_CRUSADE) end

--- @return boolean
function o:IsWOTLK() return LevelIs(LE_EXPANSION_WRATH_OF_THE_LICH_KING) end
--- @return boolean
function o:IsWOTLKOrEarlier() return LevelAtMost(LE_EXPANSION_WRATH_OF_THE_LICH_KING) end
--- @return boolean
function o:IsWOTLKOrLater() return LevelAtLeast(LE_EXPANSION_WRATH_OF_THE_LICH_KING) end

--- @return boolean
function o:IsCata() return LevelIs(LE_EXPANSION_CATACLYSM) end
--- @return boolean
function o:IsCataOrEarlier() return LevelAtMost(LE_EXPANSION_CATACLYSM) end
--- @return boolean
function o:IsCataOrLater() return LevelAtLeast(LE_EXPANSION_CATACLYSM) end

--- @return boolean
function o:IsMists() return LevelIs(LE_EXPANSION_MISTS_OF_PANDARIA) end
--- @return boolean
function o:IsMistsOrEarlier() return LevelAtMost(LE_EXPANSION_MISTS_OF_PANDARIA) end
--- @return boolean
function o:IsMistsOrLater() return LevelAtLeast(LE_EXPANSION_MISTS_OF_PANDARIA) end

--- @return boolean
function o:IsDraenor() return LevelIs(LE_EXPANSION_WARLORDS_OF_DRAENOR) end
--- @return boolean
function o:IsDraenorOrEarlier() return LevelAtMost(LE_EXPANSION_WARLORDS_OF_DRAENOR) end
--- @return boolean
function o:IsDraenorOrLater() return LevelAtLeast(LE_EXPANSION_WARLORDS_OF_DRAENOR) end

--- @return boolean
function o:IsLegion() return LevelIs(LE_EXPANSION_LEGION) end
--- @return boolean
function o:IsLegionOrEarlier() return LevelAtMost(LE_EXPANSION_LEGION) end
--- @return boolean
function o:IsLegionOrLater() return LevelAtLeast(LE_EXPANSION_LEGION) end

--- @return boolean
function o:IsBFA() return LevelIs(LE_EXPANSION_BATTLE_FOR_AZEROTH) end
--- @return boolean
function o:IsBFAOrEarlier() return LevelAtMost(LE_EXPANSION_BATTLE_FOR_AZEROTH) end
--- @return boolean
function o:IsBFAOrLater() return LevelAtLeast(LE_EXPANSION_BATTLE_FOR_AZEROTH) end

--- @return boolean
function o:IsShadowlands() return LevelIs(LE_EXPANSION_SHADOWLANDS) end
--- @return boolean
function o:IsShadowlandsOrEarlier() return LevelAtMost(LE_EXPANSION_SHADOWLANDS) end
--- @return boolean
function o:IsShadowlandsOrLater() return LevelAtLeast(LE_EXPANSION_SHADOWLANDS) end

--- @return boolean
function o:IsDragonflight() return LevelIs(LE_EXPANSION_DRAGONFLIGHT) end
--- @return boolean
function o:IsDragonflightOrEarlier() return LevelAtMost(LE_EXPANSION_DRAGONFLIGHT) end
--- @return boolean
function o:IsDragonflightOrLater() return LevelAtLeast(LE_EXPANSION_DRAGONFLIGHT) end

--- @return boolean
function o:IsWarWithin() return LevelIs(LE_EXPANSION_WAR_WITHIN) end
--- @return boolean
function o:IsWarWithinOrEarlier() return LevelAtMost(LE_EXPANSION_WAR_WITHIN) end
--- @return boolean
function o:IsWarWithinOrLater() return LevelAtLeast(LE_EXPANSION_WAR_WITHIN) end

--- Retail code base: retail (Mainline) or WoW Forever
--- @return boolean
function o:IsMainline() return WOW_PROJECT_ID == WOW_PROJECT_MAINLINE or IsForever() end

--- Alias of IsMainline()
--- @return boolean
function o:IsRetail() return self:IsMainline() end
