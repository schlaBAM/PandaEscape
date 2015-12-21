--tutorial3.lua
--third / last tutorial scene to help user learn syntax.
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")

-- include Corona's "widget" library
local widget = require "widget"

local backBtn
local nextBtn

local overlayOptions ={
	isModal = true,
	effect = "slideRight",
	time = 250
}

local function hideOverlay(event)
	utils.playSound("select")
	composer.hideOverlay("fade", 500)
end 

local function startGame(event)
    utils.playSound("select")
	composer.hideOverlay("fade", 500)
	composer.gotoScene("scenes.levels")
end

local function restartTut(event)
	utils.playSound("select")
	composer.hideOverlay("slideLeft", 300)
	composer.showOverlay("scenes.tutorial", overlayOptions)	
end

--avoids accidental behind-scene widget presses.
function preventHits(event)
	return true
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(0)
	background.alpha = 0.8
	background.isHitTestable = true
	background:addEventListener("tap", preventHits)
	background:addEventListener("touch", preventHits)

	backBtn = widget.newButton{
	label = "Menu",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 100,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	backBtn.x = display.contentWidth *0.5 
	backBtn.y = display.contentHeight - 40
	backBtn:addEventListener ("tap", hideOverlay)	

	nextBtn = widget.newButton{
	label = "Play",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 100,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	nextBtn.x = display.contentWidth *0.5 + 130
	nextBtn.y = display.contentHeight - 40
	nextBtn:addEventListener ("tap", startGame)


	restartBtn = widget.newButton{
	label = "Restart",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 100,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	restartBtn.x = display.contentWidth *0.5 - 130
	restartBtn.y = display.contentHeight - 40
	restartBtn:addEventListener ("tap", restartTut)




	local credTitle =  display.newText( "For Loops Syntax", 90, 15, "Helvetica Bold", 18, "left" )

	local credText = [[So, slightly modifying our for loop on the last slide as an example:

for(int i = 0; i < 11; i++) { System.out.print(i + " ")}

This loop starts at i=0, and every time through the loop prints the current value of i until it increments up to 11, where it will terminate before going through the loop again. This leaves us with:

0 1 2 3 4 5 6 7 8 9 10   (Note, that this was still 11 steps because we started at zero.)

In this game, you will be asked questions like this example, or other questions such as using methods inside the loop to get to the correct location. Ready to start?
]]
	
	local options = {
    text = credText,
    x = display.contentCenterX,
    y = display.contentCenterY +25,
    width = 400,
    height = 280,
    fontSize = 12,
    font = "Helvetica Bold",
    align = "left"
}

	local textField = display.newText( options )
	textField:setFillColor( 1,1,1)	

	sceneGroup:insert( background )
	sceneGroup:insert( credTitle )
	sceneGroup:insert( textField )
	sceneGroup:insert( backBtn )
	sceneGroup:insert( nextBtn )
	sceneGroup:insert( restartBtn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
		if backBtn then
			backBtn:removeSelf()	-- widgets must be manually removed
			backBtn = nil
		end

		if nextBtn then
			nextBtn:removeSelf()
			nextBtn = nil
		end

		if restartBtn then
			restartBtn:removeSelf()
			restartBtn = nil
		end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene