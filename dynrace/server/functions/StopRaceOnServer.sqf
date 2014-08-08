/* StopRaceOnServer: Stops a running race server sided.
* This function should NOT be called directly. Internal function.
*
*/
if !(isServer) exitWith {};
private ["_racer","_player","_vehicle"];
"StopRaceOnServer" call BIS_fnc_log;

sleep 15;

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
	_player setVariable ["vehicle", nil, true];
	_player setVariable ["driver", nil, true];
	_player setVariable ["hasFinished", false, true];
	_player setVariable ["isCaught", false, true];
	_player setVariable ["isSpectator", false, true];
	_player setVariable ["lapTimes", [], true];
	_player setVariable ["teamNumber", -1, true];
	

	_vehicle = _racer select 2;
	if!(isPlayer _player) then
	{
		moveOut _player;
		sleep 0.1;
		_pos = [(getMarkerPos "DYN_RACE_Respawn"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
		_player setPos _pos;
	};
	if(_vehicle in vehicles) then
	{
		deleteVehicle _vehicle;
	};
	
	//deleteWaypoint [group player, all];
} forEach DYN_RACE_RACERS;

[] call DYN_fnc_PrepareRace;

if ({ !(isPlayer _x)} count DYN_RACE_AVAILABLERACERS > 0) then
{
	{
		if!(isPlayer _x) then
		{
			_group = group _x;
			while {(count (waypoints _group)) > 0} do
			{
				deleteWaypoint [_group, 0];
			};
		};
	} forEach DYN_RACE_AVAILABLERACERS;
};

DYN_RACE_TYPE = "";
publicVariable "DYN_RACE_TYPE";

DYN_RACE_STATE = "IDLE";
publicVariable "DYN_RACE_STATE";

DYN_RACE_INITPREPDONE = false;
publicVariable "DYN_RACE_INITPREPDONE";

DYN_RACE_TEAMS = [];
publicVariable "DYN_RACE_TEAMS";
[] call DYN_fnc_OnRaceStateChanged;