--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local table, unpack = table, unpack

--[[-----------------------------------------------------------------------------
Local Vars
-------------------------------------------------------------------------------]]
local LibStub, K_LibName = LibStub, K_LibName
local MAJOR, MINOR = K_LibName('Table'), 1

--[[-----------------------------------------------------------------------------
New Instance
-------------------------------------------------------------------------------]]
--- @class Kapresoft_LibUtil_Table
local L = LibStub:NewLibrary(MAJOR, MINOR)
-- return if already loaded and no upgrade necessary
if not L then return end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
---Trim Trailing and Leading Trim
local function Trim(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end

function L.parseSpaceSeparatedVar(text)
    local rt = {}
    for a in text:gmatch("%S+") do table.insert(rt, a) end
    return rt
end

function L.parseCSV(text)
    local rt = {}
    for a,v in text:gmatch("([^,]+)") do
        local a2 = Trim(a)
        table.insert(rt, a2)
    end
    return rt
end

function L.size(t)
    if type(t) ~= 'table' then error(string.format("Expected arg to be of type table, but got: %s", type(t))) end
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end
function L.isEmpty(t)
    if t == nil then return true end
    return L.size(t) <= 0
end
function L.members()
    print('table members: ')
    for key, _ in pairs(L) do
        print(" " .. key);
    end
end

function L.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
        t2[k] = v
    end
    return t2
end

function L.mergeArray(t1, t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

function L.mergeTable(source, target)
    local t2 = target or {}
    for k,v in pairs(source) do
        if t2[k] == nil then
            t2[k] = v
        end
    end
    return t2
end

function L.sliceAndPack(t, startIndex)
    local sliced = L.slice(t, startIndex)
    return L.pack(L.unpack(sliced))
end

---Fail-safe unpack
---@param t table The table to unpack
function L.unpack(t)
    if type(unpack) == 'function' then return unpack(t) end
    return table.unpack(t)
end

---Backwards compat
---@deprecated
---@see Table#unpack
function L.unpackIt(t) return L.unpack(t) end

function L.slice (t, startIndex, stopIndex)
    local pos, new = 1, {}
    if not stopIndex then stopIndex = #t end
    for i = startIndex, stopIndex do
        new[pos] = t[i]
        pos = pos + 1
    end
    return new
end

---## Create Chunks from table
---@param tbl table The array type table
---@param _chunkSize number The chunk size
function L.chunkedArray(tbl, _chunkSize)
    local ret = {}
    local chunkIndex = 1
    local chunkSize = _chunkSize
    local i = 1
    repeat
        local chunks = {}
        for j=1, chunkSize do
            --chunks[j] = tbl[i]
            local ci = i+j-1
            table.insert(chunks, tbl[ci])
        end
        local lastIndex = i
        i = i + chunkSize
        if i > #tbl then chunkSize = #tbl - lastIndex end
        table.insert(ret, chunks)
        chunkIndex = chunkIndex + 1
        --print(format('chunkIndex: %s chunkSize: %s tblSize: %s', chunkIndex, chunkSize, #tbl))
    until (i > #tbl)
    return ret
end

function L.concatkv(t)
    if type(t) ~= 'table' then return tostring(t) end
    local s = '{ '
    for k,v in pairs(t) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. L.concatkv(v) .. ','
    end
    return s .. '} '
end

function L.getSortedKeys(t)
    if type(t) ~= 'table' then return tostring(t) end
    local keys = {}
    for k in pairs(t) do table.insert(keys, k) end
    table.sort(keys)
    return keys
end

function L.concatkvs(t, optionalAddNewline)
    local addNewLine = optionalAddNewline or false
    if type(t) ~= 'table' then return tostring(t) end
    local keys = L.getSortedKeys(t)
    local s = '{ '
    if addNewLine then s = s .. '\n' end
    for _, k in pairs(keys) do
        local ko = k
        if type(k) ~= 'number' then k = '"'..k..'"' end
        if type(t[ko]) ~= 'function' then
            s = s .. '['..k..'] = ' .. L.concatkvs(t[ko]) .. ','
        end
    end
    return s .. '} '
end

function L.toString(t) return L.concatkv(t) end
function L.toStringSorted(t, optionalAddNewline) return L.concatkvs(t, optionalAddNewline) end

function L.toString2(t)
    if type(t) ~= 'table' then return tostring(t) end
    local s = '\n{'
    for k,v in pairs(t) do
        s = string.format("%s\n    %s: %s,", s, tostring(k), L.toString2(v))
    end
    return s .. '\n}'
end

function L.pack(...)
    return { len = select("#", ...), ... }
end

function L.isTable(t) return type(t) == 'table' end
function L.isNotTable(t) return not L.isTable(t) end

function L.print(t) print(L.toString(t)) end
function L.printkv(t) print(L.concatkv(t)) end

function L.printkvs(t)
    local keys = L.getSortedKeys(t)
    for _, k in ipairs(keys) do print(k, t[k]) end
end

function L.println(t)
    if type(t) ~= 'table' then return tostring(t) end
    for k,v in pairs(t) do
        print(string.format("%s: %s", tostring(k), L.println(v)))
    end
end

function L.printG() L.printkvs(_G) end
function L.printLoaded() L.printkvs(package.loaded) end


--[[-----------------------------------------------------------------------------
Global Methods
-------------------------------------------------------------------------------]]
--- @return Kapresoft_LibUtil_Table
function Kapresoft_LibUtil_Table() return LibStub(MAJOR, MINOR) end
