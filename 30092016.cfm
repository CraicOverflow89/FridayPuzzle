<cfscript>
	// Phrases
    solve("abcd", "defg");
    solve("abcdefghijkl", "cdefg");
    solve("abcdd", "ddefg");

    private void function solve(required string a, required string b)
    {
        // Reduction Count
        var count = 0;

        // Comparison
        var compare = [];
        var char = "";
        for(var x = 1; x <= len(arguments.b); x ++)
        {
            char = mid(arguments.b, x, 1);
            if(findNoCase(char, arguments.a)) {arrayAppend(compare, char);}

            // Characters to remove from B
            else {count ++;}
        }

        // Characters to remove from A
        for(var y = 1; y <= len(arguments.a); y ++)
        {
            char = mid(arguments.a, y, 1);
            if(!arrayContains(compare, char)) {count ++;}
        }

        // Result
        writeOutput(count & "<br>");
    }

</cfscript>