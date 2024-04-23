local sformat = string.format

--- @param obj any
--- @return string
local function t(obj) return sformat('%s (type: %s)', tostring(obj), type(obj)) end

local function stackTraceFn(errorMsg, msg)
    TEST_FAILURES = TEST_FAILURES + 1
    local info = debug.getinfo(7, 'nlS')
    local m = string.gsub(errorMsg, 'dev/lib/test/Assertions.lua:%d+',
            info.short_src .. ':' .. info.currentline)
    printf("[Assertion Failed] %s", m)
    --print("Error Message:", errorMsg)
    --print('Info:', pformat(info))
    --print("Trace:", debug.traceback())
end
local function ErrorHandler(msg) return function(errorMsg) stackTraceFn(errorMsg, msg) end end

---@param charPadding number
local function createPadding(charPadding)
    local padding = ''
    local paddingAmount = charPadding or 5
    for i = 1, paddingAmount do padding = padding .. ' ' end
    return padding
end

---@param label string Optional label
local function GetExpectedMessageFormat(label)
    local padding = createPadding(12)
    local msgFormat = "\n" .. padding .. 'Expected: %s\n ' .. padding .. 'but was: %s'
    if label then msgFormat = '{{ ' .. label .. ' }}' .. msgFormat end
    return msgFormat
end

---@param label string Optional label
local function GetExpectedNotEqualMessageFormat(label)
    local padding = createPadding(1)
    local msgFormat = "\n" .. padding .. '   Expecting actual: %s\n '
            .. padding .. 'not to be equal to: %s'
    if label then msgFormat = '{{ ' .. label .. ' }}' .. msgFormat end
    return msgFormat
end

---@param label string Optional label
local function GetExpectedIsTypeMessageFormat(label)
    local padding = createPadding(1)
    local msgFormat = "\n" .. padding ..
            '   Expecting actual object type: %s\n' .. padding ..
            '                        but was: %s'
    if label then msgFormat = '{{ ' .. label .. ' }}' .. msgFormat end
    return msgFormat
end

---@param label string Optional label
local function GetExpectedNotNilMessage(label)
    local padding = createPadding(12)
    local msg = "\n" .. padding .. 'Expecting actual not to be nil'
    if label then msg = '{{ ' .. label .. ' }}' .. msg end
    return msg
end

--- @param actual boolean The actual value
--- @param label string The optional string prefix label
function assertTrue(actual, label)
    local msgFormat = GetExpectedMessageFormat(label)
    local msg = sformat(msgFormat, 'true', t(actual))
    xpcall(function() assert(actual, msg) end, ErrorHandler(msg))
end

--- @param actual boolean The actual value
--- @param label string The optional string prefix label
function assertFalse(actual, label)
    local msgFormat = GetExpectedMessageFormat(label)
    local msg = sformat(msgFormat, 'false', t(actual))
    xpcall(function() assert(actual == false, msg) end, ErrorHandler(msg))
end

--- @param actual any The actual value
--- @param expected any The expected value
--- @param label string The optional string prefix label
function assertEquals(actual, expected, label)
    local msgFormat    = GetExpectedMessageFormat(label)
    local msg = sformat(msgFormat, t(expected), t(actual))
    xpcall(function() assert(actual == expected, msg) end, ErrorHandler(msg))
end

--- @param actual any The actual value
--- @param expected any The expected value
--- @param label string The optional string prefix label
function assertNotEquals(actual, expected, label)
    local msgFormat = GetExpectedNotEqualMessageFormat(label)
    local msg = sformat(msgFormat, t(expected), t(actual))
    xpcall(function() assert(actual ~= expected, msg)  end, ErrorHandler(msg))
end

--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertNil(actual, label)
    local msgFormat = GetExpectedMessageFormat(label)
    local msg = sformat(msgFormat, 'nil', t(actual))
    xpcall(function() assert(actual == nil, msg) end, ErrorHandler(msg))
end

--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertNotNil(actual, label)
    local msg = GetExpectedNotNilMessage(label)
    xpcall(function() assert(actual ~= nil, msg) end, ErrorHandler(msg))
end

--- @param actualObj any The actual value
--- @param expectedType any The expected type
--- @param label string The optional string prefix label
function assertType(actualObj, expectedType, label)
    local msgFormat = GetExpectedIsTypeMessageFormat(label)
    local msg = sformat(msgFormat, expectedType, type(actualObj))
    xpcall(function() assert(expectedType == type(actualObj), msg) end, ErrorHandler(msg))
end
