require "consts"
Level = Object:extend()

local blank = 1
local wall = 2
local light = 3
local player = 4

function Level:new(path)
	self:loadLevel(path)
	
	self:makeEntities()
	
end

function Level:loadLevel(path)
	json = require "json"
	 if love.filesystem.getInfo(path) then
			local file = love.filesystem.read(path)
			local data = json.decode(file)
			local tiles = data.layers[1].data
			
			self.level = {}
			self.width = data.layers[1].height
			
			
			
			for y=1,#tiles/self.width do
				local row = {}
				for x = 1,self. width do
					row[x]=tiles[x+(y-1)*self.width]
				end
				self.level[y]=row				
			end
		end
end


function Level:makeEntities()
	require "entities/entity"
	require "entities/node"
	require "entities/player"

	self.entities = {}
	for r = 1,#self.level do
		for c = 1,#self.level[r] do
			if self.level[r][c]==3 then
				table.insert(self.entities, Node(c,r))
			end
			if self.level[r][c]==4 then
				table.insert(self.entities, Player(c,r))
			end
		end
	end
	
end




function Level:draw()
	love.graphics.setColor(1,1,1,1)
	for r = 1,#self.level do
		for c = 1,#self.level[r] do
			if self.level[r][c]==2 then
				love.graphics.rectangle("fill", c*tileSize, r*tileSize, tileSize, tileSize)
			end
		end
	end
end

	
function Level:isWall(x, y)

	if self.level[y][x]==2 then
		return true
	end
	return false
end

function Level:getEntities()
	return self.entities
end



	





