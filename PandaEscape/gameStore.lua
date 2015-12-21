-----------------------------------------------------------------------------------------
-- store.lua
-----------------------------------------------------------------------------------------
local sceneName = ...
local composer = require( "composer" )
local utils = require "globals"

local scene = composer.newScene(sceneName)
local widget = require "widget"


--------------------------------------------
local charBtn
local perkBtn

local overlayOptions ={
	--isModal = true,
	effect = "slideUp",
	time = 400
}
local function onMenuBtnRelease()
    utils.playSound("select")	
	composer.gotoScene("scenes.menu", "crossFade", 300)
	return true
end


function scene:create( event )

	local sceneGroup = self.view

	local storeGroup = self:getObjectByName( "storeGroup" )
	storeGroup.x = display.contentCenterX - 220
	storeGroup.y = display.contentCenterY - 120


	local menuBtn = widget.newButton{
	label = "Menu",
	labelColor = { default={255}, over={128} },
	onRelease = onMenuBtnRelease,	-- event listener function
	shape="roundedRect",
	font = "Helvetica Neue Bold",
	fontSize = 10,
   	width = 45,
   	height = 30,
   	cornerRadius = 6,
	fillColor = { default={ 70/255, 155/255, 184/255}, over={ 77/255, 176/255, 209/255} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
	}
	menuBtn.x = display.contentWidth -20
	menuBtn.y = display.contentHeight -(display.contentHeight -10)
	sceneGroup:insert(menuBtn)


	local coins = tonumber(utils.loadFromJson("user_coins"))
	if coins == nil then
		coins = 0
	end

	print("coins: " .. coins)

	local coinsOptions ={
	    text = "You currently have " .. coins .. " PandaBucks. \n Shop for characters / perks!",
	    align = "center",
	    x = display.contentCenterX,
	    y = display.contentHeight -(display.contentHeight -50),
	    width = display.contentWidth - 50,
	    font = "Century Gothic",
	    fontSize = 20
	}
	local pointsText = display.newText( coinsOptions )
	pointsText:setFillColor(1)
	sceneGroup:insert( pointsText )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	-- Called when the scene is still off screen and is about to move on screen
	

	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
	 charBtn = self:getObjectByName( "btn1" )
	 perkBtn = self:getObjectByName( "btn2" )
	
	 if charBtn then
	    function charBtn:touch( event )
        	local phase = event.phase
        		if "ended" == phase then
        		    utils.playSound("select")
        			composer.gotoScene("scenes.charOverlay", overlayOptions)
        		end
        	end
        end
      if perkBtn then  
	    function perkBtn:touch ( event )
        	local phase = event.phase
        		if "ended" == phase then
        		    utils.playSound("select")
        			composer.gotoScene("scenes.boostOverlay", overlayOptions)
        		end
        	end 
        end  

	charBtn:addEventListener("touch", charBtn)
	perkBtn:addEventListener("touch", perkBtn)     	
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
		if charBtn then
			charBtn:removeEventListener( "touch", charBtn )
		end
		if perkBtn then
			perkBtn:removeEventListener( "touch", perkBtn )
		end
	
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
		if menuBtn then
		menuBtn:removeSelf()	-- widgets must be manually removed
		menuBtn = nil
	end
	if char1Btn then
		char1Btn:removeSelf()
		char1Btn = nil
	end
	if char2Btn then
		char2Btn:removeSelf()
		char2Btn = nil
	end
	if char3Btn then
		char3Btn:removeSelf()
		char3Btn = nil
	end
end

function scene:overlayBegan( event )
   print( "The overlay scene is showing: " .. event.sceneName )
end
scene:addEventListener( "overlayBegan" )

function scene:overlayEnded(event)
	 print( "The following overlay scene was removed: " .. event.sceneName )
	coins = utils.getCoins()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener("overlayEnded", scene)

-----------------------------------------------------------------------------------------

return scene