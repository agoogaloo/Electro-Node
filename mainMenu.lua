menu = {}
menu.frame1 = love.graphics.newImage("res/title1.png")
menu.frame2 = love.graphics.newImage("res/title2.png")
menu.frame = 1
menu.open = true

menu.timer = 0


function menu.move(dir)
	if dir ~="" then
		menu.open = false
	end
	
	
end

function menu.update(dt)
	menu.timer = menu.timer+dt
	if menu.timer> 0.3 and menu.frame ==1 then
		menu.frame = 2
		menu.timer = 0
	elseif menu.timer > 0.3 then
		menu.frame = 1
		menu.timer = 0
	end
end


function menu.draw()
	if menu.frame==1 then
		love.graphics.draw(menu.frame1,8,8)
	else
			love.graphics.draw(menu.frame2,8,8)
	end
	--love.graphics.setNewFont("res/monoFont.ttf", 16)
	--love.graphics.print("-PRESS ANYTHING TO START-",13,90)
	--love.graphics.print("WASD-MOVE Z-UNDO R-RESET",16,105)
end

return menu



