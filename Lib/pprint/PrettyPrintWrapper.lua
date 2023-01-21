--- @type Kapresoft_Base_Namespace
local _, ns = ...
local LibUtil = ns.Kapresoft_LibUtil

--- @type Kapresoft_LibUtil_PrettyPrint
local P = LibStub('Kapresoft-LibUtil-PrettyPrint-1.0')

--- @class WrappedPrettyPrint
local pformatWrapper = { pprint = P }
LibUtil.pformat = pformatWrapper

---@param o WrappedPrettyPrint
local function PrettyPrintMethods(o)
    local pprint = o.pprint

    --- @return WrappedPrettyPrint
    function o:Default()
        pprint.setup({ use_newline = true, wrap_string = false, indent_size=4, sort_keys=true, level_width=120, depth_limit = true,
                       show_all=false, show_function = false })
        return self;
    end
    ---no new lines
    --- @return WrappedPrettyPrint
    function o:D2()
        pprint.setup({ use_newline = false, wrap_string = false, indent_size=4, sort_keys=true, level_width=120, depth_limit = true,
                       show_all=false, show_function = false })
        return self;
    end

    ---Configured to show all
    --- @return WrappedPrettyPrint
    function o:A()
        pprint.setup({ use_newline = true, wrap_string = false, indent_size=4, sort_keys=true, level_width=120,
                       show_all=true, show_function = true, depth_limit = true })
        return self;
    end

    ---Configured to print in single line
    --- @return WrappedPrettyPrint
    function o:B()
        pprint.setup({ use_newline = false, wrap_string = true, indent_size=2, sort_keys=true,
                       level_width=120, show_all=true, show_function = true, depth_limit = true })
        return self;
    end

    --- @return string
    function o:pformat(obj, option, printer)
        local str = pprint.pformat(obj, option, printer)
        o:Default(o)
        return str
    end
    o.mt = { __call = function (_, ...) return o.pformat(o, ...) end }
    setmetatable(o, o.mt)
end

PrettyPrintMethods(pformatWrapper)
