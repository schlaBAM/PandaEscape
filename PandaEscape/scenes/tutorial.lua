--tutorial.lua
--tutorial level to help user learn syntax.
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local utils = require("globals")


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

local function tutorial2(event)
    utils.playSound("select")
	composer.hideOverlay("slideLeft", 300)
	composer.showOverlay("scenes.tutorial2", overlayOptions)
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
	label = "Next",
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
	nextBtn:addEventListener ("tap", tutorial2)




	local credTitle =  display.newText( "For Loops", 70, 25, "Helvetica Bold", 18, "left" )

	local credText = [[

Panda Escape focuses on Java for loop syntax, while asking various questions using for loops.

As Jumbo the Elephant Scientist, choose the correct answer to move a step away from the evil panda and closer to the finish! Every correct choice gets you points for customization and special perks in the store!

The quicker you answer, the better! The total time per question you have left is multiplied * 2 and combined with the level points!

If you answer wrong, and the panda catches up and eats you. Good luck!]]
	
	local options = {
    text = credText,
    x = display.contentCenterX,
    y = display.contentCenterY +25,
    width = 400,
    height = 280,
    fontSize = 13,
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
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene