# Hydra xml parser

HXP is a layout parser for the HP Hydra framework which is written in pure Lua.

Usage (main.lua):

```lua
local parser = require "hyparser.parser"
local json = require "lib/JSON"

local root = parser.parse("index.xml", "D:/work/repo/hydra-xml-parser/test/xml/")
local output = assert(io.open("output.json", "w"))
output:write(json:encode_pretty(root.page))
output:close()
```

While most kind of nodes are supported, such as include, view, hbox, label, image and other widget nodes including customized ones, but metadata is not supported yet.

### Todos

 - Support metadata
 - More tests
 - More code comments

## History

### v0.1 09.03.2015
+ The first usable version

License
----
MIT

**Thanks for those open sources!**
- [JSON.lua by Jeffrey Friedl](http://regex.info/blog/lua/json)
- [SLAXML by Gavin Kistner](http://github.com/Phrogz/SLAXML)