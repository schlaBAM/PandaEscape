

-- This will contain all the category information
local M = {
	{
		title = "Beginner", --title for menu
		subtitle = "Start out nice and easy!", -- subtitle for menu
		colour = {24/255, 161/255, 51/255},
		icon = "snail", -- The imageSheet name for the icon on the uiSheet made in globals.lua
		questions = "questions.levels.beginner", --level path
		timePerQuestion = 20, -- Seconds allowed per question
		locked = false,
		lockedIcon = "lock"
	},
	{
		title = "Medium", 
		subtitle = "The questions are getting tougher!", 
		colour = {224/255, 209/255, 45/255},
		icon = "star", 	
		questions = "questions.levels.medium", 
		timePerQuestion = 30, 	
		locked = true,
		lockedIcon = "lock"

	},
	{
		title = "Hard", 
		subtitle = "Tricky! Put your brain to the test!", 
		colour = {245/255, 147/255, 49/255},
		icon = "fire", --icon should be a pepper
		questions = "questions.levels.hard",
		timePerQuestion = 40,
		locked = true,
		lockedIcon = "lock"
	},
	{
		title = "Extreme", 
		subtitle = "Not for the faint of heart. Experts only!", 
		colour = {247/255, 49/255, 35/255},
		icon = "pepper", --should be a flame
		questions = "questions.levels.extreme",
		timePerQuestion = 60,
		locked = true,
		lockedIcon = "lock"	
	},
}

return M
