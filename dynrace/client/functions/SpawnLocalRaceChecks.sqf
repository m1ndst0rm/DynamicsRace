/* DYN_RACE_SpawnLocalRaceChecks: Spawns a loop that checks local client stuff
 * Spawns a loop that does a couple of client sided chechsk including:
 * -Player in vehicle
 * -Player on road
 * -Player flipped
 * -Player checkpoints
 * -If someone finished display time remaining till race will be forcable quit.
 */
FINISH_CHECK = 1;
PLAYER_IN_VEHICLE_CHECK = 1;
ON_ROAD_CHECK = 1;
WAYPOINT_CHECK = 0.5;
VEHICLE_FLIP_CHECK = 1;

DYN_RACE_SpawnLocalRaceChecks =
{
	"DYN_RACE_SpawnLocalRaceChecks" call DYN_RACE_Debug;
	
	//Finish Timer
	[] spawn
	{
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			//Finish time
			if ( !(DYN_RACE_FINISHTIME == -1)) then
			{
				_timeLeft = floor(DYN_RACE_FINISHTIME + DYN_RACE_TIMETOFINISH - DYN_RACE_ELAPSED_TIME);

				_text = format["<t align='center' size='1.8'>%1</t>", _timeLeft];
				[_text, -1, -1, 0.5, 0.2] spawn BIS_fnc_dynamicText;
			};
			sleep FINISH_CHECK;
		};
	};
	
	//Player in vehicle
	[] spawn
	{
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			if(vehicle player == player) then
			{
				_vehicle_netId = player getVariable "vehicleId";
				_vehicle = [_vehicle_netId] call DYN_RACE_FindLocalVehicle;
				
				if(isNull (driver vehicle _vehicle)) then
				{
					player moveInDriver _vehicle;
				}
				else
				{
					player moveInGunner _vehicle;
				};
			};
			sleep PLAYER_IN_VEHICLE_CHECK;
		};
	};
	
	//Roadcheck
	[] spawn
	{
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			if(DYN_RACE_MUST_STAY_ON_ROAD_LOCAL && {DYN_RACE_ELAPSED_TIME > 15}) then
			{
				_isOnRoad = isOnRoad (position vehicle player);
				if(_isOnRoad) then
				{
					if !(DYN_PLAYER_ON_ROAD) then
					{//Player was previously offroad, reset timer.
						DYN_PLAYER_ON_ROAD = true;
						DYN_PLAYER_LAST_ON_ROAD_TIME = null;
					}
				}
				else
				{
					_time = diag_tickTime;
					if (DYN_PLAYER_ON_ROAD) then
					{//Player moving offroad
						DYN_PLAYER_ON_ROAD = false;
						DYN_PLAYER_LAST_ON_ROAD_TIME = _time;
					};

					if(_time - DYN_PLAYER_LAST_ON_ROAD_TIME >= 5) then
					{//Display reset timer
						_reset = 20 - (_time - DYN_PLAYER_LAST_ON_ROAD_TIME);
						_text = format["<t align='center' valign='middle' size='1.8'>Warning leaving road. Reset in  %1</t>", floor _reset];
						//(_time - DYN_RACE_LAST_WARNING > 1) then
						//{
						//	DYN_RACE_LAST_WARNING = _time;
					   [_text, -1, -1, 1, 1] spawn BIS_fnc_dynamicText;
						//};
					};
					if(_time - DYN_PLAYER_LAST_ON_ROAD_TIME >= 20) then
					{//Reset
						_currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
						_previousCheckpoint = getMarkerPos "DYN_RACE_Marker_Start";
						if(_currentCheckpointId != 0) then
						{
							_previousCheckpointId = _currentCheckpointId - 1;
							_previousCheckpoint = taskDestination (simpleTasks player select _previousCheckpointId);
						};
						(vehicle player) setPos _previousCheckpoint;
						//In case start pos is not on raod
						DYN_PLAYER_LAST_ON_ROAD_TIME = _time;
						DYN_PLAYER_ON_ROAD = true;
					};
				};
			};
			sleep ON_ROAD_CHECK;
		};
	};
	
	//Check checkpoints
	[] spawn {
		_currentCheckpoint = (currentTask player);
		_currentCheckpointDestination = taskDestination _currentCheckpoint;
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			
			if((_currentCheckpointDestination distance player) < 25) then
			{
				//player hits a waypoint
				_currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
				_nextWaypointId = null;
				if(_currentCheckpointId == count DYN_RACE_CHECKPOINTS - 1) then
				{
					_nextWaypointId =  0;
				}
				else
				{
					_nextWaypointId = (_currentCheckpointId + 1);
				};
				_nextWaypoint = (simpleTasks player select _nextWaypointId);
				
				_lapsDriven = -1;
				_racers = DYN_RACE_RACERS;
				{
					_racer = _x;
					_player_netId = _racer select 1;
					_laptimes = _racer select 6;
					
					//_player = [_player_netId] call DYN_RACE_FindLocalPlayer;
					
					if(_player_netId == [player] call DYN_RACE_GetObjectID) then
					{
						_lapsDriven = count _laptimes;
					};
				} forEach _racers;
				
				if(_nextWaypointId == 0 && (_lapsDriven == DYN_RACE_LAPS - 1 or _lapsDriven == DYN_RACE_LAPS)) then
				{ //DYN_RACE_LAPS - 1: This is used because the player might hit the checkpoint before the finish.
					player setCurrentTask taskNull;
				}
				else
				{
					player setCurrentTask _nextWaypoint;
					_currentCheckpointId = _nextWaypointId;
					_text = "<t align='center' size='1.8'>Checkpoint!</t>";
					[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
				};
				_currentCheckpoint = (currentTask player);
				_currentCheckpointDestination = taskDestination _currentCheckpoint;
			};
			
			sleep WAYPOINT_CHECK;
		};
	};
	
	//Vehicle fliped. Disabled for the moment. (Players can decide for themselve).
	[] spawn {
		while{ (false && DYN_RACE_STATE == "ONGOING") } do 
		{
			
			if(vehicle player != player) then
			{
				_vectorup = vectorUp (vehicle  player);
				if((_vectorup select 2) < 0) then
				{
					DYN_PLAYER_VEHICLE_FLIPPED = true;
				}
				else
				{
					DYN_PLAYER_VEHICLE_FLIPPED = false;
				};
				
				if(DYN_PLAYER_VEHICLE_FLIPPED) then
				{
					if((time - DYN_PLAYER_VEHICLE_RESET_TIME) >= 5) then
					{
						(vehicle player) setpos [getpos (vehicle player) select 0, getpos (vehicle player) select 1, 0];
					};
				};
			};
			sleep VEHICLE_FLIP_CHECK;
		};
	};
};