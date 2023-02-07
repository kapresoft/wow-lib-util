local sformat = string.format

--- @param actual boolean The actual value
--- @param label string The optional string prefix label
function assertTrue(actual, label)
    local msgFormat = "Expected to be true but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(actual, sformat(msgFormat, tostring(actual)))
end

--- @param actual boolean The actual value
--- @param label string The optional string prefix label
function assertFalse(actual, label)
    local msgFormat = "Expected to be false but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(actual == false, sformat(msgFormat, tostring(actual)))
end

--- @param expected any The expected value
--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertEquals(expected, actual, label)
    local msgFormat = "Expected [%s] but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(expected == actual, sformat(msgFormat, tostring(expected), tostring(actual)))
end
--- @param expected any The expected value
--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertNotEquals(expected, actual, label)
    local msgFormat = "Expected actual[%s] ~= [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(expected ~= actual, sformat(msgFormat, tostring(expected), tostring(actual)))
end
--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertNil(actual, label)
    local msgFormat = "Expected a nil value but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(actual == nil, sformat(msgFormat, type(actual)))
end

--- @param actual any The actual value
--- @param label string The optional string prefix label
function assertNotNil(actual, label)
    local msgFormat = "Expected a non-nil value but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    assert(actual ~= nil, sformat(msgFormat, type(actual)))
end

--- @param actualObj any The actual value
--- @param expectedType any The expected type
--- @param label string The optional string prefix label
function assertType(actualObj, expectedType, label)
    local msgFormat = "Expected object type [%s] but was [%s]"
    if label then msgFormat = '{{ ' .. label .. ' }} :::: ' .. msgFormat end
    local actualType = type(actualObj)
    assert(expectedType == type(actualObj), sformat(msgFormat, expectedType, tostring(actualType)))
end
