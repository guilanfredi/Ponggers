-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

-- Hide status bar
display.setStatusBar(display.HiddenStatusBar)

-- Go to game scene
composer.gotoScene( "game" )
