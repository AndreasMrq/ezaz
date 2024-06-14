local all = "abcdefghijklmnopqrstuvwxyz1234567890"
local game = {}
local colors = {
	{ bkg = { r = 255, g = 127, b = 62 }, fg = { r = 255, g = 246, b = 233 } },
	{ bkg = { r = 33, g = 156, b = 144 }, fg = { r = 255, g = 244, b = 85 } },
	{ bkg = { r = 255, g = 254, b = 225 }, fg = { r = 255, g = 105, b = 105 } },
}

local function updatekey()
	local number = math.random(#all)
	game.key = all:sub(number, number)
end

local function updateColors()
	local number = math.random(#colors)
	local color = colors[number]
	local r, g, b = love.math.colorFromBytes(color.bkg.r, color.bkg.g, color.bkg.b)
	love.graphics.setBackgroundColor(r,g,b)
	r, g, b = love.math.colorFromBytes(color.fg.r, color.fg.g, color.fg.b)
	love.graphics.setColor(r,g,b)
end

function love.load()
	updatekey()
	updateColors()
end

function love.draw()
	love.graphics.setNewFont(200)
	local font = love.graphics.getFont()
	local width = love.graphics.getWidth() / 2 - font:getWidth(game.key) / 2
	local height = love.graphics.getHeight() / 2 - font:getHeight(game.key) / 2
	love.graphics.print(game.key:upper(), width, height)
end

function love.keyreleased(key)
	if key == game.key then
		updatekey()
		updateColors()
	end
end
