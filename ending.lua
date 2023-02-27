ending = {}
ending.frame1 = love.graphics.newImage("res/ending1.png")
ending.frame2 = love.graphics.newImage("res/ending2.png")
ending.frame = 1

ending.timer = 0


function ending.update(dt)
	ending.timer = ending.timer+dt
	if ending.timer> 0.3 and ending.frame ==1 then
		ending.frame = 2
		ending.timer = 0
	elseif ending.timer > 0.3 then
		ending.frame = 1
		ending.timer = 0
	end
end


function ending.draw()
	if ending.frame==1 then
		love.graphics.draw(ending.frame1,8,8)
	else
			love.graphics.draw(ending.frame2,8,8)
	end
	--love.graphics.setNewFont("res/monoFont.ttf", 16)
	--love.graphics.print("-PRESS ANYTHING TO START-",13,90)
	--love.graphics.print("WASD-MOVE Z-UNDO R-RESET",16,105)
end

return ending