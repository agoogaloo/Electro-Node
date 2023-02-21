Entity = Object:extend()

function Entity:new(x,y)
	self.x = x
	self.y = y
	self.type = "entity"
end

function Entity:move(dir, level, EManager)
end

function Entity:draw()
	love.graphics.setColor(0.5,0.5,0.5)
	love.graphics.rectangle("fill", self.x*tileSize+2, self.y*tileSize+2, tileSize-4, tileSize-4)
end
