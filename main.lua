local parser = require "hyparser.parser"
local json = require "lib/JSON"

local root = parser.parse("index.xml", "D:/work/repo/hydra-xml-parser/test/xml/")
local output = assert(io.open("output.json", "w"))
output:write(json:encode_pretty(root.page))
output:close()
