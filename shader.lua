shader = love.graphics.newShader[[
extern number light = 0;
vec4 colour = vec4(240.0/255,211.0/255,50.0/255,1);
vec4 effect(vec4 pixColour, Image texture, vec2 texCords, vec2 screenCords){
	vec4 pixel = Texel(texture, texCords);
	pixel.r += colour.r*0.03*light;
	pixel.g += colour.g*0.03*light;
	pixel.b += colour.b*0.03*light;
	
	
	return pixel;
	}
]]


return shader
