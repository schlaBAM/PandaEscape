
-- Create our local M table
local M = {}

-- Localise a few other helpful vars
local json = require("json")
local composer = require( "composer" ) 

local _W = display.contentWidth
local _H = display.contentHeight

-- Add our UI sprite sheet to M so we can access it elsewhere.
M.uiSheetInfo = require("images.uiSheet")
M.uiSheet = graphics.newImageSheet("images/uiSheet.png", M.uiSheetInfo:getSheet())


-- Sounds
local sounds = {}
sounds["select"] = audio.loadSound("sounds/select.mp3")
sounds["score"] = audio.loadSound("sounds/score.mp3")
sounds["incorrect"] = audio.loadSound("sounds/gameover.mp3")
sounds["clap"] = audio.loadSound("sounds/woo.mp3")
sounds["lose"] = audio.loadSound("sounds/aww.mp3")
sounds["planes"] = audio.loadSound("sounds/planes.mp3")
sounds["purchase"] = audio.loadSound("sounds/purchase.mp3")


local userCoins = {} --used to keep track of user's coins.



--playSound function
M.playSound = function(name) 
	if sounds[name] ~= nil then 
		audio.play(sounds[name])
	end
end

-- save/load with json
M.saveToJson = function( jsonData, filename )
    local filePath = system.pathForFile( filename..".json", system.DocumentsDirectory)
    local file = io.open(filePath, "w")
    file:write( json.encode(jsonData));
    io.close(file); file=nil;
end

M.loadFromJson = function( filename )
    local filePath = system.pathForFile( filename..".json", system.DocumentsDirectory)
    local file = io.open(filePath, "r")
    local jsonParse = {}
    if file ~= nil then 
        local info = file:read("*a")
        if info ~= nil then jsonParse = json.decode(info) end
        io.close(file); file=nil;
    end
    return jsonParse
end

local char = M.loadFromJson("chars")

M.levelLocked = function(event)
        local alert = native.showAlert("Locked","Level locked! Unlock by beating previous levels!", {"Dismiss"}, lockPress)
    end
M.charLocked = function(event)
        local alert = native.showAlert("Not Enough Coins","You don't have enough coins yet! Keep playing!", {"Dismiss"}, lockPress)
    end
M.charChosen = function(name)
		print(name)
        local alert = native.showAlert("Character Selected","You chose ".. name.."! Enjoy!", {"Dismiss"}, lockPress)
    end
M.boostBought = function()
        local alert = native.showAlert("Boost Enabled!", "Boost Enabled! Enjoy!", {"Dismiss"}, lockPress)
    end

M.lockPress = function(event)
    if event.action == "clicked" then
        local i = event.index
        if i == 1 then
            -- Do nothing; dialog will simply dismiss
        end
    end
end

M.getCoins = function()
		if userCoins["coins"] == nil then
		return 0
	else
		return userCoins["coins"]
	end
end

M.updateCoins = function(points)
		print("Points: "..points)
		userCoins["coins"] = points
		return true
end

M.addCoins = function(points)
	if userCoins["coins"] == nil then
		userCoins["coins"] = points
	else
		userCoins["coins"] = userCoins["coins"] + points
	end
end

--buys perks.
M.buyItem = function(points)
	local totalPoints = tonumber( userCoins["coins"] )

	if totalPoints == nil then
		return false
	end
	if totalPoints < points then
		return false
	else
		userCoins["coins"] = userCoins["coins"] - points

		return true
	end
end

M.getSkips = function()
	local skips = char[5].number

	if skips == 0 or nil then
		return 0
	else
		return skips
	end
end

M.incrementSkip = function()
	char[5].number = char[5].number + 1
	return true
end

M.decrementSkip = function()
	char[5].number = char[5].number - 1
	return true
end

M.incrementCancel = function()
	char[7].number = char[7].number + 1
	return true
end

M.decrementCancel = function()
	char[7].number = char[7].number - 1
	return true
end


M.getCancels = function()
	local cancels = char[7].number

	if cancels == 0 or nil then
		return 0
	else
		return cancels
	end
end



M.checkBoost = function()
	if char[6].bought == true then
		return true
	else 
		return false
	end
end


M.chooseCharacter = function(number)
	print(number)
	for i=1, 4 do
		if number == i then
			char[i].chosen = true
			M.charChosen(char[i].title)
			print(char[i].chosen)
		else
			char[i].chosen = false
			print(char[i].chosen)			
		end
	end
return true
end

-- globally create navbar for question scenes.
M.createNavBar = function(options)
	local nav_group = display.newGroup()

	local rect = display.newRect(nav_group, _W*0.5, 24-8, _W, 40)
	rect:setFillColor(52/255, 73/255, 93/255)

	local title = display.newText({parent=nav_group, text="", x=0, y=0, font="Helvetica", fontSize=16})
	title.x = rect.x 
	title.y = rect.y 
	title:setFillColor(1)

	if options then 
		local function buttonTouched(event)
			local t = event.target 
		    local scene = t.scene 

		    if event.phase == "began" then 
		        display.getCurrentStage():setFocus( t )
		        t.isFocus = true
		        t.xScale = 0.9
		        t.yScale = 0.9
		        
		    elseif t.isFocus then
		        if event.phase == "ended" then
		            display.getCurrentStage():setFocus( nil )
		            t.isFocus = false
		            t.xScale = 1
		            t.yScale = 1

		            local b = t.contentBounds 
		            if event.x >= b.xMin and event.x <= b.xMax and event.y >= b.yMin and event.y <= b.yMax then 
		                M.playSound("select")

		               	if scene then 
		               		local effect = "slideRight"

		               		if t.effect ~= nil then 
		               			effect = t.effect
		               		end

		               		t:removeEventListener("touch", buttonTouched)
		               		composer.gotoScene( scene, {effect=effect, time=250})
		               	end
		            end
		        end
		    end
		    return true
		end

		if options.title then 
			title.text = options.title
		end
		
		if options.backScene then 
			local button_back = display.newSprite(M.uiSheet, {frames={M.uiSheetInfo:getFrameIndex("button_back")}})
			button_back.x = button_back.width/2 
			button_back.y = rect.y 
			button_back.scene = options.backScene
			button_back.effect = "slideRight"
			button_back:addEventListener("touch", buttonTouched)
			nav_group:insert(button_back)
		end

		if options.showSettings and options.showSettings == true then 
			local button_settings = display.newSprite(M.uiSheet, {frames={M.uiSheetInfo:getFrameIndex("button_settings")}})
			button_settings.x = _W - button_settings.width/2 - 4
			button_settings.y = rect.y 
			button_settings.scene = "scenes.settings"
			button_settings.effect = "slideLeft"
			button_settings:addEventListener("touch", buttonTouched)
			nav_group:insert(button_settings)
		end

		if options.skip and options.skip > 0 then	
			local skip = display.newSprite(M.uiSheet, {frames={M.uiSheetInfo:getFrameIndex("skip")}})
			skip.x = _W - skip.width/2 - 4
			skip.y = rect.y 
			skip:addEventListener("tap", skipLevel)
			nav_group:insert(skip)
		end

		if options.cancel and options.cancel > 0 then	
			local cancel = display.newSprite(M.uiSheet, {frames={M.uiSheetInfo:getFrameIndex("eliminate")}})
			cancel.x = _W - cancel.width/2 - 50
			cancel.y = rect.y 
			cancel.scene = "scenes.settings"	
			cancel:addEventListener("tap", buttonTouched)
			nav_group:insert(cancel)
		end
	end

	return nav_group
end


--Return it now
return M