

function loadSounds(path, amount, extension)
	local sounds = {}
	for i=1, amount do
		sounds[i]=love.audio.newSource(path..i..extension, "static")
	end
	
	return sounds
end

sounds = {}

function sounds.playSound(sounds)
	num = math.random(1,#sounds)
	sounds[num]:clone():play()
end

		
sounds.move = loadSounds("res/sounds/move",3,".wav")
sounds.blocked = loadSounds("res/sounds/blocked",3,".wav")
sounds.connect= love.audio.newSource("res/sounds/connection1.wav","static")

return sounds
