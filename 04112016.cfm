<cfscript>

    getData = function()
    {
        var http = new Http();
        http.setUrl("https://gist.githubusercontent.com/ryanguill/036a35ad8cc07bf600b25212eacc3ced/raw/4c5f67ecc4993c09f5776c8b0144020beda798e6/karma.json");
        return deserializeJson(http.send().getPrefix().fileContent);
    };

	writeOutput(run(getData()));

    private string function run(required array payload)
    {
		// Define Leaderboard
        var leaderboard = {};

        // Iterate Objects
        for(var x = 1; x <= arrayLen(arguments.payload); x ++)
        {
            if(!structKeyExists(leaderboard, arguments.payload[x].user)) {leaderboard[arguments.payload[x].user] = 1;}
            else {leaderboard[arguments.payload[x].user] ++;}
        }

		// Sort Leaderboard
		var leaderboardSort = structSort(leaderboard, "numeric", "desc");
		//writeDump(leaderboard);

		// Top Ten Users
		var size = arrayLen(leaderboardSort);
		var limit = (size < 10) ? size : 10;
		var leaderTen = [];
		for(var y = 1; y <= limit; y ++) {arrayAppend(leaderTen, {name:leaderboardSort[y], score:leaderboard[leaderboardSort[y]]});}
		//writeDump(leaderTen);

		// Top Score Groups
		var topGroups = [];
		for(var z = 1; z <= arrayLen(leaderTen); z ++)
		{
			// Group Append
			if(z > 1 && leaderTen[z].score == topGroups[arrayLen(topGroups)].score) {arrayAppend(topGroups[arrayLen(topGroups)].names, leaderTen[z].name);}

			// New Group
			else {arrayAppend(topGroups, {score:leaderTen[z].score, names:[leaderTen[z].name]});}
		}
		//writeDump(topGroups);

        // Build Result
		var fnResult = function(required array top)
		{
			var result = [];
			//var pos = 1;
			for(var x = 1; x <= arrayLen(top); x ++)
			{
				result.add("[ ##" & x & " @ " & top[x].score & "]: " & arrayToList(top[x].names, ", "));
				//pos += arrayLen(names); // something like this if you wanted to miss positions due to sharing of previous positions
			}
			return arrayToList(result, "<br>");
		};

		// Return Result
		return fnResult(topGroups);
    }

</cfscript>
