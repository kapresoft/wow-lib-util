-- where ​... are the mixins to mixin
function Mixin(object, ...)
    for i = 1, select("#", ...) do
        local mixin = select(i, ...);
        for k, v in pairs(mixin) do
            object[k] = v;
        end
    end

    return object;
end

local PrivateMixin = Mixin;

-- where ​... are the mixins to mixin
function CreateFromMixins(...)
    return PrivateMixin({}, ...)
end

local PrivateCreateFromMixins = CreateFromMixins;

function CreateAndInitFromMixin(mixin, ...)
    local object = PrivateCreateFromMixins(mixin);
    object:Init(...);
    return object;
end
