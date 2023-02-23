require "consts"
Level = Object:extend()

local blank = 1
local light = 30
local clock = 31
local player = 29

function Level:new(path)	
	self:loadLevel(path)
	self:makeEntities()
	
end

function Level:loadLevel(path)
	json = require "json"
	 if love.filesystem.getInfo(path) then
			local file = love.filesystem.read(path)
			local data = json.decode(file)
			
			local wallData = data.layers[2].data
			local tileData = data.layers[1].data
			
			self.walls = {}
			self.tiles = {}
			self.width = data.layers[1].width
			self.height = data.layers[1].height
			
			
			
			for y=1,#wallData/self.width do
				local wallRow = {}
				local tileRow = {}
				for x = 1,self. width do
					wallRow[x]=wallData[x+(y-1)*self.width]
					tileRow[x] = tileData[x+(y-1)*self.width]
				end
				self.walls[y] = wallRow
				self.tiles[y] = tileRow
			end
		end
end


function Level:makeEntities()
	require "entities/entity"
	require "entities/node"
	require "entities/clock"
	require "entities/player"

	self.entities = {}
	for r = 1,#self.tiles do
		for c = 1,#self.tiles[r] do
			if self.tiles[r][c]==light then
				table.insert(self.entities, Node(c,r))
				self.tiles[r][c] = blank
			end
			if self.tiles[r][c]==clock then
				table.insert(self.entities, Clock(c,r))
				self.tiles[r][c] = blank
			end
			if self.tiles[r][c]== player then
				table.insert(self.entities, Player(c,r))
				self.tiles[r][c] = blank

			end
		end
	end
	
end

function Level:draw()
	local ss = require "spriteSheets"
	
	for r = 1,#self.walls do
		for c = 1,#self.walls[r] do
			if self.walls[r][c] ~=0 then
				love.graphics.draw(ss.tileset,ss.tileQuads[self.walls[r][c]],c*tileSize,r*tileSize)
			else
				love.graphics.draw(ss.tileset,ss.tileQuads[self.tiles[r][c]],c*tileSize,r*tileSize)
			end
		end
	end
end

function Level:isComplete()
	for i,v in ipairs(self.entities) do
		if v.type =="node" and not v.connected then
			return false
		end
	end
	return true
end

function Level:isWall(x, y)

	if self.walls[y][x] ~=0 then
		return true
	end
	return false
end

function Level:getEntities()
	return self.entities
end



	





