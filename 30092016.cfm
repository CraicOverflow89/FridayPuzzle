<cfscript>
    solve("abcd", "defg");
    solve("abcdefghijkl", "cdefg");
    solve("abcdd", "ddefg");
    solve("abcdd", "dddefg");

    private void function solve(required string a, required string b)
    {
        // Input Arrays
        var arrayA = listToArray(arguments.a, "");
        var arrayB = listToArray(arguments.b, "");

        // Reduction Count
        var count = 0;

        // Comparison
        var compare = [];
        var char = "";
        for(var x = 1; x <= arrayLen(arrayB); x ++)
        {
            char = arrayB[x];
            if(arrayContains(arrayA, char))
            {
                arrayAppend(compare, char);
                arrayDelete(arrayA, char);
            }

            // Characters to remove from B
            else {count ++;}
        }

        // Characters to remove from A
        for(var y = 1; y <= arrayLen(arrayA); y ++)
        {
            char = arrayA[y];
            if(!arrayContains(compare, char)) {count ++;}

            // Remove from future comparison
            else {arrayDelete(compare, char);}
        }

        // Result
        writeOutput(count & "<br>");
    }

</cfscript>