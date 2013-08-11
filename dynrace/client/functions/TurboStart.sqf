private ["_turboAllowed"];
if!(DYN_RACE_TURBO_ENABLED) then
{
	//"TurboStart" call BIS_fnc_log;
	//Only turbo when player != robber && player != mouse
	_turboAllowed = (!(player getVariable ["isRobber", true])) || !(player getVariable ["isMouse", true]);
	
	if (_turboAllowed) then
	{
		DYN_RACE_TURBO_ENABLED = true;
		DYN_RACE_TURBO_HANDLE = [] spawn DYN_fnc_TURBO_SCRIPT;
	};
};