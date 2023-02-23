
levelNode  = Node:extend()

function levelNode:new(x,y,id, complete)
	levelNode.super.new(self,x,y)
	self.id = id
	self.complete = complete
	if complete then
		self.solid = false
		self.type = "complete"
	end
	
	
end

function levelNode:draw()
	local ss = require "spriteSheets"
	if self.complete or self.connected then
		love.graphics.draw(ss.levels,ss.levelQuads[self.id+1],self.x*tileSize,self.y*tileSize)
	else
		love.graphics.draw(ss.levels,ss.levelQuads[self.id],self.x*tileSize,self.y*tileSize)
	end
	
end



