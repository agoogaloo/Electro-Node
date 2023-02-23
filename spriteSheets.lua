require "consts"
sprites = {}

function splitSheet(sheet, width, height)
	local quads = {}
	local cols = sheet:getWidth()/(width+1)
	local rows = sheet:getHeight()/(height+1)

	 for r=0,rows do
				for c=0,cols do
						table.insert(quads,love.graphics.newQuad(c*(width+1),r*(height+1),
								width,height,sheet:getWidth(),sheet:getHeight()))
				end
		end
		return quads
	end
	
sprites.tileset = love.graphics.newImage("res/tileset.png")
sprites.tileQuads = splitSheet(sprites.tileset,tileSize, tileSize)

sprites.levels = love.graphics.newImage("res/levels.png")
sprites.levelQuads = splitSheet(sprites.levels,tileSize,tileSize)

sprites.player = love.graphics.newImage("res/player.png")
sprites.playerQuads = splitSheet(sprites.player,tileSize, tileSize)

sprites.light = love.graphics.newImage("res/light.png")
sprites.lightQuads = splitSheet(sprites.light,12,10)

sprites.clock = love.graphics.newImage("res/clock.png")
sprites.clockQuads = splitSheet(sprites.clock,tileSize, tileSize)

sprites.spark = love.graphics.newImage("res/spark.png")
sprites.sparkQuads = splitSheet(sprites.spark,tileSize, tileSize)


	
return sprites