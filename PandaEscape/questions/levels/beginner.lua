--------------------------------------------
-- BEGINNER QUESTIONS
--------------------------------------------

-- This will contain all the beginner questions
local M = {
	{
		question = "What for loop prints out 1 to 10?", -- The actual question text
		answer = 3, 	-- Set the answer for the question
		answers = { 	-- You can have an many as you like, but they will get small if you have too many.
			"for(int i = 1; i < 10; i++){ System.out.println(i);}",  
			"for(int i = 0; i < 10; i++){ System.out.println(i);}",
			"for(int i = 1; i <= 10; i++){ System.out.println(i);}",
			"for(int i = 0; i < 11; i++){ System.out.println(i);}",
		},
	},
	{
		question = "int[] val = {1,2,3,4,5,6} What termination value is needed to print all the values? for(i=0; i<=?; i++)",
		answer = 1, 
		answers = { 
			"5",  
			"4",
			"6",
			"7",
		},
	},		
	{
		question = "Which of the following statements are false?",
		answer = 4, 
		answers = { 
			"For loops are for repeating operations many times.",  
			"For loops stop on their own when not infinite.",
			"For loops are a loop operation.",
			"For loops check the end number after the operation.",
		},
	},	
	{
		question = "Given an array arr{10,8,44,2}, print all the elements!",
		answer = 4, 
		answers = { 
			"for(int i = 1; i < 4; i++){ System.out.println(arr[i]);}",  
			"for(int i = 0; i <= 4; i++){ System.out.println(arr[i]);}",  
			"for(int i = 1; i < 5; i++){ System.out.println(arr[i]);}",  
			"for(int i = 0; i < 4; i++){ System.out.println(arr[i]);}",  
		},
	},
	{
		question = "The statement i++ is equal to:",
		answer = 2, 
		answers = { 
			"i = i+i", 
			"i = i+1",
			"i = i-1",
			"i = i+2", 
		},
	},
	{
		question = "Is there anything missing in this code: for(int i = 0 i < 8 i++){System.out.println(i);}",
		answer = 4, 
		answers = { 
			"No, it's fine",  
			"Yes, it's missing a semi-colon!",
			"Maybe",
			"Yes, it's missing two semi-colons!"
		},
	},
}

--Return it now
return M