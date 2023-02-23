function love.conf(t)
	require "consts"
	t.window.width = pixelScale*tileSize*screenWidth
	t.window.height = pixelScale*tileSize*screenHeight
	t.window.title = "Electro-Node"
	t.window.icon = "res/icon.png"   
	t.modules.physics = false

end