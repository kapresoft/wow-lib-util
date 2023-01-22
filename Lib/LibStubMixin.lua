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
--- @type LibStub
local LibStub = LibStub

--- @type Kapresoft_Base_Namespace
local _, ns = ...

--[[-----------------------------------------------------------------------------
Class Interface
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_LibStubMixin
local _LibStubMixin_Interface = {}

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
local ModuleName = 'LibStubMixin'
local logPrefix = ns.Kapresoft_LibUtil.H:CreateLogPrefix(ModuleName)
local MAJOR, MINOR = sformat('Kapresoft-LibUtil-%s-1.0', ModuleName), 1

--- @type Kapresoft_LibUtil_LibStubMixin
local L = LibStub:NewLibrary(MAJOR, MINOR)
if not L then return end

--[[-----------------------------------------------------------------------------
Support Functions
-------------------------------------------------------------------------------]]
-- /dump tostring(nil):match("^%d+%.%d+$")
-- /dump tostring(nil):match("^%d+$")
--- @param version number
--- @return string The version text
local function ResolveVersionString(version)
    local versionText = tostring(version)
    if versionText:match("^%d+$") then return version .. '.0' end
    if versionText:match("^%d+%.%d+$") then return versionText end
    return '1.0'
end

--- @param o Kapresoft_LibUtil_LibStubMixin
local function PropsAndMethods(o)

    --- #### Usage
    --- `local LocalLibStub = ns.LibStubMixin:New('MyAddonName', 1.0)`
    --- @see BlizzardInterfaceCode: Interface/SharedXML/Mixin.lua
    --- @param name string This is usually the AddOn name
    --- @param version number|string A decimal number, i.e. 1.0, 1.1, 2.0, 3.0
    --- @param postConstructFn PostConstructHandler | "function(libName, newLibInstance) print('Name:', libName) end"
    function o:New(name, version, postConstructFn) return CreateAndInitFromMixin(L, name, version, postConstructFn) end

    --- @param name string This is usually the AddOn name
    --- @param version number|string A decimal number, i.e. 1.0, 1.1, 2.0, 3.0
    --- @param postConstructFn PostConstructHandler | "function(libName, newLibInstance) print("Name:", libName) end"
    function o:Init(name, version, postConstructFn)
        local actualVersion = ResolveVersionString(version)

        assert(name, "LibStub library name is required, i.e. <AddOnName>")

        self.name = name
        self.versionFormat = self.name .. '-%s-' .. actualVersion
        self.version = actualVersion
        self.postConstructFn = postConstructFn
        self.LibStubAce = LibStub

        self.mt = {
            __call = function (_, ...) return self:GetLibrary(...) end,
            __tostring = function() return self.name .. '::LibStubMixin'  end
        }
        setmetatable(self, self.mt)
    end

    --- #### Local Lib
    --- ```
    --- local logger = LocalLibStub('Logger')
    --- ```
    --- ####  Ace3 Lib
    --- ```
    --- local console = LocalLibStub('Ace-Console-1.0', true)
    --- ```
    --- #### Get a library with literal library name
    --- ```
    --- local console = LocalLibStub:GetLibrary('Ace-Console-1.0', true)
    --- ```
    --- OR
    --- ```
    --- local console = LocalLibStub:LibStub('Ace-Console-1.0')
    --- ```
    --- @param isExternalLib boolean if true, then calls LibStub directly
    function o:GetLibrary(libName, isExternalLib)
        -- print('LibStubMixin::GetLibrary:', tostring(libName))
        if isExternalLib then return self:LibStub(libName) end; return LibStub(self:GetVersionStrings(libName))
    end

    --- #### Usage: With GlobalObjects Registry
    --- ```
    --- local GlobalObjects = {}
    --- local LocalLibStub = ns.LibStubMixin:New(ns.name, 1.0, GlobalObjects)
    --- local newLib = LocalLibStub:NewLibrary('MyNewLib', 2)
    --- ```
    --- #### Usage: With Registry Function
    --- ```
    --- local GlobalObjects = {}
    --- local LocalLibStub = ns.LibStubMixin:New(ns.name, 1.0, function(name, instance) GlobalObjects[name] = instance end)
    --- local newLib = LocalLibStub:NewLibrary('MyNewLib', 2)
    --- ```
    --- @return Kapresoft_LibUtil_BaseLibrary
    --- @param libName string
    --- @param revisionNumber number
    function o:NewLibrary(libName, revisionNumber)
        assert(libName, "LibStubMixin::NewLibrary: The base libraryName is required")
        local major, minor = self:GetVersionStrings(libName, revisionNumber)

        if Kapresoft_LibUtil_LogLevel >= 10 then print(logPrefix, 'New library created:', major, 'minor:', minor) end

        --- @type Kapresoft_LibUtil_BaseLibrary
        local obj = LibStub:NewLibrary(major, minor)
        if not obj then return end

        obj.name = libName
        obj.major = major
        obj.minor = minor

        if type(obj.mt) ~= 'table' then obj.mt = {} end
        setmetatable(obj, obj.mt)

        if 'function' == type(self.postConstructFn) then self.postConstructFn(libName, obj) end

        return obj
    end

    function o:NewAddon(addonName)
        return LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
    end

    --- The OG LibStub
    --- @param major string The major version ~ AceGUI-3.0
    --- @param silent boolean set to true for verbose
    function o:LibStub(major, silent) return LibStub(major, silent) end

    ---@param module string The module name
    function o:GetMajorVersion(module)
        assert(module, "LibName is required")
        return sformat(self.versionFormat, module)
    end

    ---@param module string The module name
    function o:Lib(module) return self:GetMajorVersion(module) end

    ---@param module string The module name
    ---@param revisionNumber number
    function o:GetVersionStrings(module, revisionNumber)
        return self:GetMajorVersion(module), revisionNumber or 1
    end

end

PropsAndMethods(L)



