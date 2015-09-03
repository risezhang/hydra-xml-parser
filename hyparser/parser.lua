local SLAXML = require 'lib/slaxml'
local element = require 'hyparser/element'

local push, pop = table.insert, table.remove
local stack = {} 

local parserObj = {}

--[[
Parser the xml file
@param xmlPath - the file name of the xml file to parse
@param skinRootPath - the root path which is taken to read included file
]]
parserObj.parseXML = function (xmlPath, skinRootPath)
  local root = nil
  local current = nil

  local parseXML = nil

  local function create(tag) 
    local el = element.new(tag)
    if current then
      current:addChild(el)
    else
      root = el
    end
    current = el
    push(stack,el)
  end

  local function close(name)
    local el = pop(stack)
    if el.tagName == 'include' then
      local include = parserObj.parseXML(el.path, skinRootPath)
      local json = require "lib/JSON"
      for k,v in pairs(include.layout) do
        el[k] = v
      end
    end
    el:close()
    current = stack[#stack]
  end

  -- Specify as many/few of these as you like
  local parser = SLAXML:parser{
    startElement = function(name,nsURI,nsPrefix)
      create(name)
    end, -- When "<foo" or <x:foo is seen
    attribute    = function(name,value,nsURI,nsPrefix)
     current:attr(name, value)
    end, -- attribute found on current element
    closeElement = function(name,nsURI)                
      close(name)
    end, -- When "</foo>" or </x:foo> or "/>" is seen
    text         = function(text)                      end, -- text and CDATA nodes
    comment      = function(content)                   end, -- comments
    pi           = function(target,content)            end, -- processing instructions e.g. "<?yes mon?>"
  }
  local xmlFile = io.open(skinRootPath..xmlPath)
  if not xmlFile then
    print(string.format("File not fount: %s", skinRootPath..xmlPath))
    error()
  end
  local xml = xmlFile:read('*all')
  xmlFile:close()
  root, current = nil, nil
  parser:parse(xml,{stripWhitespace=true})
  return root
end

-- output
return {
  parse = parserObj.parseXML
}