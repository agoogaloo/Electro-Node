EManager = Object:extend()

EManager.entities = {}
EManager.players = {}

function EManager.move(dir, level)
	moved = false
	for i,v in ipairs(EManager.players) do
		moved = v:move(dir, level, EManager) or moved
	end
	if moved then 
		for i,v in ipairs(EManager.entities) do
			v:move(dir, level, EManager)
		end
	end
	return moved or dir=="reset" or dir =="undo"
end

	
		
function EManager.draw()
	
	for i,v in ipairs(EManager.entities) do
		v:draw()
	end
	for i,v in ipairs(EManager.players) do
		v:draw()
	end
end

	
	-- @param[type=<entity>] <e>
function EManager.addEntity(e)
	if e.type== "player" then
		table.insert(EManager.players, e)
	else
		table.insert(EManager.entities, e)
	end

end

function EManager.addEntities(list)
	for i,v in ipairs(list) do
		EManager.addEntity(v)
	end
end


function EManager.getEntities()
	return EManager.entities
end

function EManager.clearEntities()
	EManager.entities = {}
	EManager.players = {}

end


return EManager()


