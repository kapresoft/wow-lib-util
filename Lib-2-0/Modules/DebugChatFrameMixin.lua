--[[-----------------------------------------------------------------------------
VERSION:: Bump MINOR_VERSION whenever a change occurs
-- 1: initial version
-- 2: SetChatFrameFontSize accepts Blizzard's chat font sizes
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = 'Kapresoft-DebugChatFrameMixin-2-0', 2

--- @class Kapresoft-DebugChatFrameMixin-2-0
--- @field chatFrame ChatLogFrame
local S = LibStub:NewLibrary(MAJOR, MINOR); if not S then return end
local mt = { __tostring = function() return MAJOR .. '.' .. LibStub.minors[MAJOR] end }
setmetatable(S, mt)

--[[-----------------------------------------------------------------------------
Type: DebugChatFrameMixin
-------------------------------------------------------------------------------]]
local o = S

local MIN_FONT_SIZE, MAX_FONT_SIZE = 10, 32
local FONT_SIZE_ERR_MSG = ('Invalid:: Font size must be from %s to %s'):format(MIN_FONT_SIZE, MAX_FONT_SIZE)

--- @return ChatLogFrame
function o:ChatFrame() return self.chatFrame end

--- @return boolean
function o:HasChatFrame() return self:ChatFrame() ~= nil end

--- @return boolean
function o:IsChatFrameTabShown()
  return self:HasChatFrame() and self:ChatFrame():IsShown()
end

--- Set the Font Size of the ChatFrame Console
--- @param fontSize number? @Covers Blizzard's CHAT_FONT_HEIGHTS; nil uses the default
function o:SetChatFrameFontSize(fontSize)
  if not self.chatFrame then return end

  local size = fontSize or 14
  assert(size >= MIN_FONT_SIZE and size <= MAX_FONT_SIZE, FONT_SIZE_ERR_MSG)
  local font, _, outline = self.chatFrame:GetFont()
  return font and self.chatFrame:SetFont(font, size, outline)
end

---@param chatFrame ChatLogFrame
function o:RegisterChatFrame(chatFrame) self.chatFrame = chatFrame end
