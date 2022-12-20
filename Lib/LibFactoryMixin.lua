Kapresoft_LibUtil_LogLevel=0
--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub = LibStub
local MAJOR, MINOR = "Kapresoft-LibUtil-LibFactoryMixin-1.0", 1
local C = Kapresoft_LibUtil_Constants
local logPrefix = C:CreateLogPrefix('LibFactoryMixin')
local Table = Kapresoft_LibUtil_Table()

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]

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

---@class Kapresoft_LibUtil_LibFactoryMixin
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded (this object can exist in other addons)
if not L then return end

---@param anyTable Kapresoft_LibUtil_LibFactoryMixin
local function LibStubLazyLoad(anyTable, libName)
    assert(libName, logPrefix .. 'Library name is required.')
    --- @class _AnyInstance : Kapresoft_LibUtil_LibFactoryMixin
    local mixinInstance = anyTable.mixinInstance
    local cache = mixinInstance.cache
    if not cache[libName] then
        cache[libName] = LibStub(mixinInstance.libNames[libName])
        if Kapresoft_LibUtil_LogLevel >= 10 then
            print(logPrefix, sformat("Loaded[%s]: %s",
                    tostring(libName), tostring(cache[libName])))
        end
    end
    return cache[libName]
end

--- Called Automatically by Mixin upon creation
--- @param libNames table
--- @param nameGeneratorFunction function(libName:string)
function L:Init(libNames, nameGeneratorFunction)
    assert('table' == type(libNames), logPrefix .. 'libNames arg is required')
    self.libNames = {}
    self.cache = {}

    if Table.size(libNames) > 0 then
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
    function o:New(...)
        ---Calls Init(...)
        return K_CreateAndInitFromMixin(L, ...)
    end
    function o:GetObjects() return self.objects end
end

Methods(L)

--[[-----------------------------------------------------------------------------
Global Method
-------------------------------------------------------------------------------]]
---@return Kapresoft_LibUtil_LibFactoryMixin
function Kapresoft_LibUtil_LibFactoryMixin() return LibStub(MAJOR, MINOR) end
