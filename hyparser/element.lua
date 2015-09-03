local NO_QNAME = {
	scripts = 1,
	script = 1,
	template = 1,

}

local element = {
	tagName = nil
}

function element:attr(k, v)
	self[k]=v
end

function element:addChild(c)
	doAddChild(self, c)
	c.parent = self
end

function element:close(c)
	self.parent = nil
	self.tagName = nil
end

function newElement(tagName)
	local model = {tagName = tagName}
	initNew(model, tagName)
	setmetatable(model, {__index=element})
	return model
end

function initNew(element, tagName)
	if tagName == "page" then
		element.schema = "v1"
	elseif tagName == "layout" then
		element.qName = "view"
	elseif tagName == "body" then
		element.qName = "view"
	elseif NO_QNAME[tagName] then
		-- skip adding qName
	else
		element.qName = tagName
	end
end

local function subHandler(element,c)
	element[c.tagName] = c
end

local childHandlers = {
	default = function(element, c)
		element.subitems = element.subitems or {}
		table.insert(element.subitems, c)
	end,
	scripts = function(element, c)
		element.scripts = c
	end,
	script = function(element, c)
		table.insert(element, c)
	end,
	layout = subHandler,
	page = subHandler,
	template = subHandler,
	body = subHandler,
	sectionHeader = subHandler,
	sectionFooter = subHandler,
	header = subHandler,
	footer = subHandler,
}

local function getChildHandlerByTagName(tagName)
	return  childHandlers[tagName] or childHandlers.default
end

function doAddChild(element, child)
	local handler = getChildHandlerByTagName(child.tagName)
	handler(element, child)
end

return {
	new = function(tagName)
		return newElement(tagName)
	end
}