--world.lua

local World={}
local mt={__index=World}
local Moveable=Moveable
local TEsound=TEsound
local love=love
local ipairs=ipairs

function World:loadFile(filepath)
	w,t,f={},true,false
	local file=love.filesystem.newFile(filepath)
	if assert(file:open("r"),filepath.." could not be opened.") then
		for line in file:lines() do
			if string.sub(line,1,2)=="n=" then
				w["name"]=string.gsub(line,"n=","",1)
			elseif string.sub(line,1,2)=="f=" then
				w["f"]=string.gsub(line,"f=","",1)
			elseif string.sub(line,1,2)=="a=" then
				w["a"]=string.gsub(line,"a=","",1)
			elseif string.sub(line,1,2)=="g=" then
				w["g"]=string.gsub(line,"g=","",1)
			elseif string.sub(line,1,6)=="music=" then
				w["music"]="resources/music/"..string.gsub(line,"music=","",1)
			else
				w[string.gsub(line,"=.+","")]=
				assert(loadstring("return Moveable:new(w,"..string.gsub(line,".+=","")..")")(),"could not load line: "..line)
	end	end	end
	local rw=w;w,t,f=nil,nil,nil
	setmetatable(rw,mt)
	return rw
end

function World:initializeCollisions()
	for i,ma in ipairs(self) do
		for imi,imma in ipairs(self) do
			if type(imma)=="table" then
				ma.worldxcount[imma]=0
				ma.worldycount[imma]=0
end	end	end	end

function World:basicSprites(r,g,b)
	local fill="fill"
	love.graphics.setColor(r or 0,g or 0,b or 0)
	for i,ma in ipairs(self) do
		love.graphics.setCanvas(ma.sprite)
		love.graphics.rectangle(fill,0,0,ma.xl,ma.yl)
	end
	love.graphics.setCanvas()
end

function World:playMusic() TEsound.play(self.music) end
function World:pauseMusic() TEsound.pause(self.music) end

return World
