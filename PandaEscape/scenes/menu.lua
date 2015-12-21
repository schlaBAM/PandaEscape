-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")
local char = require("questions.characters")
local levels = require("questions.categories")

-----------------------------------------------
--Checking for characters and level unlocks----
local path = system.pathForFile( "levels.json", system.DocumentsDirectory )
local fh = io.open( path, "r" )

if fh then

utils.loadFromJson("levels")

else
utils.loadFromJson("levels")
utils.saveToJson(levels, "levels")

end


local path = system.pathForFile( "chars.json", system.DocumentsDirectory )
local fh = io.open( path, "r" )

if fh then

utils.loadFromJson("chars")

else
utils.loadFromJson("chars")
utils.saveToJson(char, "chars")

end




-------------------------------------------------


-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn
local tutBtn
local credBtn

local overlayOptions ={
	isModal = true,
	effect = "crossFade",
	time = 400
}

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
    utils.playSound("select")
	composer.gotoScene( "scenes.levels","fade", 300)
	
	return true	-- indicates successful touch
end

--'onRelease' event listener for tutBtn
local function onTutBtnRelease()
    utils.playSound("select")
	composer.showOverlay( "scenes.tutorial", overlayOptions)

	return true 
end

--'onRelease' event listener for credBtn
local function onCredBtnRelease()
    utils.playSound("select")
	composer.showOverlay("scenes.cred", {effect = "slideUp", isModal = true, time = 400})
	return true
end

local function onCartBtnRelease()
    --utils.playSound("select")	
	composer.gotoScene("gameStore", "fade", 100)
	return true
end


function scene:create( event )

	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "images/background.png", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "images/title2.png", 320, 80 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 75
	
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Play",
		labelColor = { default={255}, over={128} },
		onRelease = onPlayBtnRelease,	-- event listener function
		shape="roundedRect",
		font = "Helvetica Neue Bold",
    	width = 140,
    	height = 40,
    	cornerRadius = 2,
		fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
		strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
    	strokeWidth = 3
		}
	
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 140

	tutBtn = widget.newButton{
	label = "Tutorial",
	labelColor = { default={255}, over={128} },
	onRelease = onTutBtnRelease,	-- event listener function
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 140,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	tutBtn.x = display.contentWidth *0.5
	tutBtn.y = display.contentHeight - 90

	credBtn = widget.newButton{
	label = "Credits",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	font = "Helvetica Neue Bold",
   	width = 140,
   	height = 40,
   	cornerRadius = 2,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3,
   	onRelease = onCredBtnRelease	-- event listener function
	}
	credBtn.x = display.contentWidth *0.5
	credBtn.y = display.contentHeight - 40

	local cart = widget.newButton{
    width = 40,
    height = 38,
    defaultFile = "images/cart.png",
    overFile = "images/cart.png",
    name = "storeButton",
    onEvent = onCartBtnRelease
}
	cart.x = display.contentWidth - 23  
	cart.y = display.contentHeight - 23 

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( cart )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( tutBtn )
	sceneGroup:insert( credBtn )
	sceneGroup:insert( cart )
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
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	if tutBtn then
		tutBtn:removeSelf()
		tutBtn = nil
	end
	if credBtn then
		credBtn:removeSelf()
		credBtn = nil
	end
	--[[if soundBtn then
		soundBtn:removeSelf()
		soundBtn = nil
	end--]]
	if cart then
		cart:removeSelf()
		cart = nil
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