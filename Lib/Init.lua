--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local sformat = string.format
local LibPrefix = 'Kapresoft-LibUtil'

--- @type Kapresoft_Base_Namespace
local addOn, ns = ...

--[[-----------------------------------------------------------------------------
Kapresoft_LibUtil Initialization
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil
--- @field LibStub Kapresoft_LibUtil_LibStub Lazy loaded
--- @field Objects Kapresoft_LibUtil_Objects Lazy loaded
local LibUtil = {
    LibPrefix = LibPrefix,
    --- @type Kapresoft_LibUtil_Modules
    M = {},

    --- @type Kapresoft_LibUtil_ConsoleHelper
    CH = K_ConsoleHelper,

    LogLevel = Kapresoft_LibUtil_LogLevel or 0,
    --- @param self Kapresoft_LibUtil
    --- @param logLevel number A zero or positive number
    ShouldLog = function(self, logLevel) return self.LogLevel <= (logLevel or 0)  end,

    --- @param self Kapresoft_LibUtil
    --- @param moduleName string
    Lib = function(self, moduleName) return sformat('%s-%s-1.0', self.LibPrefix, moduleName) end,

    --- @type Kapresoft_LibUtil_LibStubMixin
    LibStubMixin = {},

    --- @type fun(fmt:string, ...)|fun(val:string)
    pformat = {},
}

local LibStubMixin = LibUtil:Lib('LibStubMixin')
local Library = LibUtil:Lib('Library')
local Mixin = LibUtil:Lib('Mixin')
local IncrementerBuilder = LibUtil:Lib('IncrementerBuilder')

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
local function InitLazyLoaders()
    local lazyLoaders = {
        --- @type Kapresoft_LibUtil_Objects
        Objects = function()
            local lib = LibStub(Library, true); return (lib and lib.Objects) or {}
        end,
        --- @type Kapresoft_LibUtil_LibStub
        LibStub = function() return LibStub(LibStubMixin):New(LibUtil.LibPrefix, 1.0) end
    }
    --- @param o Kapresoft_LibUtil The LibUtil instance
    local function LibStubLazyLoad(o, libName)
        if lazyLoaders[libName] then
            o[libName] = lazyLoaders[libName]()
            return o[libName]
        end
        return nil
    end

    LibUtil.mt = { __index = LibStubLazyLoad }
    setmetatable(LibUtil, LibUtil.mt)
end

--- Create a color formatter
--- @param color Color
--- @return fun(arg:any) : string The string wrapped in color code
local function cf(color)
    return function(arg) return color:WrapTextInColorCode(tostring(arg)) end
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]

--- Create a new color formatter function
--- @param color Color
function LibUtil:cf(color) return cf(color) end

--- @param callbackFn fun()
function LibUtil.After100ms(callbackFn) C_Timer.After(0.1, callbackFn) end

--- @param callbackFn fun()
function LibUtil.After300ms(callbackFn) C_Timer.After(0.3, callbackFn) end

--- @param callbackFn fun()
function LibUtil.After500ms(callbackFn) C_Timer.After(0.5, callbackFn) end

--- @param callbackFn fun()
function LibUtil.After1s(callbackFn) C_Timer.After(1, callbackFn) end

--- @alias ModuleName string |"'String'"|"'Table'"|"'Mixin'"|"'Assert'"|"'Safecall'"|"'Incrementer'"
--- @alias TargetLibraryMajorVersion string |"'Kapresoft-Table-1.0'"|"'Kapresoft-String-1.0'"|"'Kapresoft-Mixin-1.0'"|"'Kapresoft-Assert-1.0'"|
--- @param moduleName ModuleName Example: 'Table' or 'String'
--- @param moduleRevision number
--- @param targetLibraryMajorVersion TargetLibraryMajorVersion The target library major version
function LibUtil:CreateLibWrapper(moduleName, moduleRevision, targetLibraryMajorVersion)
    local W = self.LibStub:NewLibrary(moduleName, moduleRevision); if not W then return end
    local L = self.LibStub:LibStub(targetLibraryMajorVersion); if not L then return end
    getmetatable(W).__index = L
    getmetatable(W).__tostring = function()
        local majorVersion = self:Lib(moduleName)
        return majorVersion .. '.' .. LibStub.minors[majorVersion]
    end
    if (Kapresoft_LibUtil_LogLevel_LibWrapper or 0) > 10 then
        local prefix = self.CH:CreateLogPrefix('Init')
        print(prefix, moduleName .. ':', self.pformat({lib=tostring(L), wrapper=tostring(W)}))
    end
    return W
end

--- @see Similar Interface/SharedXML/Mixin.lua#Mixin(object, ...)
function LibUtil:Mixin(object, ...) return LibStub(Mixin):Mixin(object, ...) end

--- @see Similar Interface/SharedXML/Mixin.lua#CreateFromMixins(...)
function LibUtil:CreateFromMixins(...) return LibStub(Mixin):Mixin({}, ...) end

--- @see Similar Interface/SharedXML/Mixin.lua#CreateAndInitFromMixin(...)
function LibUtil:CreateAndInitFromMixin(mixin, ...)
    local object = self:CreateFromMixins(mixin);
    object:Init(...);
    return object;
end

--- @param start number
--- @param increment number
--- @return Kapresoft_LibUtil_IncrementerBuilder
function LibUtil:CreateIncrementer(start, increment) return LibStub(IncrementerBuilder):New(start, increment) end

--- ```
--- @type Kapresoft_Base_Namespace
--- local _, ns = ...
--- local O, LibStub, M, pformat, LibUtil = ns.Kapresoft_LibUtil:LibPack()
--- ```
--- @return Kapresoft_LibUtil_Objects, Kapresoft_LibUtil_LibStub, Kapresoft_LibUtil_Modules, fun(fmt:string, ...)|fun(val:string), Kapresoft_LibUtil
function LibUtil:LibPack() return self.Objects, self.LibStub, self.M, self.pformat, self end

--[[-----------------------------------------------------------------------------
Lazy Load
-------------------------------------------------------------------------------]]
InitLazyLoaders()

--[[-----------------------------------------------------------------------------
Add to Namespace
-------------------------------------------------------------------------------]]
ns.Kapresoft_LibUtil = LibUtil
