
display.setStatusBar( display.HiddenStatusBar ) 

local composer = require("composer")

composer.recycleOnSceneChange = true

display.setDefault("background", 178/255, 190/255, 181/255)

composer.gotoScene( "scenes.menu", {effect="fade", time=250})


-- Created by Brett Morrison. 

--[[

Needs work:

	Complete (overall):
		-getCoins
		-addCoins
		-subtractCoins (when buying items)
		-physical store UI layout (get/create buttons as well)
		-buy object overlay files
		-fixed title to Panda Escape, higher quality png
		-lock higher levels
		-sprite sheet changed (still needs icons maybe?)
		-transition scenes
		-updated cred.lua
		-added plane sounds to transtion.lua 
		-created custom win/lose sounds
		-fixed coin balance to update after buying object
		-ability to change characters implemented 
		-choose/buy button function implemented
		-choose/buy connected
		-fixed store coins updating to item cost bug
		-CHAR OVERLAY DONE!
		-function to boost points
		-purchase sound implemented
		- skip / eliminate icons added to nav bar if they're > 0
		-function to skip level implemented, NOT FINISHED
		-Jumbo added to charOverlay
		-orientation bug fixed
		-fixed save issues (coins, levels, highscores)
		-SKIP ANSWER FULLY IMPLEMENTED FUCK YES
		-characters/perks/level saves finally work properly
		-final scene
		-eliminate question into navbar implemented, STILL TODO: GET FUNCTION TO WORK
		-fixed skip not decrementing issue
		-extreme questions added
		-level lock glitch fixed
	
	Needed:
		-GET ELIMINATE TO WORK


]]