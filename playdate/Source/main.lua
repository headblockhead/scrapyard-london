import "display" -- DEMO
import "CoreLibs/crank"
local thingy = thingy() -- DEMO

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

loadGame()

crankedCount = 0
local myInputHandlers = {
	cranked = function(change, acceleratedChange)
		crankedCount = crankedCount + 1
		if crankedCount == 10 then
			crankedCount = 0
			print("Cranked")
		end
    end,
}
playdate.inputHandlers.push(myInputHandlers)

function drawGame()
	gfx.clear()
	thingy:draw(crankedCount)
end


function playdate.update()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end