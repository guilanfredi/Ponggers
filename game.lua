
local composer = require( "composer" )
local sheetInfo = require("Assets.sprites")
local physics = require("physics")

local scene = composer.newScene()
physics.start();
physics.setGravity(0, 0);

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local backGroup -- Display group for the background image
local mainGroup -- Display group for the ship, asteroids, lasers, etc.
local uiGroup   -- Display group for UI objects like the score

local myImageSheet = graphics.newImageSheet( "Assets/sprites.png", sheetInfo:getSheet() )

local ball
local player1
local player2
local goalPlayer1
local goalPlayer2

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	physics.pause()

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    backGroup = display.newGroup() -- Display group for the background image
	sceneGroup:insert(backGroup)

	mainGroup = display.newGroup() -- Display group for the ships, asteroids, lasers, etc
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup() -- Display group for UI objects like the score
	sceneGroup:insert(uiGroup)

    ball = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Ball"), 20, 20)
	ball.x = display.contentCenterX
	ball.y = display.contentCenterY
	physics.addBody(ball, "dynamic", { radius=10, bounce=1.5});
	ball:setLinearVelocity( math.random(-100, 100), 0)

	player1 = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Player1"), 16, 40)
	player1.x = 20
	player1.y = display.contentCenterY
	local player1_outline = graphics.newOutline( 1, myImageSheet, sheetInfo:getFrameIndex("Player1") )
	physics.addBody(player1, "static", { outline=player1_outline });

	player2 = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Player2"), 16, 40)
	player2.x = display.contentWidth - 20
	player2.y = display.contentCenterY
	local player2_outline = graphics.newOutline( 1, myImageSheet, sheetInfo:getFrameIndex("Player1") )
	physics.addBody(player2, "static", { outline=player2_outline });


	goalPlayer1 = display.newLine(mainGroup, 5,0 , 5,display.contentHeight)
	goalPlayer1.isVisible = false
	goalPlayer2 = display.newLine(mainGroup, display.contentWidth-5,0 , display.contentWidth-5,display.contentHeight)
	goalPlayer2.isVisible = false

    display.newText(uiGroup, "LEL THE GAME", display.contentCenterX, 40, native.systemFont, 36)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
    
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()


	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
