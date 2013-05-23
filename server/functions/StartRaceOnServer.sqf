/* DYN_RACE_StartRaceOnServer: Starts the race on the server.
* This function should NOT be called directly. Internal function.
*
*/
DYN_RACE_StartRaceOnServer =
{
	if (!isServer) exitWith {};
	"DYN_RACE_StartRaceOnServer" call DYN_RACE_Debug;
	sleep 15;
	
	DYN_RACE_STARTTIME = diag_tickTime;
	publicVariable "DYN_RACE_STARTTIME";
	_racer_count = count DYN_RACE_RACERS;
	for [ {_i = 0}, {_i < _racer_count}, {_i = _i + 1}] do
	{
		_racer = DYN_RACE_RACERS select _i;
		_racer set [5, true];
		DYN_RACE_RACERS set [_i, _racer];
	};
	
	//This call actually makes sure the players vehicle is enabled.
	
	DYN_RACE_STATE = "ONGOING";
	[] spawn 
	{
		while {DYN_RACE_STATE == "ONGOING"} do
		{
			DYN_RACE_ELAPSED_TIME = diag_tickTime - DYN_RACE_STARTTIME;
			publicVariable "DYN_RACE_ELAPSED_TIME";
			sleep 1;
		};
	};
	[] spawn
	{
		_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
		{
			_unit = _x;
			if(vehicle _unit != _unit) then
			{
				vehicle _unit setFuel 1;
			};
		} forEach _units;
	};
	publicVariable "DYN_RACE_STATE";
	publicVariable "DYN_RACE_RACERS";
	
	[] call DYN_RACE_OnRaceStateChanged;
	[] call DYN_RACE_OnRacersChanged;
	
};