-----------------------------------------------------------------------------------------
--
-- cred.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")
--local char = require("questions.characters")
local char = utils.loadFromJson("chars")


-- include Corona's "widget" library
local widget = require "widget"
local buy1Btn
local buy2Btn
local buy3Btn
local choose2Btn

local buyBtnOptions = {
	label = "Buy",
	labelColor = { default={255}, over={128} },
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
local chooseOptions = {
	label = "Active",
	labelColor = { default={255}, over={128} },
	shape="roundedRect",
	font = "Helvetica Neue Bold",
	fontSize = 10,
   	width = 45,
   	height = 30,
   	cornerRadius = 6,
   	fillColor = { default={ 0, 204/255, 0}, over={ 0, 1, 0} },
	strokeColor = ({ default={ 32/255, 75/255, 89/255 }, over={ 32/255, 75/255, 89/255 } }),
   	strokeWidth = 3
}


local function hideOverlay(event)
    utils.playSound("select")	
    utils.saveToJson(char, "chars")

	composer.gotoScene("gameStore","slideDown",500)
end 


function updateButtons()
	    utils.saveToJson(char, "chars")

		if char[6].bought == false then
		buy2Btn.isVisible = true
		choose2Btn.isVisible = false
	else
		buy2Btn.isVisible = false
		choose2Btn.isVisible = true
	end
end

function buyPerk(event)
	local label = event.target.name
	local cost = event.target.cost
	local totalPoints = utils.loadFromJson("user_coins")
	print("Name: " ..label)
	print("Total Points: "..totalPoints)
	print("Cost: "..cost)

	if totalPoints == nil then
		utils.charLocked()
		return false
	end
	if totalPoints < cost then
		utils.charLocked()
		return false
	else
		totalPoints = totalPoints - cost
		print("Left: "..totalPoints)
			utils.updateCoins(totalPoints)
			utils.saveToJson(totalPoints, "user_coins")
			utils.playSound("purchase")
			if label == "Skip" then
			char[5].number = char[5].number + 1
		elseif label == "Boost" then
			char[6].bought = true
			utils.boostBought()				
		elseif label == "Cancel" then
				utils.incrementCancel()
		end
		updateButtons() --update buy/choose button
		return true
	end
end

function chooseChar(event)
	local number = event.target.number
	utils.chooseCharacter(number)
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor(0)
	background.alpha = 0.9
	sceneGroup:insert( background )

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

	buy1Btn = widget.newButton(buyBtnOptions)
	buy1Btn.anchorX = 0
	buy1Btn.anchorY = 0	
	buy1Btn.name = "Skip"
	buy1Btn.cost = 5000
	buy1Btn.x = display.contentWidth - 75
	buy1Btn.y = display.contentCenterY -65
	buy1Btn:addEventListener("tap", buyPerk)

	buy2Btn = widget.newButton(buyBtnOptions)
	buy2Btn.anchorX = 0
	buy2Btn.anchorY = 0
	buy2Btn.name = "Boost"
	buy2Btn.cost = 5000			
	buy2Btn.x = display.contentWidth - 75
	buy2Btn.y = display.contentCenterY - 18
	buy2Btn:addEventListener("tap", buyPerk)

	choose2Btn = widget.newButton(chooseOptions)
	choose2Btn.anchorX = 0
	choose2Btn.anchorY = 0	
	choose2Btn.name = "Boost"
	choose2Btn.x = display.contentWidth - 75
	choose2Btn.y = display.contentCenterY - 18
	sceneGroup:insert(choose2Btn)

	updateButtons()
--[[
	buy3Btn = widget.newButton(buyBtnOptions)
	buy3Btn.label = "Coming Soon"
	buy3Btn.anchorX = 0
	buy3Btn.anchorY = 0		
	buy3Btn.name = "Cancel"
	buy3Btn.cost = 5000	
	buy3Btn.x = display.contentWidth - 75
	buy3Btn.y = display.contentCenterY + 27
	buy3Btn:addEventListener("tap", buyPerk)
]]
	local skipPng = display.newImage("images/skipLevel.png", 40, 32)
	skipPng.anchorX = 0
	skipPng.anchorY = 0
	skipPng.x = 10
	skipPng.y = display.contentCenterY -65


	local boostPng = display.newImage("images/time.png", 35, 35)
	boostPng.anchorX = 0
	boostPng.anchorY = 0
	boostPng.x = 10
	boostPng.y = display.contentCenterY -25


	local elimPng = display.newImage("images/answer.png", 35, 38)
	elimPng.anchorX = 0
	elimPng.anchorY = 0	
	elimPng.x = 10
	elimPng.y = display.contentCenterY + 20


	local credTitle =  display.newText( "Buy Perks", 100, 200, "Helvetica Bold", 20 )
	credTitle.x = display.contentWidth / 2
	credTitle.y = display.contentHeight / 2 - 120
 
	local credText =[[Skip Level - Skip the level, keep the points!                    5000 PB



Points Boost - After buying, gain 10% extra points!       5000 PB



Cancel Answer - Coming Soon!]] 

	local options = {
    text = credText,
    x = 240,
    y = display.contentCenterY + 35,
    width = 360,
    height = 180,
    fontSize = 12,
    font = "Helvetica Bold",
    align = "left"
}

	local textField = display.newText( options )

	textField:setFillColor( 1,1,1)	
	
	
	sceneGroup:insert( credTitle )
	sceneGroup:insert( textField )
	sceneGroup:insert( backBtn )
	sceneGroup:insert(skipPng)
	sceneGroup:insert(boostPng)
	sceneGroup:insert(elimPng)
	sceneGroup:insert(buy1Btn)
	sceneGroup:insert(buy2Btn)
	--sceneGroup:insert(buy3Btn)



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