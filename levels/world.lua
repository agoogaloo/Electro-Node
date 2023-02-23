World = Object:extend()

local path = "res/maps/map.json"
local startIndex = 49
local levelIds = {}
levelIds[1]= "tut"
levelIds[3]= "1-1"
levelIds[5]= "1-2"
levelIds[7]= "1-3"

levelIds[13]= "2-1"
levelIds[15]= "2-2"
levelIds[17]= "2-3"

levelIds[23]= "3-1"
levelIds[25]= "3-2"
levelIds[27]= "3-3"

levelIds[33]= "4-1"
levelIds[35]= "4-2"
levelIds[41]= "final"

levelIds[43]= "end"
--levelIds[29]= "test"

--levelIds[9]= "1-1"

local blank = 1
local light = 30
local player = 29

function World:new()
	self.completeLevels = {}
	self:loadMap(path)
	self:makeEntities()
	self.currentLevel =nil
	self.currentId = nil
	self.inputs = {}	
end

function World:loadMap(path)
	self.inputs = {}
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


function World:makeEntities()
	require "entities/entity"
	require "entities/node"
	require "entities/levelNode"
	require "entities/player"

	self.entities = {}
	for r = 1,#self.tiles do
		for c = 1,#self.tiles[r] do
			local id = self.tiles[r][c]
			if id>startIndex then 
				table.insert(self.entities, levelNode(c,r,id-startIndex,self.completeLevels[levelIds[id-startIndex]]~=nil))
				self.tiles[r][c] = blank
			end
			if id== player then
				table.insert(self.entities, Player(c,r))
				self.tiles[r][c] = blank
			end
		end
	end
end

function World:move(dir, eManager)
	
	table.insert(self.inputs, dir)

	if dir == "reset" then
		self:reset(eManager)
	end
	if dir == "undo" then
		self:undo(eManager)
	end
	
		
	if self.currentLevel ==nil then
		self:checkLevelEnter(eManager)		
	elseif self.currentLevel:isComplete() or dir == "esc"then
		if self.currentLevel:isComplete() then
			self.completeLevels[self.currentId]=true
		end
		self.currentLevel = nil
		eManager.clearEntities()
		self:loadMap(path)
		self:makeEntities()
		eManager.addEntities(self.entities)
	end
end

function World:checkLevelEnter(eManager)
	
	for levId,lName in pairs(levelIds) do
		powered = true
		for enti,ent in ipairs(eManager.getEntities()) do
			if ent.id==levId and not ent.connected then
				powered = false
			end
		end
		if powered then
			print("all"..levId.."powered")
			self:loadLevel(lName, eManager)
			return
		end
	end
end


	

function World:reset(eManager)
	if self.currentLevel==nil then
		eManager.clearEntities()
		self:loadMap(path)
		self:makeEntities()
		eManager.addEntities(self.entities)
	else
		eManager.clearEntities()
		print(self.currentId)
		self:loadLevel(self.currentId, eManager)
	end
end

function World:undo(eManager)
	local sound = require "sounds"
	love.audio.setVolume(0)
	local inpCopy = {}
	
	for i,v in ipairs(self.inputs) do
		inpCopy[i]=v
	end		
	self:reset(eManager)
	
	print("redoing ",#inpCopy,"actions")
	for i=1,#inpCopy-2 do
		print("redo",inpCopy[i])
		eManager.move(inpCopy[i],self)
		self.inputs[i]=inpCopy[i]
	end
	love.audio.stop()
	love.audio.setVolume(1)
	sound.playSound(sound.blocked)
	

		

		
		
end


	

function World:loadLevel(id, eManager)
	require "levels/level"
	eManager.clearEntities()
	self.currentLevel = Level("res/maps/"..id..".json")
	self.currentId = id
	self.inputs = {}
	eManager.addEntities(self.currentLevel:getEntities())
	
	
	
	
	print("loading",id)
end

function World:draw()
	local ss = require "spriteSheets"
	if self.currentLevel ~= nil then
		self.currentLevel:draw()
		return self.currentLevel.width,self.currentLevel.height
	else
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
end
	
function World:isWall(x, y)
	if self.currentLevel~=nil then
		return self.currentLevel:isWall(x,y)
	end
	
	if self.walls[y][x] ~=0 then
		return true
	end
	return false
end

function World:getEntities()
	return self.entities
end

function World:getLevelSize()
	if self.currentLevel== nil then
		return self.width,self.height
	end
	return self.currentLevel.width,self.currentLevel.height
end

