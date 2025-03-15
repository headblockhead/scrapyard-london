import "CoreLibs/graphics"
import "CoreLibs/object"

local gfx <const> = playdate.graphics

thingy={}
class("thingy").extends()

function thingy:init()
    self.label = {
		x = 155,
		y = 110,
		width = 100,
		height = 20
	}
	self.counterLabel = {
		x = 155,
		y = 200,
		width = 100,
		height = 20
	}
end

function thingy:draw(counter)
    local label = self.label;
	local counterLabel = self.counterLabel;
    gfx.drawTextInRect("Uhh idk", label.x, label.y, label.width, label.height)
	gfx.drawTextInRect("Counter: " .. counter, counterLabel.x, counterLabel.y, counterLabel.width, counterLabel.height)
end