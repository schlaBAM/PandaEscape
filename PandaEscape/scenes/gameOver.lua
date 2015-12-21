--- Game Over Scene ---
local composer = require( "composer" )
local scene = composer.newScene()

-----------------------------------------------
-------------------Variables-------------------
-----------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight
local mF = math.floor 

-- Load our utils, image sheet etc
local utils = require("globals")
local categories = require("questions.categories")

-- Display Groups
local screenGroup
local uiGroup

-- Variables 
local touchEnabled = false
local category = {}
local onCategory = 0 
local currentScore = 0  
local highscore = 0 
local numQuestions = 0 
local colour = {}
local lab1
local lab2
local lab3
local lab4
local totalScore
local points = 0

-- Functions
local buttonTouched

-----------------------------------------------
--*** OTHER FUNCTIONS ***
-----------------------------------------------
-- Button touched 
buttonTouched = function(event)
    local t = event.target 
    local id = t.id 

    if event.phase == "began" and touchEnabled == true then 
        display.getCurrentStage():setFocus( t )
        t.isFocus = true
        t.alpha = 0.6
        
    elseif t.isFocus then
        if event.phase == "ended" then
            display.getCurrentStage():setFocus( nil )
            t.isFocus = false
            t.alpha = 1

            local b = t.contentBounds 
            if event.x >= b.xMin and event.x <= b.xMax and event.y >= b.yMin and event.y <= b.yMax then 
                utils.playSound("select")

                if id == "home" then 
                    composer.gotoScene( "scenes.menu", {effect="slideRight", time=300})

                elseif id == "continue" then
                    composer.gotoScene( "scenes.transition", {effect="slideRight", time=300})

                elseif id == "restart" then
                    composer.gotoScene( "scenes.levels", {effect="slideRight", time=300})
                end
            end
        end
    end
    return true
end

function finalScene()
     composer.gotoScene("scenes.finalScene")
     return true
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

    -- Set our category, correct answers answered and total score (points)
    if event.params then 
        if event.params.onCategory then 
            onCategory = event.params.onCategory
            category = categories[onCategory]
            print(onCategory)
            print(category)
            colour = category.colour
        end
        if event.params.currentScore then 
            currentScore = event.params.currentScore
        end
        if event.params.numQuestions then 
            numQuestions = event.params.numQuestions
        end
        if event.params.totalPoints then
            totalScore = event.params.totalPoints
        end
    end
    
    utils.loadFromJson("levels")
    --set the navBar's gameOver text
    if currentScore < 6 then
        media.playEventSound( "sounds/aww.mp3" )        
       -- utils.playSound("lose")
        title = "Game Over"
    end
    if currentScore == 6 then
         media.playEventSound( "sounds/woo.mp3" )
       -- utils.playSound("clap")
        title = "You Win!"
        if categories[onCategory + 1] then
            if categories[onCategory + 1].locked then
                categories[onCategory + 1].locked = false 
            end

        else
           finalScene()
        end
    end
    utils.saveToJson(categories, "levels")

    -- Display our UI
    -- The top bar that is made in a utility function
    local options = {
        title = title,
    }
    local navBar = utils.createNavBar(options)
    uiGroup:insert(navBar)


    -- Is totalScore the highscore?
    local highscores = utils.loadFromJson("category_scores")

    if highscores[onCategory] ~= nil then 
        highscore = highscores[onCategory]
    else
        highscores[onCategory] = totalScore
    end
    if totalScore > highscore then 
        highscore = totalScore
    end

    utils.saveToJson(highscores, "category_scores")

    local currentPoints
    local loadPoints = tonumber(utils.loadFromJson("user_coins"))
        if loadPoints ~= nil then
            loadPoints = loadPoints + totalScore
        else
            loadPoints = totalScore
        end

    utils.saveToJson(loadPoints, "user_coins")    

    local points = utils.addCoins(totalScore)


    local bg = display.newRect(uiGroup, _W*0.5, _H*0.5, _W, _H)
    bg:setFillColor(colour[1], colour[2], colour[3])
    navBar:toFront()

    if currentScore < 6 then

    lab1 = display.newText({parent=uiGroup, text="The panda caught you! Try Again.", font="Helvetica", fontSize=14, align="center"})
    lab1.x = _W*0.5 
    lab1.y = _H*0.25 
    lab1:setFillColor(1)

    lab2 = display.newText({parent=uiGroup, text="You scored: ".. currentScore .. " out of " .. numQuestions, font="Helvetica", fontSize=12, align="center"})
    lab2.x = lab1.x
    lab2.y = mF(lab1.y + lab1.height/2 + lab2.height/2 + 2)
    lab2:setFillColor(1)

    lab3 = display.newText({parent=uiGroup, text="Total Score: ".. totalScore, font="Helvetica Bold", fontSize=12, align="center"})
    lab3.x = lab1.x
    lab3.y = mF(lab2.y + lab2.height/2 + lab3.height/2 + 2)
    lab3:setFillColor(1)

    else

    lab1 = display.newText({parent=uiGroup, text="You won! Nice job!", font="Helvetica", fontSize=14, align="center"})
    lab1.x = _W*0.5 
    lab1.y = _H*0.25 
    lab1:setFillColor(1)

    lab2 = display.newText({parent=uiGroup, text="You scored: ".. currentScore .. " out of " .. numQuestions, font="Helvetica", fontSize=12, align="center"})
    lab2.x = lab1.x
    lab2.y = mF(lab1.y + lab1.height/2 + lab2.height/2 + 2)
    lab2:setFillColor(1)

    lab3 = display.newText({parent=uiGroup, text="Total score: " .. totalScore, font="Helvetica", fontSize=12, align="center"})
    lab3.x = _W*0.5 
    lab3.y = lab2.y + lab2.height/2 + lab3.height/2 + 12
    lab3:setFillColor(1)

end

    if totalScore >= highscore then 
        local highscore_label = display.newText({parent=uiGroup, text="Highscore!", font="Helvetica", fontSize=14, align="center"})
        highscore_label.anchorX = 0
        highscore_label.x = mF(lab2.x + lab2.width/2 + 14)
        highscore_label.y = lab2.y 
        highscore_label:setFillColor(1)
        highscore_label.rotation = -10
    end

    local continueRect = display.newRect(uiGroup, _W*0.5, _H-100, _W, 52)
    continueRect:setFillColor(1)
    continueRect:addEventListener("touch", buttonTouched)

    local continueLabel
    if currentScore < 6 then
        continueRect.id = "restart"
        continueLabel = display.newText({parent=uiGroup, text="Retry", font="Helvetica", fontSize=16, align="center"})
    else
        continueRect.id = "continue"
        continueLabel = display.newText({parent=uiGroup, text="Continue", font="Helvetica", fontSize=16, align="center"})    
    end
    continueLabel.x = continueRect.x
    continueLabel.y = continueRect.y 
    continueLabel:setFillColor(colour[1],colour[2],colour[3])

    local home_rect = display.newRect(uiGroup, _W*0.5, continueRect.y+56, _W, 52)
    home_rect:setFillColor(1)
    home_rect.id = "home"
    home_rect:addEventListener("touch", buttonTouched)

    local home_label = display.newText({parent=uiGroup, text="Home", font="Helvetica", fontSize=16, align="center"})
    home_label.x = home_rect.x
    home_label.y = home_rect.y 
    home_label:setFillColor(colour[1],colour[2],colour[3])

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
