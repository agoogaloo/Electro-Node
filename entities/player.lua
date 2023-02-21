--player class
require "consts"


Player = Entity:extend()




function Player:new(x, y)
	Player.super.new(self,x,y)	
	self.connecting = false
	self.type = "player"
	print("makin a player")
	
end

-- moves the player
function Player:move(dir, level, eManager)
	require "entities/connection"
	local newX = self.x
	local newY = self.y
	local canMove = true
	print(dir)
	if dir == "u" then 
		newY = newY-1
	elseif dir == "d" then
		newY = newY+1
	elseif dir == "l" then 
		newX = newX-1
	elseif dir == "r" then
		newX = newX+1
	end
	
	local entities = eManager.getEntities()
	for i,v in ipairs(entities) do
		if v.x == newX and v.y == newY then
			canMove  =false
		end
	end
		
		
	if level:isWall(newX, newY) then
		canMove = false
	end
	
	if canMove then
		if self.connecting then
			eManager.addEntity(Connection(self.x, self.y))
		end
		self.x = newX
		self.y = newY
	end
	
	print(entities)
	self:addConnections(entities)
	

end

function Player:addConnections(e)
	print(e)
	for i,v in ipairs(e) do
		--if the node hasnt been connected to yet
		if v.type == "node" and not v.connected then
			local distance = math.abs(v.x-self.x)+math.abs(v.y-self.y)
			
			if distance==1 then
				if self.connecting then
					eManager.addEntity(Connection(self.x, self.y))
				end
				
				self.connecting = not self.connecting
				v:connect()
			end
		end
	end	
end


-- draws the player
function Player:draw()
	love.graphics.setColor(0.9,0.4, 0.4, 1)
	love.graphics.rectangle("line", self.x*tileSize, self.y*tileSize, tileSize, tileSize)
end


