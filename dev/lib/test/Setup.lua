-- LibStub requires strmatch/string.match to be global
strmatch = string.match
sformat = string.format
K_VERBOSE = false

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

function reportFailures()
    print('')
    if TEST_FAILURES > 0 then
        printf("Total Test Failures: %s", TEST_FAILURES)
    else
        print('ALL PASSED')
    end
end

if true == K_VERBOSE then print('Setup called...') end
print('Lua version:', _VERSION)
