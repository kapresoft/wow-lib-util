--- @alias cfFn fun(val:any) : string @A color formatter function

--- @class Kapresoft-ColorDefinition-2-0
--- @field primary colorRGBA
--- @field secondary colorRGBA
--- @field tertiary colorRGBA
--- @field util1 colorRGBA
--- @field util2 colorRGBA
--- @field info colorRGBA
--- @field warn colorRGBA
--- @field error colorRGBA
--- @field formatter fun(Color, string) : string

--- @alias Author string
--- @alias VersionText string
--- @alias CurseForgeUrl string
--- @alias IssuesUrl string
--- @alias RepoUrl string
--- @alias LastUpdateDate string
--- @alias WowInterfaceVersion string

--- @alias NeitherHelpOrHarmful boolean
--- @alias Helpful boolean
--- @alias Harmful boolean

--- @class AddOnMetaInfo
--- @field author Author
--- @field version VersionText
--- @field curseForge CurseForgeUrl
--- @field issues IssuesUrl
--- @field repo RepoUrl
--- @field lastUpdate LastUpdateDate
--- @field interfaceVersion WowInterfaceVersion

--[[-----------------------------------------------------------------------------
Chat Frame Interface
-------------------------------------------------------------------------------]]
--- @alias ChatLogFrame ChatLogFrameInterface | ChatFrame
--- @alias ChatFrameTab Button

--- @class DebugChatFrameOptionsInterface
--- @field addon string The addon name
--- @field chatFrameTabName string The name of the chat frame tab
--- @field font Font The blizzard font instance name
--- @field fontSize number
--- @field windowAlpha number
--- @field maxLines number
--- @field makeDefaultChatFrame boolean|nil
--- @field GetChatFrameTab fun(self:DebugChatFrameOptionsInterface, chatFrame:ChatFrame) : ChatFrameTab
--- @field GetChatFrameTabText fun(self:DebugChatFrameOptionsInterface, chatFrame:ChatFrame) : string

--- @class ChatLogFrameInterface
--- @field options DebugChatFrameOptionsInterface
--- @field prefix fun(self:ChatLogFrameInterface, module: string): string
--- @field log fun(self:ChatLogFrameInterface, ...: any)
--- @field logp fun(self:ChatLogFrameInterface, module: string, ...: any)
--- @field InitialTabSelection fun(self:ChatLogFrameInterface, selectDebugFrameInDock:boolean): void
--- @field IsSelected fun(self:ChatLogFrameInterface): boolean
--- @field IsTabShown fun(self:ChatLogFrameInterface): boolean
--- @field StartFlash fun(self:ChatLogFrameInterface, ...) : void
--- @field GetTab fun(self:ChatLogFrameInterface): ChatFrameTab
--- @field GetTabName fun(self:ChatLogFrameInterface): string
--- @field SelectInDock fun(self:ChatLogFrameInterface): void
--- @field SelectDefaultChatFrame fun(self:ChatLogFrameInterface): void
--- @field CloseTab fun(self:ChatLogFrameInterface): void
--- @field RestoreChatFrame fun(self:ChatLogFrameInterface, selectInDock:boolean): void
--- @field RestoreDefaultChatFrame fun(self:ChatLogFrameInterface): void
--- @field SetAsDefaultChatFrame fun(self:ChatLogFrameInterface, state:boolean) Setting to true will set the DebugChatFrame as the default chat frame
--- @field GetChatFrameTabText fun(self:ChatLogFrameInterface) : string
--- @field SetAsDefaultChatFrameIfConfigured fun(self:ChatLogFrameInterface)

--- @class DebugChatFrameInterface
--- @field New fun(self:DebugChatFrameInterface, ...:any) : ChatLogFrameInterface
