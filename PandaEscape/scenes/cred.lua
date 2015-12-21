-----------------------------------------------------------------------------------------
--
-- cred.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")

-- include Corona's "widget" library
local widget = require "widget"

local function hideOverlay(event)
    utils.playSound("select")	
	composer.hideOverlay("slideDown", 500)
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


	local credTitle =  display.newText( "Credits", 100, 200, "Helvetica Bold", 20 )
	credTitle.x = display.contentWidth / 2
	credTitle.y = display.contentHeight / 2 - 120

	local credText =[[App created by Brett Morrison.

Images: Brett Morrison, OpenGameArt, Pixabay

Sounds: Brett Morrison, OpenGameArt ]] 

	local options = {
    text = credText,
    x = display.contentCenterX,
    y = display.contentCenterY + 50,
    width = 400,
    height = 180,
    fontSize = 14,
    font = "Helvetica Bold",
    align = "center"
}
	--all media not created taken from websites with a Creative Commons License.

	local textField = display.newText( options )
	textField:setFillColor( 1,1,1)	
	
	
	sceneGroup:insert( background )
	sceneGroup:insert( credTitle )
	sceneGroup:insert( textField )
	sceneGroup:insert( backBtn )
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
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene