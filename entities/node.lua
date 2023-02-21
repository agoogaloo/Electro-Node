Node = Entity:extend()

function Node:new(x,y)
	Node.super.new(self,x,y)
	self.connected = false
	self.type = "node"
	
end

function Node:draw()
	love.graphics.setColor(0.5,0.5,0.9)
	love.graphics.rectangle("line", self.x*tileSize+1, self.y*tileSize+1, 6,6)
end

function Node:connect()
	self.connected = true
end


