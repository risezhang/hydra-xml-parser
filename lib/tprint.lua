local io = io
local pairs = pairs
local tostring = tostring
local type = type
local string = string

module(...)

function tprint(t,n,saved)
	saved = saved or {}
	n = n or 0
	for k in pairs(t) do
		local str = ''
		if n~=0 then
			local fmt = '%' .. 2*n .. 's'
			str = string.format(fmt, '')
		end
		io.write(str,tostring(k), ' = ')
		if type(t[k])=='table' then
			local m = n
			m = m+1
			if saved[t[k]] then
				io.write('"',saved[t[k]], '"\n')
			else
				saved[t[k]] = k
				io.write('{\n')
				tprint(t[k], m, saved)
				io.write(str,'}\n')
			end
		else
			io.write('"',tostring(t[k]),'"\n')
		end
	end
end

return tprint