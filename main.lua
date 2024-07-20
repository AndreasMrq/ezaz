local words = {"Ella", "Leon", "Mama", "Papa", "Eis", "Elias", "Mais", "Leise",
		"Oma", "Opa", "Ei", "Alle"}
local game = {}
local colors = {
	{ bkg = { r = 255, g = 127, b = 62 }, fg = { r = 255, g = 246, b = 233 } },
	{ bkg = { r = 33, g = 156, b = 144 }, fg = { r = 255, g = 244, b = 85 } },
	{ bkg = { r = 255, g = 254, b = 225 }, fg = { r = 255, g = 105, b = 105 } },
}
local fontsize = 200

local function updateWord()
	local number = math.random(#words)
	game.word = words[number]:upper()
	game.currentidx = 1
end

local function updateColors()
	local number = math.random(#colors)
	game.color = colors[number]
	local r, g, b = love.math.colorFromBytes(game.color.bkg.r, game.color.bkg.g, game.color.bkg.b)
	love.graphics.setBackgroundColor(r,g,b)
	r, g, b = love.math.colorFromBytes(game.color.fg.r, game.color.fg.g, game.color.fg.b)
	love.graphics.setColor(r,g,b)
end

function love.load()
	love.graphics.setNewFont(fontsize)
	defaultFont = love.graphics.getFont()
	updateWord()
	updateColors()
end

function love.draw()
	local letter_width = defaultFont:getWidth(game.word:sub(game.currentidx,game.currentidx))
	local width = love.graphics.getWidth() / 2 - defaultFont:getWidth(game.word) / 2
	local height = love.graphics.getHeight() / 2 - defaultFont:getHeight(game.word) / 2
	love.graphics.print(game.word, width, height)
	local x_highlight = width + defaultFont:getWidth(game.word:sub(0, game.currentidx-1))
	love.graphics.setColor(0,0,0)
	love.graphics.print(game.word:sub(game.currentidx, game.currentidx), x_highlight, height)
	love.graphics.rectangle('fill', x_highlight, height + defaultFont:getHeight(game.word), letter_width - 5, 10) 
	r, g, b = love.math.colorFromBytes(game.color.fg.r, game.color.fg.g, game.color.fg.b)
	love.graphics.setColor(r,g,b)
end

function love.keyreleased(key)
	if key:upper() == game.word:sub(game.currentidx, game.currentidx) then
		if game.currentidx < #game.word then
			game.currentidx = game.currentidx + 1
		else
			updateWord()
			updateColors()
		end
	end
end
