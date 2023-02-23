require "consts"
io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest") 

function love.load()
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end	
	
	Object = require "classic"
	
	eManager = require "entities/entityManager"
	
	require "entities/entity"
	require "levels/world"
	menu = require "mainMenu"
	
	world = World()
	for i,v in ipairs(world:getEntities()) do
		eManager.addEntity(v)
	end
	
	
end



function love.keypressed(key)
	
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
	
	moved = eManager.move(dir, world)
	if moved or dir == "esc"then 
		
		world:move(dir,eManager)
	end

	
	
end
function love.update(dt)
	if menu.open then
		menu.update(dt)
	end
end

function love.draw()
	local ss = require "spriteSheets"
	
	
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
	world:draw()
	--entities
	eManager.draw()
	
	
end





	
