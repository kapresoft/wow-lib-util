-- command line: busted spec
-- supporting testfile; belongs to 'cl_spec.lua'
-- See: https://lunarmodules.github.io/busted/#asserts

--[[-----------------------------------------------------------------------------
Lua Vars
-------------------------------------------------------------------------------]]
local require = require

require('test.Setup')
require('String.String')

---@type Kapresoft_String
local String = LibStub('Kapresoft-String-1.0')
_suite(tostring(String))

describe('String :: StartsWith() :: ', function()

  it('Should start with "hello"', function()
    assert.is_true(String.StartsWith("hello there", "hello"))
  end)
  it('Should not start with "HELLOx"', function()
    assert.is_not_true(String.StartsWith("hello there", "HELLOx"))
  end)

end)

describe('String :: StartsWithIgnoreCase() :: ', function()

  it('Should start with "HELLO"', function()
    assert.is_true(String.StartsWithIgnoreCase("Hello there", "HELLO"))
  end)
  it('Should not start with "HELLO"', function()
    assert.is_not_true(String.StartsWithIgnoreCase("XHello there", "HELLO"))
  end)

end)

describe('String :: EndsWith() :: ', function()

  it('Should end with "there"', function()
    assert.is_true(String.EndsWith("hello there", "there"))
  end)
  it('Should not end with "THERE"', function()
    assert.is_not_true(String.EndsWith("hello there", "THERE"))
  end)

end)

describe('String :: Contains() :: ', function()

  it('Should contain "there"', function()
    assert.is_true(String.Contains("hello there world", "there"))
  end)
  it('Should contain "hello"', function()
    assert.is_true(String.Contains("hello there world", "hello "))
  end)
  it('Should contain "o th"', function()
    assert.is_true(String.Contains("hello there world", "o th"))
  end)

  it('Should not contain "THERE"', function()
    assert.is_not_true(String.Contains("hello there world", "THERE"))
  end)

end)

describe('String :: ContainsIgnoreCase() :: ', function()

  it('Should contain "THERE"', function()
    assert.is_true(String.ContainsIgnoreCase("hello there world", "THERE"))
  end)
  it('Should contain "LLO th"', function()
    assert.is_true(String.ContainsIgnoreCase("hello there world", "LLO th"))
  end)
  it('Should not contain "yyy xx"', function()
    assert.is_not_true(String.ContainsIgnoreCase("any word", "yyy xx"))
  end)

end )


--[[-----------------------------------------------------------------------------
Teardown
-------------------------------------------------------------------------------]]
require('test.Teardown')
