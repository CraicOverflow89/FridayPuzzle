<cfscript>
	// Data
	input = queryNew("");
    queryAddColumn(input, "id", "integer", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
	queryAddColumn(input, "parentID", "integer", [0, 1, 2, 2, 0, 5, 5, 5, 0, 9]);
    queryAddColumn(input, "nodeText", "varchar", ["File", "New", "File", "Folder", "Edit", "Copy", "Cut", "Paste", "Help", "About"]);

	// Solve the Puzzle
	writeDump(test(input));

	public string function test(required query input)
	{
		// Define Result Array
		var result = [];

		// Top Level Nodes
		for(var record in arguments.input)
		{
			if(record.parentID == 0) {arrayAppend(result, testNode(record.id, record.nodeText, arguments.input));}
		}

		// Return JSON
		return serializeJson(result);
	}

	private struct function testNode(required numeric id, required string nodeText, required query input)
	{
		// Default Structure
		var result = {nodeText:arguments.nodeText};

		// Check for Children
		var childQuery = new Query();
		childQuery.setDBType("query");
		childQuery.setAttributes(query = input);
		childQuery.setSQL("SELECT id, nodeText FROM query WHERE parentID = " & arguments.id);
		var childResult = childQuery.execute().getResult();
		if(childResult.recordCount)
		{
			result.children = [];
			for(var child in childResult) {arrayAppend(result.children, testNode(child.id, child.nodeText, arguments.input));}
		}

		// Return
		return result;
	}

</cfscript>