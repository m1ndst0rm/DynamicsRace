if!(DYN_RACE_TURBO_ENABLED) then
{
	//"TurboStart" call DYN_RACE_Debug;
	//Only turbo when player != robber && player != mouse
	_turboAllowed = (!(player getVariable ["isRobber", true])) || !(player getVariable ["isMouse", true]);
	
	if (_turboAllowed) then
	{
		DYN_RACE_TURBO_ENABLED = true;
		DYN_RACE_TURBO_HANDLE = [] spawn DYN_RACE_TURBO_SCRIPT;
	};
};