Clock = Node:extend()

function Clock:new(x,y)
	Clock.super.new(self,x,y)
	self.power = 0
	print(self.type)
end

	
function Clock:move(dir, level)
	if self.connected then
		if self.frame == 4 then
			self.frame = 5
		else
			self.frame = 4
		end
	end
end


function Clock:draw()
	local ss = require "spriteSheets"
	if self.connected then
		love.graphics.draw(ss.clock,ss.clockQuads[self.frame],self.x*tileSize,self.y*tileSize)
	else
		love.graphics.draw(ss.clock,ss.clockQuads[self.power+1],self.x*tileSize,self.y*tileSize)
	end
end


function Clock:connect()
	if not connected then
		self.power = self.power+1
	end
	
	if self.power==3 then
		self.connected = true
	end
	
end

