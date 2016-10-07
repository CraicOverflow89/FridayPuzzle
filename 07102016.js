// Run Tests
tests();

function tests()
{
	// Words Existing
	if(solveWord("Pay now", "Pay more tax now or suffer, says new minister") == true)
	{console.log("PASS");} else {console.log("FAIL");}
	if(solveWord("Pay today", "The sun has disappeared today") == false)
	{console.log("PASS");} else {console.log("FAIL");}

	// Case Sensitivity
	if(solveWord("Hello George", "Hello everyone, where is George today") == true)
	{console.log("PASS");} else {console.log("FAIL");}
	if(solveWord("Hello George", "hello everyone how is George") == false)
	{console.log("PASS");} else {console.log("FAIL");}
}

/**
* @hint checks to see if words in ransom string can be found in magazine string
* @ransom a string containing words to find
* @magazine a string containing words to be used
*/
function solve(ransom, magazine)
{
	var answer = solveWord(ransom, magazine);
	if(answer) {console.log("Yes");}
	else {console.log("No");}
}

// Logic
function solveWord(ransom, magazine)
{
	// Split into Words
	var ransomWord = ransom.split(" ");
	var magazineWord = magazine.split(" ");

	// Match in Magazine
	var match = function(word)
	{
		for(var m = 0; m < magazineWord.length; m ++)
		{
			// NOTE: we are removing the first one we find - if there are multiple options we should choose
			if(magazineWord[m].indexOf(word) >= 0)
			{
				magazineWord.splice(m, 1);
				return true;
			}
		}
		return false;
	}

	// Iterate Ransom Words
	for(var r = 0; r < ransomWord.length; r ++)
	{
		if(!match(ransomWord[r])) {return false;}
	}

	// All Found
	return true;
}