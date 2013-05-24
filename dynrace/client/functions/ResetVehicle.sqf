/* DYN_RACE_ResetVehicle: Reset the vehicle from a local player.
* Note: Vehicle will be reset to the closest road (not perse the racing road).
* Note2: Only resets current player
* TODO: Improve heading on reset (poiting to next waypoint?)
* TODO2?: Change so it can be used with a trigger
*/
DYN_RACE_ResetVehicle = 
{
	"DYN_RACE_ResetVehicle" call DYN_RACE_Debug;
	if(vehicle player != player && DYN_RACE_STATE == "ONGOING") then
	{
		[] spawn
		{
			if(time - DYN_PLAYER_VEHICLE_RESET_TIME > 5) then
			{
				DYN_PLAYER_VEHICLE_RESET_TIME = time;
				_nearRoads = (position player) nearRoads 100;
				_closes_road = objNull;
				{
					_road = _x;
					if(isNull _closes_road || ((position player) distance (position _road) < (position player) distance (position _closes_road))) then
					{
						_closes_road = _road;
					};
				} forEach _nearRoads;
				
				_closest_pos = _closes_road;
				if(isNull _closes_road) then
				{
					//Previous waypoint
					_currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
					_previousCheckpoint = getMarkerPos "DYN_RACE_Marker_Start";
					if(_currentCheckpointId != 0) then
					{
						_previousCheckpointId = _currentCheckpointId - 1;
						_previousCheckpoint = taskDestination (simpleTasks player select _previousCheckpointId);
					};
					_closest_pos = _previousCheckpoint;
				};
				
				_text = "<t align='center' size='1.8'>Resetting in 3 seconds</t>";
				[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
				sleep 3;
				(vehicle player) setpos (position _closest_pos);
			};
		};
	};
	true;
};