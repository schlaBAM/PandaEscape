--levels.lua

local composer = require( "composer" )
local scene = composer.newScene()
local utils = require("globals")
local categories = require("questions.categories")


local levelLock = utils.loadFromJson("levels")
-----------------------------------------------
--*** Set up our variables etc ***
-----------------------------------------------
-- Some handy maths vars
local _W = display.contentWidth
local _H = display.contentHeight
local mF = math.floor 

local widget = require( "widget" )

-- Display Groups
local screenGroup
local uiGroup

local touchEnabled = false

local buttonTapped

-----------------------------------------------
--*** OTHER FUNCTIONS ***
-----------------------------------------------
-- Button tapped - For scrollView items
buttonTapped = function(event)
    local t = event.target
    local category = t.category

    if category ~= nil and touchEnabled == true then 
        utils.playSound("select")
        composer.gotoScene( "scenes.game", {effect="slideLeft", time=300, params={category=category}})
    end

    return true 
end




function scene:create( event )
	-- Setup our groups

	screenGroup = self.view
	uiGroup = display.newGroup()
	screenGroup:insert(uiGroup)

    -- Display our UI
    local options = {
        title = "Levels", 
        backScene = "scenes.menu", 
        showSettings = true 
    }
    local navBar = utils.createNavBar(options)
    uiGroup:insert(navBar)


    local scrollTop = navBar.y + navBar.height 
    local scrollHeight = _H - scrollTop
    local categoryHeight = 84
    local categoryOffset = 2

    local scrollView = widget.newScrollView{
        top = scrollTop,
        left = 0,
        width = _W,
        height = scrollHeight,
        backgroundColor = {178/255, 190/255, 181/255}
    }
    uiGroup:insert(scrollView)
    

    for i=1, #levelLock do 
        local colour = levelLock[i].colour
        local y = (i-1)*(categoryHeight+categoryOffset) + (categoryHeight/2)
        local textX = 36
        local textW = _W-(textX*2) - 64 -- an extra 64 for icons
        local icon --level icon / locked icon

        --category boxes.
        local rect = display.newRect(_W*0.5, y, _W, categoryHeight )
        rect:setFillColor(colour[1], colour[2], colour[3])
        rect.category = i 

        if levelLock[i].locked == true then
            rect:addEventListener("tap", utils.levelLocked)
         else   
            rect:addEventListener("tap", buttonTapped)
        end
        scrollView:insert(rect)

        local arrow = display.newSprite(utils.uiSheet, {frames={utils.uiSheetInfo:getFrameIndex("arrow")}})
        arrow.x = arrow.width/2 + 4
        arrow.y = rect.y 
        scrollView:insert(arrow)

        local title = display.newText({text=levelLock[i].title, x=textX, y=rect.y-6, width=textW, height=0, font="Helvetica Bold", fontSize=16})
        title.anchorX = 0 
        title:setFillColor(1)
        scrollView:insert(title)

        if levelLock[i].subtitle and levelLock[i].subtitle ~= "" then 
            local subtitle = display.newText({text=levelLock[i].subtitle, x=textX, y=(title.y+title.height/2+2), width=textW, height=0, font="Helvetica", fontSize=12})
            subtitle.anchorX = 0 
            subtitle.anchorY = 0 
            subtitle:setFillColor(1)
            scrollView:insert(subtitle)
        end

        if levelLock[i].icon and levelLock[i].icon ~= "" then 
            if levelLock[i].locked == true then
                icon = display.newSprite(utils.uiSheet, {frames={utils.uiSheetInfo:getFrameIndex(levelLock[i].lockedIcon)}})
            else
            icon = display.newSprite(utils.uiSheet, {frames={utils.uiSheetInfo:getFrameIndex(levelLock[i].icon)}})
            end
            icon.x = _W - 40
            icon.y = rect.y 
            scrollView:insert(icon)
        end
    end
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        composer.removeHidden() 

        -- Now that the scene has appeared, allow dragging etc
        touchEnabled = true      
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        touchEnabled = false

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-- Then add the listeners for the above functions
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
