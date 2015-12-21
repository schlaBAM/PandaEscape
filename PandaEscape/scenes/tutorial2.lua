--tutorial2.lua
--second tutorial scene to help user learn syntax.
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

local function tutorial3(event)
    utils.playSound("select")	
	composer.hideOverlay("slideLeft", 300)
	composer.showOverlay("scenes.tutorial3", overlayOptions)
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
	backBtn.x = display.contentWidth *0.5 + 30
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
	nextBtn.x = display.contentWidth *0.5 + 160
	nextBtn.y = display.contentHeight - 40
	nextBtn:addEventListener ("tap", tutorial3)




	local credTitle =  display.newText( "For Loops Syntax", 90, 15, "Helvetica Bold", 18, "left" )

	local credText = [[For loops provide a great way to iterate over a range of values. There are three parts inside the loop that will be discussed:

	for(int i = 0; i < 11; i++) { statement(s)}

The first expression (int i = 0) is the initialization of the loop, and is executed once when the loop begins to initialize the variable.
	
The second expression is the termination value, which states in this case that when the variable is incremented to 11, the loop will return false and terminate. (This could be any operator.)
	
The third expression is the increment value, which tells the loop how to iterate 'i' during the loop. In this case, "i++" is telling the loop to add (i+1) to the value of i and continue to iterate through the loop.

	Seems simple enough, right?
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