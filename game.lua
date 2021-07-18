
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
local upperSideline
local lowerSideline
local scoreText1
local scoreText2

local goalOffset = 5
local sidelineOffset = 15
local initialSpeed = 100
local score = {player1=0, player2=0}

local function getInitialSpeed()
	-- Equation -> x² + y² = r²
	local x = math.random(10, 90)
	local y = math.sqrt(math.pow(initialSpeed,2) - math.pow(x,2))

	-- Multiply values with -1 or 1 ramdomly to change direction
	local values = { -1, 1 }
	local sinalx = values[math.random(#values)]
	local sinaly = values[math.random(#values)]

	return { x = x * sinalx, y = y * sinaly }
end

local function updateScores()
	scoreText1.text = score.player1
	scoreText2.text = score.player2
end

local function onGlobalCollision( event )
	local obj1 = event.object1
	local obj2 = event.object2
    
	if ( event.phase == "began" ) then
        if ((obj1.myName == "goalPlayer1" and obj2.myName == "ball") or (obj1.myName == "ball" and obj2.myName == "goalPlayer1")) then
			score.player2 = score.player2 + 1
			updateScores()
			--startMatch()
		elseif ((obj1.myName == "goalPlayer2" and obj2.myName == "ball") or (obj1.myName == "ball" and obj2.myName == "goalPlayer2")) then
			score.player1 = score.player1 + 1
			updateScores()
			--startMatch()
		end

    elseif ( event.phase == "ended" ) then
        print( "ended: " .. event.object1.myName .. " and " .. event.object2.myName )
    end
end
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

	-- Main

    ball = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Ball"), 20, 20)
	ball.x = display.contentCenterX
	ball.y = display.contentCenterY
	ball.myName = "ball"
	physics.addBody(ball, "dynamic", { radius=5, bounce=1.0});
	
	player1 = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Player1"), 16, 40)
	player1.x = 20
	player1.y = display.contentCenterY
	player1.myName = "player1"
	local player1_outline = graphics.newOutline( 1, myImageSheet, sheetInfo:getFrameIndex("Player1") )
	physics.addBody(player1, "static", { outline=player1_outline });

	player2 = display.newImageRect(mainGroup, myImageSheet, sheetInfo:getFrameIndex("Player2"), 16, 40)
	player2.x = display.contentWidth - 20
	player2.y = display.contentCenterY
	player2.myName = "player2"
	local player2_outline = graphics.newOutline( 1, myImageSheet, sheetInfo:getFrameIndex("Player1") )
	physics.addBody(player2, "static", { outline=player2_outline });

	goalPlayer1 = display.newRect(mainGroup, goalOffset, display.contentCenterY, 5, display.contentHeight)
	goalPlayer1.isVisible = true
	goalPlayer1.myName = "goalPlayer1"
	physics.addBody(goalPlayer1,"static", { isSensor=true })

	goalPlayer2 = display.newRect(mainGroup, display.contentWidth-goalOffset, display.contentCenterY, 5, display.contentHeight)
	goalPlayer2.isVisible = true
	goalPlayer2.myName = "goalPlayer2"
	physics.addBody(goalPlayer2,"static", { isSensor=true })

	upperSideline = display.newRect(mainGroup, display.contentCenterX, sidelineOffset, display.contentWidth, 5)
	upperSideline.isVisible = true
	upperSideline.myName = "upperSideline"
	physics.addBody(upperSideline, "static")

	lowerSideline = display.newRect(mainGroup, display.contentCenterX, display.contentHeight - sidelineOffset, display.contentWidth, 5)
	lowerSideline.isVisible = true
	lowerSideline.myName = "lowerSideline"
	physics.addBody(lowerSideline, "static")

	-- UI

    display.newText(uiGroup, "LEL", display.contentCenterX, 40, native.systemFont, 36)

	scoreText1 = display.newText(uiGroup, score.player1, (display.contentCenterX/2), 40, native.systemFont, 36);
	scoreText2 = display.newText(uiGroup, score.player2, (display.contentWidth/4)*3, 40, native.systemFont, 36);
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
    
	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		local speed = getInitialSpeed()
		ball:setLinearVelocity( speed.x, speed.y)
		
		physics.start()
		
		Runtime:addEventListener( "collision", onGlobalCollision )
		

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
