--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local _, ns = ...
local O, LibStub, M, pformat, LibUtil = ns.Kapresoft_LibUtil:LibPack()

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]

--- @param o Kapresoft_LibUtil_Incrementer
local function IncrementerMethods(o)

    --- @param customIncrement number
    --- @return number
    function o:next(customIncrement)
        self.n = self.n + (customIncrement or  self.increment)
        return self.n
    end
    --- @return number
    function o:get() return self.n end
    --- @return number
    function o:reset() self.n = self.startIndex; return self:get() end

end

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_Incrementer_Lib
local L = LibStub:NewLibrary(M.Incrementer, 2)
-- return if already loaded and no upgrade necessary
if not L then return end

--- @return Kapresoft_LibUtil_Incrementer
function L:New(start, increment)
    --- @class Kapresoft_LibUtil_Incrementer
    local o = {
        startIndex = start,
        n = start,
        increment = increment
    }
    IncrementerMethods(o)
    return o
end
