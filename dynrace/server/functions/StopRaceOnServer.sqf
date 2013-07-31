/* StopRaceOnServer: Stops a running race server sided.
* This function should NOT be called directly. Internal function.
*
*/
if !(isServer) exitWith {};
"StopRaceOnServer" call DYN_RACE_Debug;
sleep 15;

[] call DYN_RACE_PrepareRace;

//Move out AI and remove all vehicles
{
	_racer = _x;
	_player = _racer select 1;
	_player setVariable ["isDriver", false, true];
	_player setVariable ["isRobber", false, true];
	_player setVariable ["isMouse", false, true];
	_player setVariable ["isCommander", false, true];
	_player setVariable ["isCat", false, true];
	_player setVariable ["isGunner", false, true];
	_player setVariable ["isCop", false, true];
	_player setVariable ["vehicle", objnull, true];
	_player setVariable ["driver", objnull, true];
	_player setVariable ["hasFinished", false, true];
	_player setVariable ["isCaught", false, true];
	_player setVariable ["isSpectator", false, true];
	_player setVariable ["lapTimes", [], true];
	_player setVariable ["teamNumber", -1, true];
	

	_vehicle = _racer select 2;
	moveOut _player;
	sleep 0.1;
	
	if!(isPlayer _player) then
	{
		_pos = [(getMarkerPos "respawn_west"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
		_player setPos _pos;
	};
	
	
	if(_vehicle in vehicles) then
	{
		deleteVehicle _vehicle;
	};
	
	//deleteWaypoint [group player, all];
} forEach DYN_RACE_RACERS;

_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
{
	_racer = _x;
	_racer setcaptive false;
} forEach _units;


DYN_RACE_TYPE = "";
publicVariable "DYN_RACE_TYPE";

DYN_RACE_STATE = "IDLE";
publicVariable "DYN_RACE_STATE";

DYN_RACE_TEAMS = [];
publicVariable "DYN_RACE_TEAMS";
[] call DYN_RACE_OnRaceStateChanged;