require "consts"
io.stdout:setvbuf("no")

love.window.setMode(pixelScale*tileSize*screenWidth+pixelScale,pixelScale*tileSize*screenHeight+pixelScale)
love.window.setTitle("Love2d Jam")

function love.load()
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end
	
	
	Object = require "classic"
	eManager = require "entities/entityManager"
	
	require "entities/entity"
	require "levels/level"
	
	level = Level("res/maps/level2.json")
	for i,v in ipairs(level:getEntities()) do
		eManager.addEntity(v)
	end
	
end

function love.keypressed(key)
	print(key)
	local dir = ""
	--moving the player based on input direction
	if key == "up" then
		dir = "u"
	elseif key == "down" then
		dir = "d"
	elseif key == "left" then
		dir = "l"
	elseif key == "right" then
		dir = "r"
	end
	
	eManager.move(dir, level)
	
end

function love.draw()
	love.graphics.translate(pixelScale/2, pixelScale/2)
	love.graphics.scale(pixelScale,pixelScale)
	
	--love.graphics.setLineStyle('rough')
	eManager.draw()
	level:draw()
	
end





	
