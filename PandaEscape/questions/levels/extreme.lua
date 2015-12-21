--------------------------------------------
-- QUESTIONS
--------------------------------------------

-- Create our local M table
-- This will contain all the category questions
local M = {
	{
		question = "value = 0; for(i=1;i<0;i++){for(j=1;j<3;j++){value = value + j;} value = value + i;} System.out.println(value); What is value?",
		answer = 1, 
		answers = { 
			"0",
			"1",
			"2",
			"3",
		},
	},
	{
		question = "What for loop counts down from 100000 to 1?",
		answer = 4, 
		answers = { 
			"for(int i = 100000; i > 50; i = i/200){ System.out.println(i);}",
			"for(int i = 100000; i < 30; i = i/200){ System.out.println(i);}",
			"for(int i = 100000; i <= 2; i--){ System.out.println(i);}",
			"for(int i = 100000; i > 0; i = i/2){ System.out.println(i);}",
		},
	},
	{
		question = "value = 0; for(i=1;i<0;i++){for(j=1;j<3;j++){value = value + j;} value = value + i;} System.out.println(value); What is value?",
		answer = 1, 
		answers = { 
			"0",
			"1",
			"2",
			"3",
		},
	},
		{
		question = [[What does this loop print? int mysteryInt = 100; 
for(i=3; i<7; i++){mysteryInt -= i; System.out.println(mysteryInt);}]], 
		answer = 4, 
		answers = { 
			"97, 94, 90, 85",
			"7, 6, 5, 4",
			"100, 97, 93, 88",
			"97, 93, 88, 82",  

		},
	},
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
		question = "Was this game fun?",
		answer = 3,
		answers = { 
			"No",  
			"You're running out of free guesses",
			"Yeah!",
			"A little",
		},
	},
}

--Return it now
return M