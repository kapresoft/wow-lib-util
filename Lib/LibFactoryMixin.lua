--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Blizzard Vars
-------------------------------------------------------------------------------]]
local CreateAndInitFromMixin = CreateAndInitFromMixin

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type Kapresoft_Base_Namespace
local _, ns = ...

--- The original LibStub
local LibStub = LibStub
local ModuleName = 'LibFactoryMixin'
local logPrefix = ns.Kapresoft_LibUtil.H:CreateLogPrefix(ModuleName)
local MAJOR, MINOR = sformat('Kapresoft-LibUtil-%s-1.0', ModuleName), 2

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
local function TableSize(t)
    if type(t) ~= 'table' then error(string.format("Expected arg to be of type table, but got: %s", type(t))) end
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
--- Usage:
--- ```
--- local libNames = { AceAddon = 'AceAddon-3.0' }
--- local Objects = {
---     ---@type AceAddon
---     AceAddon = nil
--- }
--- local libFactory = MixinAndInit(LibFactoryMixin, libNames)
--- ---@type <ObjectType>
--- local aceLib = libFactory:GetObjects()
--- local aceAddon = aceLib.AceAddon
--- ```

---@type Kapresoft_LibUtil_LibFactoryMixin
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded (this object can exist in other addons)
if not L then return end

---@param anyTable Kapresoft_LibUtil_LibFactoryMixin
local function LibStubLazyLoad(anyTable, libName)
    assert(libName, logPrefix .. 'Library name is required.')
    --- @class _AnyInstance : Kapresoft_LibUtil_LibFactoryMixin
    local mixinInstance = anyTable.mixinInstance
    local libNameMajor = mixinInstance.libNames[libName]
    local libInstance = LibStub(libNameMajor)
    if Kapresoft_LibUtil_LogLevel >= 10 then
        print(logPrefix, sformat("Loaded[%s]: %s",
                tostring(libNameMajor), tostring(libInstance)))
    end
    return libInstance
end

--- Called Automatically by Mixin upon creation
--- @param libNames table
--- @param nameGeneratorFunction function(libName:string)
function L:Init(libNames, nameGeneratorFunction)
    assert('table' == type(libNames), logPrefix .. 'libNames arg is required')
    self.libNames = {}

    if TableSize(libNames)  > 0 then
        if 'function' == type(nameGeneratorFunction) then
            for k, v in pairs(libNames) do
                local libNameGen = nameGeneratorFunction(v)
                if Kapresoft_LibUtil_LogLevel >= 10 then
                    print(logPrefix, 'libNameGenerator returned:', tostring(libNameGen))
                end
                self.libNames[k] = libNameGen
            end
        else
            self.libNames = libNames
        end
    end

    self.objects = {}
    self.objects.mixinInstance = self
    --- We want to be able to just do `Instance.<LibraryName>` to get the object
    self.objects.mt = { __index = LibStubLazyLoad }
    setmetatable(self.objects, self.objects.mt)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
---@param o Kapresoft_LibUtil_LibFactoryMixin
local function Methods(o)
    --- ### Usage 1
    --- ```
    --- local Names = { AceConsole = 'AceConsole-3.0' }
    --- local libFactory = LibFactoryMixin:New(Names:table)
    --- ```
    --- ### Usage 2: With a name generator function as a second argument
    --- ```
    --- local Names = { AceConsole = 'AceConsole' }
    --- local libFactory = LibFactoryMixin:New(Names:table, function(moduleName) return moduleName .. '-3.0') end)
    --- ```
    --- @vararg any
    --- @see Interface/SharedXML/Mixin.lua#CreateAndInitFromMixin
    --- @return Kapresoft_LibUtil_LibFactoryMixin
    function o:New(...)
        ---Calls Init(...)
        return CreateAndInitFromMixin(L, ...)
    end
    --- @return Kapresoft_LibUtil_AceLibraryObjects
    function o:GetObjects() return self.objects end
end

Methods(L)
