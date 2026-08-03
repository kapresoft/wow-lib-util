--- @type string, AddonNamespace
local addon, cns = ...
cns.addon = addon

--- @class Kapresoft_LibUtil_2_0_Namespace : AddonNamespace
--- @field gameVersion any
local ns = cns

local L = LibStub('AceLocale-3.0'):NewLocale(addon, "enUS", true);

local TimeUtil = LibStub('Kapresoft-TimeUtil-2-0')
local CF = LibStub('Kapresoft-ColorFormatter-2-0')
local AddonInfoUtil = LibStub('Kapresoft-AddonInfoUtil-2-0')

local c1 = CF:ColorFn('FF6E5B')
local c2 = CF:ColorFn('5EC1FF')

--- Get the timestamp
--- @return (string|osdate)?
local function ts() return ('[%s]'):format(TimeUtil:NowInHoursMinSeconds()) end

--[[-----------------------------------------------------------------------------
Addon
-------------------------------------------------------------------------------]]

--- @class Kapresoft_LibUtil_2_0 : AceAddon, AceEvent-3.0, AceConsole-3.0
local o = LibStub('AceAddon-3.0'):NewAddon(ns.addon, "AceEvent-3.0", "AceConsole-3.0")
LIBUTIL = o

--- @type Kapresoft-AddonInfoUtil-2-0
local addonInfo = AddonInfoUtil:New(addon)

--[[-----------------------------------------------------------------------------
Slash Command: /libutil
-------------------------------------------------------------------------------]]
local function PrintAvailableCommands()
  print('Available commands:')
  print('  info:  prints info')
end

local function HandleSlashCommand(input)
  local cmd = (input or ''):trim():lower()
  if cmd == 'info' then
    print(addonInfo:GetInfoSlashCommandText())
  else
    PrintAvailableCommands()
  end
end

function o:OnInitialize()
  self:RegisterChatCommand('libutil', HandleSlashCommand)
end

--@do-not-package@
C_Timer.After(1, function()
  local author = C_AddOns.GetAddOnMetadata(addon, "Author")
  print(('%s {{%s}}: %s by %s is loaded.'):format(ts(), c1(addon), c2(addon), author))
end)
--@end-do-not-package@