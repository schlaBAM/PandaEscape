--game.lua

local composer = require( "composer" )
local scene = composer.newScene()


local _W = display.contentWidth
local _H = display.contentHeight
local mF = math.floor 
local mR = math.random 

-- Load our utils and main categories
local utils = require("globals")
local categories = require("questions.categories")
local char = utils.loadFromJson("chars")




-- Display Groups
local screenGroup
local quizGroup                 -- Holds the quiz UI 
local uiGroup                   -- Holds the navBar UI
local overGroup                 -- Only created when we tap on the pause button or get gameover
local navBar

-- Game variables
local category = {}             -- The chosen category once loaded.
local questions = {}            -- The category quiz questions once loaded.
local colour = {}               -- Category colour once loaded 
local onCategory = 0            -- Tracks the category we are on (used for gameOver)
local onQuestion = 0            -- Tracks the question we are on
local currentScore = 0          -- The player's score
local questionTime = 0          -- Set in categories.lua. 0 removes the timer.
local timerEnabled = true       -- Stops or allows our countdown timer, based off questionTime
local touchEnabled = false      -- Stops button touches
local timeLeft                  -- Used to see how much time is left. Points multiplied by 3*seconds
local totalPoints = 0
local startTime = 0             -- Measures time multiplier for totalPoints, with endTime
local endTime 
local skip                      -- Source for skip icon in nav
local cancel                    -- Source for eliminate icon in nav
local options                   -- Navbar options

-- Transitions and timers
local delayTimer                 -- Game over delay for changing scene
local transTimer                 -- Transition for our timer
local transResult               -- Transition for "Correct"

-- Display objects
local over_rect                 -- Pre-declare so we can alter it from the day/night button as well.
local question_rect             -- Pre-declare so we can access anywhere
local timer_rect                
local timer_bar                  -- The countdown bar
local progressBar
local label_question             -- The question number label
local label_result               -- The "Correct" text label
local answer_rect   
local enemy                     -- Evil panda
local character                 -- User character - can be updated in store  
local flag                      -- Finish flag for the progress bar          

-- Functions
local updateScore
local startTimer
local gameOver
local buttonTouched
local createQuestion

--functions
-- Button touched
buttonTouched = function(event)
    local t = event.target 
    local id = t.id 
    
    if event.phase == "began" and touchEnabled == true then 
        display.getCurrentStage():setFocus( t )
        t.isFocus = true
        
        if id == "answer" then 
            t.alpha = 0.6
        else
            t.xScale = 0.9
            t.yScale = 0.9
        end
        
    elseif t.isFocus then
        if event.phase == "ended" then
            display.getCurrentStage():setFocus( nil )
            t.isFocus = false
            
            if id == "answer" then 
                t.alpha = 1
            else
                t.xScale = 1
                t.yScale = 1
            end

            -- Check that touch finished in the button.
            local b = t.contentBounds 
            if event.x >= b.xMin and event.x <= b.xMax and event.y >= b.yMin and event.y <= b.yMax then                 
                --utils.playSound("select")

                if id == "answer" then 
                    if transTimer ~= nil then
                        transition.cancel(transTimer)
                        transTimer = nil 
                    end
                    if transResult ~= nil then
                        transition.cancel(transResult)
                        transResult = nil 
                    end
                    if label_result ~= nil then
                        display.remove(label_result)
                        label_result = nil 
                    end

                    -- Show some text that we can transition
                    label_result = display.newText({parent=uiGroup, text="", font="Helvetica", fontSize=12})
                    label_result.anchorX = 0 
                    label_result.x = label_question.x + label_question.width/2 + 24
                    label_result.y = label_question.y 
                    
                    if t.index == questions[onQuestion].answer then 
                        label_result.text = "Nice!"
                        label_result:setFillColor(0,0.6,0)
                        transition.to(character, {time = 500, x = character.x + 70})
                        category = categories[onCategory]
                        media.playEventSound( "sounds/woo.mp3" )

                        --utils.playSound("clap")
                        --utils.checkBoost()
                        endTime = math.floor(20 - (system.getTimer() - startTime) / 1000)  -- used for the multiplier.  
                        
                        if category.title == "Beginner" then
                            if char[6].bought == true then -- check for boost
                                print("boost works")
                               updateScore(1,110+(endTime * 2))
                           else
                            updateScore(1,100+(endTime * 2))
                        end
                        end
                        if category.title == "Medium" then
                            if char[6].bought == true then
                              updateScore(1,275+(endTime * 2))
                          else
                              updateScore(1,250+(endTime * 2))
                          end
                        end
                        if category.title == "Hard" then
                            if char[6].bought == true then
                            updateScore(1,550+(endTime * 2))
                          else                            
                            updateScore(1,500+(endTime * 2))
                        end
                        end
                        if category.title == "Extreme" then
                            if char[6].bought == true then
                            updateScore(1,825+(endTime * 2))
                          else                                                      
                            updateScore(1,750+(endTime * 2))
                        end
                        end
                        createQuestion()

                       
                    else
                        label_result.text = "Not quite!"
                        label_result:setFillColor(0.8,0,0)
                        transition.to(enemy, {time = 500, x = enemy.x + 70})  
                        media.playEventSound( "sounds/aww.mp3" )                     
                        --utils.playSound("incorrect")
                        if character.x == enemy.x+70 then
                            gameOver()
                            --needs to play different gameover sound.
                        end
                        repeatQuestion()
                    end
                    print("here")
                    transResult = transition.to(label_result, {time=1600, alpha=0.1, y=label_result.y-18, onComplete=function()
                        display.remove(label_result)
                        label_result = nil 
                    end})

                end
            end
        end
    end
    return true
end

-- End the game
gameOver = function()
    touchEnabled = false 
    --utils.playSound("gameover")
    
    delayTimer = timer.performWithDelay(600, function()
        composer.gotoScene( "scenes.gameOver", {effect="slideLeft", time=300, params={
            currentScore=currentScore,
            onCategory=onCategory,
            numQuestions=#questions,
            totalPoints = totalPoints
        }})
    end, 1)
end

-- Easily add to our score, also controls the +1 animation
updateScore = function(amount, points)
    if amount ~= nil then 
        currentScore = currentScore + amount
        totalPoints = totalPoints + points
        label_question.text = currentScore .. " / " .. #questions
    end
end

-- Update our timer bar.
startTimer = function(delay)
    if timerEnabled == true and timer_bar ~= nil then 
        if transTimer ~= nil then
            transition.cancel(transTimer)
            transTimer = nil 
        end

        -- Reset xScale and set delay
        local time = questionTime * 1000
        local startDelay = delay 
        timer_bar.xScale = 1

        if startDelay == nil then 
            startDelay = 0 
        end

        transTimer = transition.to(timer_bar, {time=time, delay=startDelay, xScale=0, onComplete=function()
            createQuestion()
        end})
            

    end
end

repeatTimer = function(delay)
        if timerEnabled == true and timer_bar ~= nil then 
        if transTimer ~= nil then
            transition.cancel(transTimer)
            transTimer = nil 
        end

        -- Reset xScale and set delay
        local time = questionTime * 1000
        local startDelay = delay 
        timer_bar.xScale = 1

        if startDelay == nil then 
            startDelay = 0 
        end

        transTimer = transition.to(timer_bar, {time=time, delay=startDelay, xScale=0, onComplete=function()
            repeatQuestion()
        end})
    end
end

repeatQuestion = function()

    onQuestion = onQuestion
    -- Start out timer, add a delay if we are on quesiton 1
        local delay = 0 
        repeatTimer(delay)

        -- Create the question and answers.
        local numberX = 32
        local questionX = 24
        local questionW = _W-(questionX*2)
        local q = questions[onQuestion]
        local image 

        if q.image ~= nil and q.image.file ~= nil then 
            image = display.newImageRect(quizGroup, q.image.file, q.image.width, q.image.height)
            image.anchorX = 0 
            image.x = numberX/2
            image.y = question_rect.y+question_rect.height/2

            questionX = image.x + image.width + numberX/2
            questionW = _W-questionX-numberX
        end

        local question = display.newText({parent=quizGroup, text=q.question, width=questionW, height=0, font="Helvetica", fontSize=14})
        question.x = questionX
        question.y = question_rect.y+question_rect.height/2
        question.anchorX = 0 
        question:setFillColor(1)

        if category.title == "Medium" then
            question.fontSize = 12
        end

        -- The answers all need to fit in the bottom area, so we make sure they can!
        local areaPadding = 4  -- Top and bottom padding
        local topPadding = 0   -- Extra padding for the top for some added space
        local answerOffset = 6  -- y offset per answer
        local area = answer_rect.height - (areaPadding*2)
        local answerHeight = (area-topPadding-(answerOffset*#q.answers))/#q.answers 
        local textX = numberX + 20
        local textW = _W - textX - 24

        for i=1, #q.answers do 
            local y = answer_rect.y + areaPadding + topPadding + ((answerHeight+answerOffset)*(i-1)) 

            local rect = display.newRect(quizGroup, _W*0.5, y, _W, answerHeight)
            rect.anchorY = 0 
            rect.id = "answer"
            rect.index = i 
            rect:setFillColor(0.4)
            rect:addEventListener("touch", buttonTouched)

            local arrow = display.newSprite(utils.uiSheet, {frames={utils.uiSheetInfo:getFrameIndex("arrow")}})
            arrow.x = arrow.width/2 + 4
            arrow.y = rect.y + rect.height/2
            quizGroup:insert(arrow)

            if arrow.height > rect.height-8 then 
                arrow.height = rect.height-8
            end

            local number = display.newText({parent=quizGroup, text=i..".", font="Helvetica", fontSize=8})
            number.x = numberX
            number.y = rect.y+rect.height/2
            number.anchorX = 0 
            number:setFillColor(1)

            local answer = display.newText({parent=quizGroup, text=q.answers[i], width=textW, height=0, font="Helvetica", fontSize=13})
            answer.x = textX
            answer.y = number.y
            answer.anchorX = 0 
            answer:setFillColor(1)
        end
    end
-- Create a question, iterates.
createQuestion = function()
    -- Add one 
    onQuestion = onQuestion + 1

    -- Make sure we have a question and haven't finished.
    if questions[onQuestion] == nil or onQuestion > #questions then 
        gameOver()

    else
        -- Remove anything old
        for i=quizGroup.numChildren, 1, -1 do 
            if quizGroup[i] ~= nil then 
                display.remove(quizGroup[i])
                quizGroup[i] = nil 
            end
        end

        -- Start out timer, add a delay if we are on question 1
        local delay = 0 
        if onQuestion == 1 then 
            delay = 1000 
        end
        startTimer(delay)
        startTime = system.getTimer()

        -- Create the question and answers.
        local numberX = 32
        local questionX = 24
        local questionW = _W-(questionX*2)
        local q = questions[onQuestion]
        local image 


        local question = display.newText({parent=quizGroup, text=q.question, width=questionW, height=0, font="Helvetica", fontSize=14})
        question.x = questionX
        question.y = question_rect.y+question_rect.height/2
        question.anchorX = 0 
        question:setFillColor(1)

        if category.title == "Medium" then
            question.fontSize = 12
        end

        -- The answers all need to fit in the bottom area, so we make sure they can!
        local areaPadding = 4  -- Top and bottom padding
        local topPadding = 0   -- Extra padding for the top for some added space
        local answerOffset = 6  -- y offset per answer
        local area = answer_rect.height - (areaPadding*2)
        local answerHeight = (area-topPadding-(answerOffset*#q.answers))/#q.answers 
        local textX = numberX + 20
        local textW = _W - textX - 24

        for i=1, #q.answers do 
            local y = answer_rect.y + areaPadding + topPadding + ((answerHeight+answerOffset)*(i-1)) 

            local rect = display.newRect(quizGroup, _W*0.5, y, _W, answerHeight)
            rect.anchorY = 0 
            rect.id = "answer"
            rect.index = i 
            rect:setFillColor(0.3)
            rect:addEventListener("touch", buttonTouched)

            local arrow = display.newSprite(utils.uiSheet, {frames={utils.uiSheetInfo:getFrameIndex("arrow")}})
            arrow.x = arrow.width/2 + 4
            arrow.y = rect.y + rect.height/2
            quizGroup:insert(arrow)

            if arrow.height > rect.height-8 then 
                arrow.height = rect.height-8
            end

            local number = display.newText({parent=quizGroup, text=i..".", font="Helvetica", fontSize=8})
            number.x = numberX
            number.y = rect.y+rect.height/2
            number.anchorX = 0 
            number:setFillColor(1)

            local answer = display.newText({parent=quizGroup, text=q.answers[i], width=textW, height=0, font="Helvetica", fontSize=13})
            answer.x = textX
            answer.y = number.y
            answer.anchorX = 0 
            answer:setFillColor(1)
        end
    end
end

skipLevel = function(event)

     newOptions = {
        title = category.title, 
        backScene = "scenes.menu", 
        skip = char[5].number -1,
        cancel = char[7].number,
    }
    media.playEventSound( "sounds/woo.mp3" )
 

    navBar.isVisible = false
    navBar = utils.createNavBar(newOptions)
    uiGroup:insert(navBar)

    transition.to(character, {time = 500, x = character.x + 70})
    endTime = math.floor(20 - (system.getTimer() - startTime) / 1000)  -- used for the multiplier.  

  if category.title == "Beginner" then
         if char[6].bought == true then -- check for boost
           updateScore(1,110+(endTime * 2))
         else
           updateScore(1,100+(endTime * 2))
        end
     end
         if category.title == "Medium" then
                if char[6].bought == true then
                  updateScore(1,275+(endTime * 2))
                else
                  updateScore(1,250+(endTime * 2))
                end
                end
         if category.title == "Hard" then
                if char[6].bought == true then
                 updateScore(1,550+(endTime * 2))
                else                            
                 updateScore(1,500+(endTime * 2))
                end
                end
         if category.title == "Extreme" then
                if char[6].bought == true then
                   updateScore(1,825+(endTime * 2))
                else                                                      
                   updateScore(1,750+(endTime * 2))
               end
               end
               char[5].number = char[5].number - 1
               utils.saveToJson(char,"chars")
 --     utils.decrementSkip()
     createQuestion()
end

eliminateAnswer = function(event)

     elimOptions = {
        title = category.title, 
        backScene = "scenes.menu", 
        skip = char[5].number,
        cancel = char[7].number -1,
    }

    utils.playSound("select") 

    navBar.isVisible = false
    navBar = utils.createNavBar(elimOptions)
    uiGroup:insert(navBar)

        char[7].number = char[7].number - 1
        utils.saveToJson(char,"chars")

end

-- Create all your display objects here.
function scene:create( event )

    screenGroup = self.view
    uiGroup = display.newGroup()
    quizGroup = display.newGroup()
    screenGroup:insert(uiGroup)
    screenGroup:insert(quizGroup)


    -- Set our categories and questions
    if event.params then 
        if event.params.category then 
            onCategory = event.params.category
            category = categories[onCategory]
            questions = require( category.questions )
            colour = category.colour
            questionTime = category.timePerQuestion

            if questionTime == nil or questionTime == 0 then 
                timerEnabled = false
            end
        end
    end

    -- Display our navbar
     options = {
        title = category.title, 
        backScene = "scenes.menu", 
        skip = char[5].number,
        cancel = char[7].number,
    }
    navBar = utils.createNavBar(options)
    uiGroup:insert(navBar)

    local top = navBar.y + navBar.height 
    local height = _H - top

    --Question rectangle.
    question_rect = display.newRect(uiGroup, _W*0.5, top, _W, 50 )
    question_rect.anchorY = 0 
    question_rect:setFillColor(colour[1], colour[2], colour[3])

    timer_rect = display.newRect(uiGroup, _W*0.5, question_rect.y+question_rect.height, _W, 70 )
    timer_rect.anchorY = 0 
    timer_rect:setFillColor(1)

    progressBar = display.newImage(uiGroup, "images/progressBar.png", _W/2.5 + 55, timer_rect.y+timer_rect.height-18)
    flag = display.newImage(uiGroup, "images/finishflag.png", 520, timer_rect.y+timer_rect.height-18)
    enemy = display.newImage(uiGroup, "images/panda.png", 30, timer_rect.y+timer_rect.height-18)
    
    --checks to see which character to select.
      if char[1].chosen == true then
    character = display.newImage(uiGroup, "images/elephant.png", 100, timer_rect.y+timer_rect.height-18)
      elseif char[2].chosen == true then
            character = display.newImage(uiGroup, "images/giraffe.png", 100, timer_rect.y+timer_rect.height-18)
      elseif char[3].chosen == true then
            character = display.newImage(uiGroup, "images/tiger.png", 100, timer_rect.y+timer_rect.height-18)
      elseif char[4].chosen == true then
            character = display.newImage(uiGroup, "images/leopard.png", 100, timer_rect.y+timer_rect.height-18)
        end
    answer_rect = display.newRect(uiGroup, _W*0.5, timer_rect.y+timer_rect.height, _W, _H-(timer_rect.y+timer_rect.height-5))
    answer_rect.anchorY = 0 
    answer_rect:setFillColor(178/255, 190/255, 181/255)

    -- score/question num/time remaining 
    if timerEnabled == true then 
        timer_bar = display.newRect(uiGroup, 0, timer_rect.y+timer_rect.height-43, _W, 8)
        timer_bar.anchorX = 0 
        timer_bar:setFillColor(colour[1], colour[2], colour[3])
    end


    label_question = display.newText({parent=uiGroup, text="0 / "..#questions, font="Helvetica", fontSize=14}) 
    label_question.x = _W*0.5
    label_question.y = timer_rect.y+10
    label_question:setFillColor(colour[1], colour[2], colour[3])

    -- Now make our first question
    createQuestion()
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

        -- Now that the scene has appeared, allow touch
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

        -- Stop transitions if needed
        if transTimer then 
            transition.cancel(transTimer)
            transTimer = nil 
        end
        if transResult then 
            transition.cancel(transResult)
            transResult = nil 
        end
        if delayTimer ~= nil then 
            timer.cancel(delayTimer)
            delayTimer = nil 
        end

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
