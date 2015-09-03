package.path = '../?.lua;' .. package.path
local runit = require "runit"
local parser = require "hyparser.parser"
local json = require "lib/JSON"

-- function testA()
-- 	local root = parser.parse("xml/index.xml", "D:/work/repo/hydra-xml-parser/test/")
-- 	print(json:encode_pretty(root))
-- end

-- function testInclude()
-- 	local root = parser.parse("xml/include.xml", "D:/work/repo/hydra-xml-parser/test/")
-- 	print(json:encode_pretty(root.layout))
-- end

function testList()
	local root = parser.parse("customerList.xml", "D:/work/app/")
	-- print(json:encode_pretty(root.page))
end

function testB()
	local root  = parser.parse("activity_phase_one.xml", "D:/work/app/")
	print(json:encode_pretty(root.page))
end


runit.run(_ENV)
