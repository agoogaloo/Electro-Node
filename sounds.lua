

sounds = {}
sounds.playSounds = true

function loadSounds(path, amount, extension)
	local sounds = {}
	for i=1, amount do
		sounds[i]=love.audio.newSource(path..i..extension, "static")
	end
	
	return sounds
end



function sounds.playSound(soundList)
	print (sounds.playSounds)
	if sounds.playSounds then
		num = math.random(1,#soundList)
		soundList[num]:clone():play()
	end
	

	
end
loaded = false
while not loaded do
	if love.filesystem.getInfo("res/sounds/move1.wav") then
		sounds.move = loadSounds("res/sounds/move",3,".wav")
		sounds.blocked = loadSounds("res/sounds/blocked",3,".wav")
		sounds.connect= loadSounds("res/sounds/connection",1,".wav")
		sounds.win= love.audio.newSource("res/sounds/complete.wav","static")
		sounds.music= love.audio.newSource("res/sounds/music.wav","static")
		sounds.music:setLooping(true)
		loaded  = true
	end
end


return sounds
