
--contains character info for the store
--also stores perks info.


local M = {
	{
		title = "Elephant",
		bought = true,  --checked to see if bought
		chosen =  true --user's chosen character
	},
	{
		title = "Giraffe",
		bought = false,  
		chosen = false

	},
	{
		title = "Tiger",
		bought = false,  
		chosen = false
	},
	{
		title = "Leopard",
		bought = false,  
		chosen = false
	},
	{
		title = "Skip",
		number = 0
	},

		{
		title = "Boost",
		bought = false
	},
		{
		title = "Cancel",
		number = 0
	},
}

return M
