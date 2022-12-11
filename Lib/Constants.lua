local LibStub = LibStub
local libPrefix = 'Kapresoft-LibUtil'

---@class Kapresoft_LibUtil_Constants
local L = {
    ---@param optionalVersion number
    ---@param moduleName string
    ---@param self Kapresoft_LibUtil_Constants
    LibName = function(self, moduleName, optionalVersion)
        local moduleVersion = optionalVersion or 1.0
        return libPrefix .. '-' .. moduleName .. '-' .. tostring(moduleVersion)
    end
}
---@param optionalVersion number
---@param moduleName string
function L:KLibStub(moduleName, optionalVersion)
    return LibStub(self:LibName(moduleName, optionalVersion))
end

---@type Kapresoft_LibUtil_Constants
Kapresoft_LibUtil_Constants = L
