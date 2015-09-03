local runit = {}
local currntMethd

local function startWith(str, substr)
    if str == nil or substr == nil then
        return nil, "the string or the sub-stirng parameter is nil"
    end
    if string.find(str, substr) ~= 1 then
        return false
    else
        return true
    end
end

local function throwErr(msg)
	local trace = debug.traceback()
	string.gsub(trace, "'v'", currntMethd)
	print(trace)
end

runit.assertNotNil = function(obj, msg)
	if not obj then
		 throwErr(msg)
	end
end

runit.run = function(scope)
	for k,v in pairs(scope) do
		if type(v) == 'function' and startWith(k, 'test') then
			currntMethd = k
			v()
		end 
	end
end

return runit