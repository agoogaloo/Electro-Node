Connection = Entity:extend()

function Connection:new(x,y)
	Node.super.new(self,x,y)
	self.frame = 1
end

function Connection:move(dir, level)
	if self.frame == 1 then
		self.frame = 2
	else
		self.frame = 1
	end
end
function Connection:draw()
	local ss = require "spriteSheets"

	love.graphics.draw(ss.spark,ss.sparkQuads[self.frame],self.x*tileSize,self.y*tileSize)
end
