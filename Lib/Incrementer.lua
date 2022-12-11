local LibStub = LibStub
local MAJOR, MINOR = "Kapresoft-LibUtil-Incrementer-1.0", 1

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]

---@param o Kapresoft_LibUtil_Incrementer
local function IncrementerMethods(o)

    ---@param customIncrement number
    ---@return number
    function o:next(customIncrement)
        self.n = self.n + (customIncrement or  self.increment)
        return self.n
    end
    ---@return number
    function o:get() return self.n end
    ---@return number
    function o:reset() self.n = self.startIndex; return self:get() end

end

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded and no upgrade necessary
if not L then return end

---@return Kapresoft_LibUtil_Incrementer
function L:Create(start, increment)
    ---@class Kapresoft_LibUtil_Incrementer
    local o = {
        startIndex = start,
        n = start,
        increment = increment
    }
    IncrementerMethods(o)
    return o
end

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@param start number
---@param increment number
---@return Kapresoft_LibUtil_Incrementer
function Kapresoft_LibUtil_CreateIncrementer(start, increment)
    return L:Create(start, increment)
end
