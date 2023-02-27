--player class
require "consts"
Player = Entity:extend()


function Player:new(x, y)
	Player.super.new(self,x,y)	
	self.connecting = false
	self.newConnection = false
	self.frame = 1
	self.type = "player"	
end

-- moves the player
function Player:move(dir, level, eManager)
	require "entities/connection"
	local newX = self.x
	local newY = self.y
	local canMove = true
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
		if v.solid and v.x == newX and v.y == newY then
			canMove  =false
		end
	end
	for i,v in ipairs(eManager.players) do
		if v.x == newX and v.y == newY then
			canMove  =false
		end
	end
		
		
	if level:isWall(newX, newY) then
		canMove = false
	end
	
	if canMove or dir =="end" then
		self.frame = self.frame+1
		if self.frame == 3 then
			self.frame = 1
		end
	end
	
	
	if canMove then
		if self.connecting then
			eManager.addEntity(Connection(self.x, self.y))
		end
		self.x = newX
		self.y = newY
		self:addConnections(entities)
		Sounds.playSound(Sounds.move)
		
	elseif dir ~= "end" then
		Sounds.playSound(Sounds.blocked)		
	end

	return canMove
	

end

function Player:addConnections(e)
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
				Sounds.playSound(Sounds.connect)	
			end
		end
	end	
end


-- draws the player
function Player:draw()
	
	local ss = require "spriteSheets"
	
	if self.connecting then
		love.graphics.draw(ss.player,ss.playerQuads[self.frame+2],self.x*tileSize,self.y*tileSize)
	else
		love.graphics.draw(ss.player,ss.playerQuads[self.frame],self.x*tileSize,self.y*tileSize)
	end
	
end


