EManager = Object:extend()

EManager.entities = {}

function EManager.move(dir, level)
	for i,v in ipairs(EManager.entities) do
		v:move(dir, level, EManager)
	end
end

	
		
function EManager.draw()
	for i,v in ipairs(EManager.entities) do
		v:draw()
	end
end

	
	-- @param[type=<entity>] <e>
function EManager.addEntity(e)
	table.insert(EManager.entities, e)
end

function EManager.getEntities()
	return EManager.entities
end


return EManager()


