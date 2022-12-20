--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format
--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local MAJOR, MINOR = "Kapresoft-LibUtil-Constants-1.0", 1

local LibStub = LibStub
local libPrefix = 'Kapresoft-LibUtil'

---Colors are in hex
local consoleColors = {
    primary   = 'e3caaf',
    secondary = 'fbeb2d',
    tertiary = 'ffffff'
}

---@class Kapresoft_LibUtil_Constants
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded and no upgrade necessary
if not L then return end

---@param o Kapresoft_LibUtil_Constants
local function PropertiesAndMethods(o)
    function o:FormatColor(color, text) return sformat('|cfd%s%s|r', color, text) end
    function o:PrimaryColor(text) return self:FormatColor(consoleColors.primary, text)  end
    function o:SecondaryColor(text) return self:FormatColor(consoleColors.secondary, text)  end

    --- Generate the colorized Log Prefix
    --- @param module string The module name
    function o:CreateLogPrefix(module)
        return sformat('%s::%s:', self:PrimaryColor(libPrefix), self:SecondaryColor(module))
    end

    ---@param optionalVersion number
    ---@param moduleName string
    function o:LibName(moduleName, optionalVersion)
        local moduleVersion = optionalVersion or '1.0'
        return libPrefix .. '-' .. moduleName .. '-' .. tostring(moduleVersion)
    end
    --- @param optionalVersion number
    --- @param moduleName string
    function o:KLibStub(moduleName, optionalVersion)
        return LibStub(self:LibName(moduleName, optionalVersion))
    end
end

PropertiesAndMethods(L)

--[[-----------------------------------------------------------------------------
Global Method
-------------------------------------------------------------------------------]]
---@type Kapresoft_LibUtil_Constants
Kapresoft_LibUtil_Constants = LibStub(MAJOR, MINOR)
