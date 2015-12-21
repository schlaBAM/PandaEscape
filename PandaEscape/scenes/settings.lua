--settings.lua

local composer = require( "composer" )
local scene = composer.newScene()

-----------------------------------------------
--*** Set up our variables etc ***
-----------------------------------------------
-- Some handy maths vars
local _W = display.contentWidth
local _H = display.contentHeight
local mF = math.floor 

-- Load our utils / wdiget library
local utils = require("globals")
local widget = require( "widget" )

-- Display Groups
local screenGroup
local uiGroup

-- Functions
local switchPressed

-----------------------------------------------
--*** OTHER FUNCTIONS ***
-----------------------------------------------
switchPressed = function(event)
    local switch = event.target
    utils.playSound("select")

    if switch.id == "sound" then 
        if switch.isOn == true then 
            audio.setVolume(0)
        else
            audio.setVolume(1)
        end
    else
        -- Other switches
    end
end

-----------------------------------------------
-- *** COMPOSER SCENE EVENT FUNCTIONS ***
-----------------------------------------------
-- Called when the scene's view does not exist:
-- Create all your display objects here.
function scene:create( event )
	-- Setup our groups
	screenGroup = self.view
	uiGroup = display.newGroup()
	screenGroup:insert(uiGroup)

    -- Display our UI
    -- The top bar that is made in a utility function
    local options = {
        title = "Settings", 
        backScene = "scenes.levels", -- Set this to a scene name if you want a back button
    }
    local navBar = utils.createNavBar(options)
    uiGroup:insert(navBar)

    -- Create our settings items
    local sound_switch = widget.newSwitch
    {
        left = _W-80,
        top = navBar.y + navBar.height/2 + 44,
        style = "onOff",
        id = "sound",
        onPress = switchPressed
    }
    uiGroup:insert(sound_switch)

    local sound_text = display.newText({parent=uiGroup, text="Enable Sound", font=system.nativeFont, fontSize=16})
    sound_text.anchorX = 0 
    sound_text.x = (display.contentWidth-display.contentWidth) +24
    sound_text.y = sound_switch.y 
    sound_text:setFillColor(0.4)

    if audio.getVolume() == 0 then 
        sound_switch:setState({isOn=false, isAnimated=false})
    else
        sound_switch:setState({isOn=true, isAnimated=false})
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
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

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
