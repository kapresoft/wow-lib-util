---This is a customized version of Mixin based of Blizzards Mixin.lua
--- @see also Blizzard's Interface/SharedXML/Mixin.lua
--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type LibStub
local LibStub = LibStub
local MIXIN_OBJ_REQUIRED_MSG = "Can't mixin to a nil object in Mixin(object, ...)"

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local MAJOR_VERSION = 'Kapresoft-LibUtil-BaseMixin-1.0'
--- @class Kapresoft_LibUtil_BaseMixin
local L = LibStub:NewLibrary(MAJOR_VERSION, 1); if not L then return end
L.mt = { __tostring = function() return MAJOR_VERSION .. '.' .. LibStub.minors[MAJOR_VERSION]  end }
setmetatable(L, L.mt)

--- ```
--- local newInstance = Mixin({}, Mixin1, Mixin2, MixinN)
--- // or
--- local existingObj = {}
--- local newInstance = Mixin(existingObj, Mixin1, Mixin2, MixinN)
--- ```
--- @see BlizzardInterfaceCode:Interface/SharedXML/Mixin.lua
--- @param object any The target object
--- @vararg any The objects to mixin
function L:Mixin(object, ...)
    for i = 1, select("#", ...) do
        local mixin = select(i, ...)
        for k, v in pairs(mixin) do
            object[k] = v
        end
    end

    return object
end


--- ```
--- local Mixin1 = { 'properties and methods' }
--- local Mixin2 = { 'properties and methods' }
--- local newInstance = CreateFromMixins(Mixin1, Mixin2, MixinN)
--- ```
--- @vararg any The mixins
function L:CreateFromMixins(...) return self:Mixin({}, ...) end

---```
--- Makes a new Mixin instance and calls the <new-instance>:Init(arg1, argN, ...)
--- local Mixin = { 'properties and methods' }
--- local MyObj = CreateAndInitFromMixin(Mixin, arg1, arg2, argN)
---```
--- @param mixin any The mixin
--- @vararg any The arguments to pass to the <new-instance>:Init(...) method
function L:CreateAndInitFromMixin(mixin, ...)
    if not mixin then error(MIXIN_OBJ_REQUIRED_MSG) end
    local o = self:Mixin({}, mixin)
    if o.Init then o:Init(...) end
    return o
end

