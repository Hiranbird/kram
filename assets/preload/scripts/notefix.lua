function onCreatePost()
    addHaxeLibrary('FlxRect', 'flixel.math')
	addHaxeLibrary('FlxCamera', 'flixel')
    luaDebugMode = true
end
time = 0
function onUpdatePost(elapsed)
	notelength = getProperty("notes.length")
	for i = 0, notelength-1 do
		noteData = getPropertyFromGroup("notes", i, "noteData")
        setPropertyFromGroup("notes", i, "clipRect", nil)
		if (getPropertyFromGroup("notes", i, "mustPress")) and (getPropertyFromGroup("notes", i, "isSustainNote")) then
			setPropertyFromGroup("notes", i, "angle", getPropertyFromGroup("playerStrums", noteData, "direction") - 90)
		elseif (getPropertyFromGroup("notes", i, "isSustainNote")) then
			setPropertyFromGroup("notes", i, "angle", getPropertyFromGroup("opponentStrums", noteData, "direction") - 90)
		end
		if (noteData >= 4) and (not getPropertyFromGroup("notes", i, "isSustainNote")) then
			setPropertyFromGroup("notes", i, "angle", getPropertyFromGroup("playerStrums", noteData, "angle"))
		elseif (not getPropertyFromGroup("notes", i, "isSustainNote")) then
			setPropertyFromGroup("notes", i, "angle", getPropertyFromGroup("opponentStrums", noteData, "angle"))
		end
	end
	if downscroll then
    	runHaxeCode([[
    	    game.notes.forEachAlive(function(daNote) {
				
            	if(daNote.distance > 0 && daNote.wasGoodHit)
            	{
					strumGroup = game.playerStrums;
					if(!daNote.mustPress) strumGroup = game.opponentStrums;
					strumY = strumGroup.members[daNote.noteData].y - (daNote.swagWidth / 2);
					swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
					swagRect.height = (50 + (-daNote.distance)) / daNote.scale.y;
					swagRect.y = daNote.frameHeight - swagRect.height; 

                	daNote.clipRect = swagRect;
                	trace(swagRect);
            	}
        	});
    	]])
	else
		runHaxeCode([[
    	    game.notes.forEachAlive(function(daNote) {

            	if(daNote.distance < 0 && daNote.wasGoodHit)
            	{
					strumGroup = game.playerStrums;
					if(!daNote.mustPress) strumGroup = game.opponentStrums;
					strumY = strumGroup.members[daNote.noteData].y + (daNote.swagWidth / 2);
					swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
					swagRect.y = (50 - daNote.distance) / daNote.scale.y;
					swagRect.height -= swagRect.y;

                	daNote.clipRect = swagRect;
                	trace(swagRect);
            	}
        	});
    	]])
	end
end