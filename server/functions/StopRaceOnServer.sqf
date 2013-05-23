/* StopRaceOnServer: Stops a running race server sided.
* This function should NOT be called directly. Internal function.
*
*/
DYN_RACE_StopRaceOnServer = 
{
	if !(isServer) exitWith {};
	"StopRaceOnServer" call DYN_RACE_Debug;
	sleep 15;

	DYN_RACE_EXPLOSIONS = [];
	DYN_RACE_FIRES = [];
	DYN_RACE_STARTTIME = null;
	DYN_RACE_FINISHTIME = -1;
	DYN_RACE_VOTES = [];

	
	publicVariable "DYN_RACE_EXPLOSIONS";
	publicVariable "DYN_RACE_STARTTIME";
	publicVariable "DYN_RACE_FINISHTIME";
	
	{
		_vehicles = _x select 1;
		{
			deleteVehicle _x;
		} forEach _vehicles;
	} forEach DYN_RACE_MAP_VEHICLES;
	DYN_RACE_MAP_VEHICLES = [];
	
	
	//Move out AI and remove all vehicles
	{
		_racer = _x;
		_player_netId = _racer select 1;
		_vehicle_netId = _racer select 2;
		_player = [_player_netId] call DYN_RACE_FindLocalPlayer;
		moveOut _player;
		sleep 0.1;
		
		if!(isPlayer _player) then
		{
			_pos = [(getMarkerPos "respawn_west"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
			_player setPos _pos;
		};
		
		_vehicle = [_vehicle_netId] call DYN_RACE_FindLocalVehicle;
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
	
	[] call DYN_RACE_OnRaceStateChanged;
	
	DYN_RACE_STATE = "IDLE";
	publicVariable "DYN_RACE_STATE";
};