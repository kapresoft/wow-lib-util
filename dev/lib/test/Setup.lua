-- LibStub requires strmatch/string.match to be global
strmatch = string.match
sformat = string.format

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

if true == VERBOSE then print('Setup called...') end
print('Lua version:', _VERSION)
