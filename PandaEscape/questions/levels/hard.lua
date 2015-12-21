--------------------------------------------
-- HARD QUESTIONS
--------------------------------------------

-- This will contain all the hard difficulty questions
local M = {
	{
		question = "Choose the for loop that computes factorial 10! Given: int factorial = 1;", 
		answer = 2, 	
		answers = { 	
			"for(int i = 10; i > 1; i--){ factorial *=i;}System.out.println(factorial);}",  
			"for(int i = 10; i > 0; i--){ factorial *=i;}System.out.println(factorial);}",  
			"for(int i = 10; i > 1; i--){ factorial +=i;}System.out.println(factorial);}",  
			"for(int i = 10; i > 0; i--){ factorial +=i;}System.out.println(factorial);}",  
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
		question = "int[] values = {1,2,3,4,5,6,7,8}; for(int i=0; i<X; ) System.out.println(values[i++]); Referring to this code, what value of X will print all of values? ",
		answer = 4, 
		answers = { 
			"None, the loop doesn't execute",  
			"7",
			"6",
			"8"
		},
	},	
	{
		question = "value = 0; for(i=1;i<2;i++){for(j=1;j<4;j++){value = value + j;} value = value + i;} System.out.println(value); What is value?",
		answer = 3, 
		answers = { 
			"0",  
			"8",  
			"7",  
			"9",  
		},
	},
	{
		question = [[What does this loop print? int mysteryInt = 100; 
for(i=3; i<7; i++){mysteryInt -= i; System.out.println(mysteryInt);}]], 
		answer = 1, 
		answers = { 
			"97, 93, 88, 82",  
			"7, 6, 5, 4",
			"100, 97, 93, 88",
			"97, 94, 90, 85",
		},
	},
	{
		question = "int[] values = {1,7,10,104,9,6,79,89}; for(int i=30; i<X; ) System.out.println(values[i++]); Referring to this code, what value of X will print all of values? ",
		answer = 4, 
		answers = { 
			"None, the loop doesn't execute",  
			"7",
			"8",
			"No applicable answer"
		},
	},	
		

}

return M