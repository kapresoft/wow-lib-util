-- LibStub requires strmatch/string.match to be global
strmatch = string.match
sformat = string.format
Kapresoft_LibUtil_LogLevel_LibWrapper = 10
Kapresoft_LibUtil_LogLevel_LibFactory = 10
Kapresoft_LibUtil_LogLevel_LibStub = 10


--- @type number
TEST_FAILURES = 0

require('test.Assertions')
require('LibStub.LibStub')
require('pprint.pprint')

local pprint = LibStub('Kapresoft-LibUtil-PrettyPrint-1.0')
pprint.setup({ show_all = true })

--- @type fun(fmt:string, ...)|fun(val:string)
pformat = pprint.pformat

---@param s string
function _suite(s)
    print('----------------------- Test Suite :: ' .. s)
end
function _test(s) print('Test :: ' .. s) end

function printf(fmt, ...)
    local packed = {...}
    xpcall(function()
        print(string.format(fmt, unpack(packed)))
    end, function(errorMsg)
        local info = debug.getinfo(6, 'nlS')
        local m = string.gsub(errorMsg, ".lua:%d+",
                '.lua::' ..  tostring(info.short_src) .. ':' .. tostring(info.currentline))
        print('[ERROR] ' .. tostring(m))
        --print('error-info:', pformat(info))
    end)
end

function ReportSummary()
    if TEST_FAILURES > 0 then
        printf("Total Test Failures: %s", TEST_FAILURES)
    else
        print('ALL PASSED')
    end
end

if (Kapresoft_LibUtil_LogLevel or 0) > 20 then print('Setup called...') end
print('Lua version:', _VERSION)
