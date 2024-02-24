--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local sformat = string.format

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
--- @type LibStub
local LibStub = LibStub
local MAJOR_VERSION = 'Kapresoft-LibFactoryMixin-1.0'
local logPrefix = '{{Kapresoft-LibFactoryMixin}}:'

if select(2, ...) then
    --- @type Kapresoft_LibUtil
    local LibUtil = select(2, ...).Kapresoft_LibUtil
    logPrefix = LibUtil.CH:CreateLogPrefix('LibFactoryMixin')
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
--- local libFactory = LibFactoryMixin:New(libNames)
--- ---@type <ObjectType>
--- local aceLib = libFactory:GetObjects()
--- local aceAddon = aceLib.AceAddon
--- ```
---@class Kapresoft_LibFactoryMixin
local L = LibStub:NewLibrary(MAJOR_VERSION, 2); if not L then return end
L.mt = { __tostring = function() return MAJOR_VERSION .. '.' .. LibStub.minors[MAJOR_VERSION]  end }
setmetatable(L, L.mt)

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
local function fmtRed(val) return sformat("|cFFFF0000 %s |r", val or '') end
local function assertLibName(prefix, libName, varToAssert)
    assert(varToAssert, prefix .. fmtRed(' ERROR ') .. sformat('The library name [%s] is invalid.Is it registered in Kapresoft Library.lua?', libName))
end
local function handleIfLibFailed(success, prefix, libName, libNameMajor)
    if success then return end
    print(sformat('%s %s LibFactoryMixin:: Failed to load library MajorVersion=%s ModuleName=%s', prefix, fmtRed('ERROR'), tostring(libNameMajor), tostring(libName)))
end

---@param anyTable Kapresoft_LibUtil_LibFactoryMixin
local function LibStubLazyLoad(anyTable, libName)
    assert(libName, logPrefix .. 'Library name is required.')
    --- @class _AnyInstance : Kapresoft_LibUtil_LibFactoryMixin
    local mixinInstance = anyTable.mixinInstance
    local libNameMajor = mixinInstance.libNames[libName]
    assertLibName(logPrefix, libName, libNameMajor)

    local success, libInstanceOrErrorMsg = pcall(LibStub, libNameMajor)
    handleIfLibFailed(success, logPrefix, libName, libNameMajor)
    if not success then return nil end

    local libInstance = libInstanceOrErrorMsg
    if (Kapresoft_LibUtil_LogLevel_LibFactory or 0) >= 10 then
        print(sformat("%s Loaded[%s] %s", logPrefix, tostring(libNameMajor), tostring(libInstance)))
    end
    return libInstance
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
--- Called Automatically by Mixin upon creation
--- @param libNames table
--- @param nameGeneratorFunction function(libName:string)
function L:Init(libNames, nameGeneratorFunction)
    assert('table' == type(libNames), logPrefix .. 'libNames arg is required')
    self.libNames = {}

    if K_Constants:TableSize(libNames)  > 0 then
        if 'function' == type(nameGeneratorFunction) then
            for k, v in pairs(libNames) do
                local libNameGen = nameGeneratorFunction(v)
                if (Kapresoft_LibUtil_LogLevel_LibFactory or 0) >= 10 then
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
---@param o Kapresoft_LibFactoryMixin
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
        return K_Constants:CreateAndInitFromMixin(L, ...)
    end
    --- @return Kapresoft_LibUtil_AceLibraryObjects
    function o:GetObjects() return self.objects end
end

Methods(L)
