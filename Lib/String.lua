--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local gsub, len, tinsert, pairs, type, tostring = string.gsub, string.len, table.insert , pairs, type, tostring
local strlower = string.lower

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub, K_LibName = LibStub, K_LibName
local MAJOR, MINOR = K_LibName('String'), 1


--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
---@class Kapresoft_LibUtil_String
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded and no upgrade necessary
if not L then return end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
function L.IsEmpty(str) return (str or '') == '' end
function L.IsNotEmpty(str)
    if str == nil then return true end
    return not L.IsEmpty(str)
end
function L.IsBlank(str)
    if str == nil then return true end
    if type(str) ~= 'string' then return false end
    return len(L.TrimAll(str)) <= 0
end
function L.IsNotBlank(str) return not L.IsBlank(str) end
function L.TrimAll(str)
    if str == nil then return str end
    if type(str) ~= 'string' then error(string.format('expected a string type but got: %s', type(str))) end
    return gsub(str or '', "%s", "")
end

function L.ToTable(args)
    -- print(string.format("args: %s, type=%s", args, type(args)))
    local rt = {}
    for a in args:gmatch("%S+") do tinsert(rt, a) end
    -- table.foreach(rt, print)
    return rt
end

function L.ToString(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. L.ToString(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function L.EqualsIgnoreCase(str1, str2)
    return string.lower(str1) == string.lower(str2)
end

---@param formatstring string The string format
function L.format(formatstring, ...)
    return string.format(formatstring, ...)
end

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
function L.trim(s)
    -- from PiL2 20.4
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- remove leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
function L.ltrim(s)
    return (s:gsub("^%s*", ""))
end

-- remove trailing whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
function L.rtrim(s)
    local n = #s
    while n > 0 and s:find("^%s", n) do n = n - 1 end
    return s:sub(1, n)
end

function L.replace(str, match, replacement)
    if type(str) ~= 'string' then return nil end
    return str:gsub(match, replacement)
end

---Example: local charCount = Count('hello world', 'l') ; returns 3
---@param str string The string to search
---@param pattern string The pattern to count
function L.Count(str, pattern)
    return select(2, string.gsub(str, pattern, ""))
end

---@param index number The index to replace
---@param str string The text where we are replacing the index value of
---@param r string The replacement text
function L.ReplaceChar(index, str, r)
    return str:sub(1, index - 1) .. r .. str:sub(index + 1)
end

---@param str string The text where we are replacing the index value of
---@param r string The replacement text
function L.ReplaceAllCharButLast(str, r)
    local c = L.Count(str, r)
    if c == 1 then return str end
    local ret = str
    for _ = 1, c - 1, 1
    do
        local index = ret:find(r)
        if index >= 1 then
            ret = L.ReplaceChar(index, ret, '')
        end
    end
    return ret
end

---@class BindingDetails
local BindingDetailsTemplate = { action="<CLICK>", buttonName="<buttonName>", buttonPressed="<LeftButton>" }

---@param bindingName string The keybind name (see Bindings.xml) Example: ```'CLICK ActionbarPlusF1Button1:LeftButton'```
---@return BindingDetails
function L.ParseBindingDetails(bindingName)
    local startIndexMatch, _, a,b,c = string.find(bindingName, "(.+%s)(%w+):(%a+)")
    if not (startIndexMatch or b) then return nil end
    return { action= L.TrimAll(a), buttonName = L.TrimAll(b), buttonPressed = L.TrimAll(c) }
end

---The following example returns true:
---```
---local isValidType = String.IsAnyOf('spell', 'SPELL', 'Item', 'Macro')
---assertThat(isValidType).IsTrue()
---```
---
---The following example returns false:
---```
---local isValidType = String.IsAnyOf('macrotext', 'SPELL', 'Item', 'Macro')
---assertThat(isValidType).IsFalse()
---```
---@param valueToMatch string A case insensitive match against the variable argument #2.
---@return boolean
function L.IsAnyOf(valueToMatch, ...)
    if not valueToMatch then return false end
    local args = {...}
    for i=1, #args do
        local val = args[i]
        if val and strlower(val) == strlower(valueToMatch) then return true end
    end
    return false
end

--[[-----------------------------------------------------------------------------
Global Methods
-------------------------------------------------------------------------------]]
function Kapresoft_LibUtil_String() return LibStub(MAJOR, MINOR)  end
