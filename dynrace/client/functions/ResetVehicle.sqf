/* DYN_RACE_ResetVehicle: Reset the vehicle from a local player.
* Note: Vehicle will be reset to the closest road (not perse the racing road).
* Note2: Only resets current player
* TODO: Improve heading on reset (poiting to next waypoint?)
* TODO2?: Change so it can be used with a trigger
*/
"DYN_RACE_ResetVehicle" call DYN_RACE_Debug;
if(vehicle player != player && 
DYN_RACE_STATE == "ONGOING" && 
(player getVariable ["isDriver", false]) && 
!(DYN_RACE_PLAYER_FINISHED)) then
{
	[] spawn
	{
		if(time - DYN_PLAYER_VEHICLE_RESET_TIME > 5) then
		{
			DYN_PLAYER_VEHICLE_RESET_TIME = time;
			
			_resetPos = objNull;
			_resetDir = objNull;
			
			if(DYN_RACE_MUST_STAY_ON_ROAD_LOCAL) then
			{
				_resetPos = DYN_RACE_LASTONROADPOS;
				_resetDir = DYN_RACE_LASTONROADDIR;
			}
			else
			{		
				_closes_road = objNull;
				_closest_pos = objNull;
							
				_nearRoads = (position player) nearRoads 100;
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
				_resetPos = position _closest_pos;
			};
			
			_text = "<t align='center' size='1.8'>Resetting in 5 seconds</t>";
			[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
			_vehicle = player getVariable "vehicle";
			_vehicle setFuel 0;
			sleep 5;
			_vehicle setFuel 1;
			_vehicle setpos _resetPos;
			if(isNull _resetDir) then
			{
				_vehicle setDir _resetDir;
			};
			
			//TODO: Think
			if!(player getVariable ["isRobber", false]) then
			{
				_vehicle setDamage 0;
			};
		};
	};
};
true;