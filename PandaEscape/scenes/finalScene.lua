-----------------------------------------------------------------------------------------
--
-- finalScene.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")

-- include Corona's "widget" library
local widget = require "widget"

local menuBtn
local cntuBtn

function displayButtons()
	menuBtn = widget.newButton{
	label = "Menu",
	labelColor = { default={255}, over={128} },
	onRelease = goToMenu,
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 100,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	menuBtn.anchorX, menuBtn.anchorY = 0,0
	menuBtn.x, menuBtn.y = 30, display.contentHeight - 50

	cntuBtn = widget.newButton{
	label = "Levels",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	onRelease = goToLevels,
	font = "Helvetica Neue Bold",
   	width = 100,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	cntuBtn.anchorX, cntuBtn.anchorY = 0,0
	cntuBtn.x, cntuBtn.y = display.contentWidth - 130, display.contentHeight - 50
end

function goToMenu()
	composer.gotoScene("scenes.menu")
	return true	
end

function goToLevels()
	composer.gotoScene("scenes.levels")
	return true
end



function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "images/transition.png", display.contentWidth, display.contentHeight )
	--needs to be fixed
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	--[[local plane1 = display.newImage("images/plane1.png", 100, 82)
	plane1.anchorX = 0
	plane1.anchorY = 0
	plane1.x, plane1.y = -150, 10
	transition.to(plane1, {delay = 800, alpha = 1, time=2200, x=display.contentWidth + 40, y = 10,onComplete = displayButtons })
]]
	local plane2 = display.newImage("images/plane2.png", 100, 82)
	plane2.anchorX = 0
	plane2.anchorY = 0
	plane2.x, plane2.y = -150, 10
	transition.to(plane2, {rotation = 13, alpha = 1, time=2200, x=display.contentWidth + 40, y = 10, onComplete = displayButtons})
	
	local credText = "Congratulations! You got away!"

	local options = {
    text = credText,
    x = display.contentCenterX,
    y = display.contentHeight + 40,
    width = 300,
    height = 180,
    fontSize = 14,
    font = "Helvetica Bold",
    align = "center"
}
	--all media not created taken from websites with a Creative Commons License.

	local textField = display.newText( options )
	textField:setFillColor(0)	

	sceneGroup:insert( background )
	sceneGroup:insert(textField)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
						utils.playSound("planes")	

	elseif phase == "did" then
		-- Called when the scene is now on screen

		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen

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
		if menuBtn then
		menuBtn:removeSelf()	-- widgets must be manually removed
		menuBtn = nil
	end
			if cntuBtn then
		cntuBtn:removeSelf()	-- widgets must be manually removed
		cntuBtn = nil
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