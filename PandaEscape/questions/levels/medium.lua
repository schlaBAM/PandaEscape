--------------------------------------------
-- MEDIUM QUESTIONS
--------------------------------------------

-- This will contain all the medium difficulty questions
local M = {
	{
		question = "What for loop prints out the odd numbers from 1 to 10?", 
		answer = 2, 	
		answers = { 	
			"for(int i = 1; i < 10; i++){ if(i%2 !=0) System.out.println(i);}",  
			"for(int i = 1; i < 11; i++){ if(i%2 !=0) System.out.println(i);}",  
			"for(int i = 1; i < 11; i++){ if(i%3 !=0) System.out.println(i);}",  
			"for(int i = 0; i < 10; i++){ if(i%2 !=0) System.out.println(i);}",  
		},
	},
	{
		question = " What are the first and last outputs of i in the loop? n=15; i=0; for(i=0;i<=n;i++) {System.out.println(i);}",
		answer = 4, 
		answers = { 
			"0,14",  
			"1,14",
			"1,15",
			"0,15"
		},
	},	
	{
		question = "Which of these loops is an infinite loop?",
		answer = 4, 
		answers = { 
			"for(int i = 1; i < 4; i++){ System.out.println('a');}",  
			"for(int i = 0; i <= 0; i++){ System.out.println('a');}",  
			"for(int i = 1; i > 2; i++){ System.out.println('a');}",  
			"for(int i = 10; i < 12; i--){ System.out.println('a');}",  
		},
	},
	{
		question = "What is the final value of x when the code: int x; for(x=0; x<10; x++){} is run?",
		answer = 2, 
		answers = { 
			"9", 
			"10",
			"0",
			"1", 
		},
	},
	{
		question = "What for loop counts down from 99 to 0?",
		answer = 2, 
		answers = { 
			"for(int i = 100; i > 0; i--){ System.out.println(i);}",
			"for(int i = 99; i >= 0; i--){ System.out.println(i);}",
			"for(int i = 99; i <= 0; i--){ System.out.println(i);}",
			"for(int i = 99; i > 0; i--){ System.out.println(i);}",
		},
	},
	{
		question = [[What does this loop print? int mysteryInt = 100; 
for(i=5; i>0; i--){mysteryInt -= i; System.out.println(mysteryInt);}]], -- maybe move to hard.
		answer = 1, 
		answers = { 
			"95, 91, 88, 86, 85",  
			"5, 4, 3, 2, 1",
			"95, 90, 85, 80, 75",
			"100, 95, 91, 88, 86",
		},
	},
}

return M