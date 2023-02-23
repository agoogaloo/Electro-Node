Node = Entity:extend()

function Node:new(x,y)
	Node.super.new(self,x,y)
	self.frame = 1
	self.connected = false
	self.type = "node"
	
end

function Node:move(dir, level)
	if self.connected then
		if self.frame == 2 then
			self.frame = 3
		else
			self.frame = 2
		end
	end
end


function Node:draw()
	local ss = require "spriteSheets"

	love.graphics.draw(ss.light,ss.lightQuads[self.frame],self.x*tileSize-2,self.y*tileSize-2)
end

function Node:connect()
	self.connected = true
	self.frame = 2
end


