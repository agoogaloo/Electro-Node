require "consts"
io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest") 

local muted = false

function love.load()
	print("load")
	
	
	love.graphics.setShader(shader)
  if arg[#arg] == "-debug" then  
    require("mobdebug").start() 
  end	
	
	Object = require "classic"
	tick = require "tick"
	Sounds = require "sounds"
	
	eManager = require "entities/entityManager"
	
	require "entities/entity"
	require "levels/world"
	menu = require "mainMenu"
	ending = require "ending"
	
	 world = World()
	for i,v in ipairs(world:getEntities()) do
		eManager.addEntity(v)
	end
	
	local shader = require "shader"
	love.graphics.setShader(shader)
	
	Sounds.music:play()
end



function love.keypressed(key)
	
	--muting audio when m is pressed
	
	if key=="m" then
		
		if muted then
			Sounds.music:play()
			muted = false
		else
			Sounds.music:stop()
			muted = true
		end
	end
	
		
		
	
	
	local dir = ""
	--moving the player based on input direction
	if key == "up" or key=="w" then
		dir = "u"
	elseif key == "down"or key=="s" then
		dir = "d"
	elseif key == "left"or key=="a" then
		dir = "l"
	elseif key == "right" or key=="d"then
		dir = "r"
	elseif key == "z" then
		dir = "undo"
	elseif key == "r" then
		dir = "reset"
	elseif key == "escape" then
		dir = "esc"
	end
	
	if menu.open then
		menu.move(dir)
		return
	end
	
	if world.complete then
		return
	end
	
	
	
	moved = eManager.move(dir, world)
	if  (not world.complete)  and (moved or dir == "esc")then 
		world:move(dir,eManager)
	end

	
	
end
function love.update(dt)
	tick.update(dt)
	if world.complete then
		ending.update(dt)
		return 
	end
	
	if menu.open then
		menu.update(dt)
	end
end

function love.draw()
	local ss = require "spriteSheets"
	--shader:send("light",world.lightLevel)
	
	love.graphics.scale(pixelScale,pixelScale)
	love.graphics.setColor(2,2,2)
		
	local width, height = love.graphics.getWidth()/pixelScale,love.graphics.getHeight()/pixelScale
	local levWidth, levHeight = world:getLevelSize()
	
	
	--background
	love.graphics.draw(ss.tileset,ss.tileQuads[1],0,0,0,width/tileSize,height/tileSize)
	
	love.graphics.translate((width-levWidth*tileSize)/2,(height-levHeight*tileSize)/2)
	--world
	--correcting for the origin being 1,1
	love.graphics.translate(-tileSize,-tileSize)
	if menu.open then
		menu:draw()
		return
	end
	if world.complete then
		ending.draw()
		return
	end
	
	world:draw()
	
	--entities
	eManager.draw()
	
end





	
