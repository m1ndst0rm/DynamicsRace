/* DYN_fnc_SpawnLocalRaceChecks: Spawns a loop that checks local client stuff
 * Spawns a loop that does a couple of client sided chechsk including:
 * -Player in vehicle
 * -Player on road
 * -Player flipped
 * -Player checkpoints
 * -If someone finished display time remaining till race will be forcable quit.
 */
#define DYN_RACE_FINISH_CHECK 1
#define DYN_RACE_PLAYER_IN_VEHICLE_CHECK 1
#define DYN_RACE_ON_ROAD_CHECK 1
#define DYN_RACE_WAYPOINT_CHECK 0.5
#define DYN_RACE_VEHICLE_DAMAGE_CHECK 1
#define DYN_RACE_MARKER_UPDATE 1

private ["_timeLeft","_text","_tempTime","_vehicle","_isOnRoad","_time","_reset","_currentCheckpointId","_currentCheckpoint","_previousCheckpoint","_previousCheckpointId","_currentCheckpointDestination","_previousWaypoint","_previousCheckpointDestination","_previousWayPointDistance","_nextWaypointId","_nextWaypoint","_lapsDriven","_lapsDrivenOld","_lapsleft","_racer","_player_name","_marker","_i","_player"];
"DYN_fnc_SpawnLocalRaceChecks" call BIS_fnc_log;

if(player getVariable ["isCommander", false]) then
{
	MARKER_UPDATE = 0.2;
};

//Finish Timer
[] spawn
{
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		//Finish time
		if ( !(DYN_RACE_FINISHTIME == -1)) then
		{
			_timeLeft = floor(DYN_RACE_FINISHTIME + DYN_RACE_TIMETOFINISH - DYN_RACE_ELAPSED_TIME);
			if(_timeLeft >= 0) then
			{
				_text = format["<t align='center' size='1.8'>%1</t>", _timeLeft];
				[_text, -1, 0.05, 1.2, 0, 0, 11111] spawn BIS_fnc_dynamicText;
			};
		};
		sleep DYN_RACE_FINISH_CHECK;
	};
};

//Player in vehicle
[] spawn
{
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		if(vehicle player == player) then
		{
			_vehicle = player getVariable "vehicle";
			
			//This check is actually for when vehicle is submerged			
			if(player getVariable "isDriver") then
			{
				player moveInDriver _vehicle;
			}
			else
			{
				player moveInGunner _vehicle;
			};
		};
		sleep DYN_RACE_PLAYER_IN_VEHICLE_CHECK;
	};
};

//Roadcheck
if(player getVariable "isDriver") then
{
	[] spawn
	{
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			
			_isOnRoad = isOnRoad (position vehicle player);
			if(_isOnRoad) then
			{
				if !(DYN_PLAYER_ON_ROAD) then
				{//Player was previously offroad, reset timer.
					DYN_PLAYER_ON_ROAD = true;
					DYN_PLAYER_LAST_ON_ROAD_TIME = objNull;
				};
				DYN_RACE_LASTONROADPOS = position vehicle player;
				DYN_RACE_LASTONROADDIR = direction vehicle player;
			}
			else
			{
				if(DYN_RACE_MUST_STAY_ON_ROAD_LOCAL && DYN_RACE_ELAPSED_TIME > 5) then
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
						if(_reset > 0) then
						{
							_text = format["<t align='center' valign='middle' size='1.8'>Warning leaving road.<br/>Reset in  %1</t>", floor _reset];
							//(_time - DYN_RACE_LAST_WARNING > 1) then
							//{
							//	DYN_RACE_LAST_WARNING = _time;
						   [_text, -1, 0.05, 1.2, 0, 0, 11113] spawn BIS_fnc_dynamicText;
							//};
						};
					};
					if(_time - DYN_PLAYER_LAST_ON_ROAD_TIME >= 20) then
					{//Reset
						//_currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
						//_previousCheckpoint = getMarkerPos "DYN_RACE_Marker_Start";
						//if(_currentCheckpointId != 0) then
						// {
							// _previousCheckpointId = _currentCheckpointId - 1;
							// _previousCheckpoint = taskDestination (simpleTasks player select _previousCheckpointId);
						// };
						//(vehicle player) setPos _previousCheckpoint;
						(vehicle player) setPos DYN_RACE_LASTONROADPOS;
						(vehicle player) setDir  DYN_RACE_LASTONROADDIR;
						//In case start pos is not on raod
						DYN_PLAYER_LAST_ON_ROAD_TIME = _time;
						DYN_PLAYER_ON_ROAD = true;
					};
				};
			};
			sleep DYN_RACE_ON_ROAD_CHECK;
		};
	};
};
//Check checkpoints
[] spawn {
	_currentCheckpoint = (currentTask player);
	_currentCheckpointDestination = taskDestination _currentCheckpoint;

	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		_currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
		
		_previousWaypoint = -1;
		if(_currentCheckpointId == 0) then
		{
			_previousWaypoint = (simpleTasks player) select (count DYN_RACE_CHECKPOINTS - 1);
		}
		else
		{
			_previousWaypoint = (simpleTasks player) select (_currentCheckpointId - 1);
		};
		
		_previousCheckpointDestination = taskDestination _previousWaypoint;
		_previousWayPointDistance = player distance _previousCheckpointDestination;
		
		player setVariable ["previousWaypointDistance", _previousWayPointDistance, true];
		
		if((_currentCheckpointDestination distance player) < 25) then
		{
			//player hits a waypoint
			_nextWaypointId = -1;
			if(_currentCheckpointId == count DYN_RACE_CHECKPOINTS - 1) then
			{
				_nextWaypointId =  0;
			}
			else
			{
				_nextWaypointId = (_currentCheckpointId + 1);
			};
			_nextWaypoint = (simpleTasks player select _nextWaypointId);
			
			_lapsDriven = count (player getVariable "lapTimes");
			
			if(_nextWaypointId != 0) then
			{
				player setCurrentTask _nextWaypoint;
				_currentCheckpointId = _nextWaypointId;
				player setVariable ["currentWaypointId", _currentCheckpointId, true];
				_text = "<t align='center' size='1.8'>Checkpoint!</t>";
				[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
			};
			_currentCheckpoint = (currentTask player);
			_currentCheckpointDestination = taskDestination _currentCheckpoint;
		};
		
		//If next waypoint is finish just wait untill we hit the finish. Else the checkpoint check could occure before the servers registers the finish and therefor think you need annother round
		if(_currentCheckpointId == count DYN_RACE_CHECKPOINTS - 1) then
		{
			_lapsDriven = count (player getVariable ["lapTimes",[]]);
			_lapsDrivenOld = _lapsDriven;
			while{ _lapsDrivenOld == _lapsDriven } do
			{
				_lapsDriven = count (player getVariable "lapTimes");
				sleep 0.1;
			};
			
			if (DYN_RACE_STATE == "ONGOING") then
			{
				if(_lapsDriven == DYN_RACE_LAPS) then
				{
					player setCurrentTask taskNull;
					player setVariable ["currentWaypointId", 0, true];
					_text = "<t align='center' size='1.8'>Finished!!!</t>";
					[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
				}
				else
				{
					_nextWaypoint = (simpleTasks player select 0);
					
					_lapsleft = DYN_RACE_LAPS - _lapsDriven;
					player setCurrentTask _nextWaypoint;
					player setVariable ["currentWaypointId", 0, true];
					_currentCheckpointId = (simpleTasks player) find _nextWaypoint;
					_text = format["<t align='center' size='1.8'>%1 laps left!</t>", _lapsleft];
					[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
				};
				_currentCheckpoint = (currentTask player);
				_currentCheckpointDestination = taskDestination _currentCheckpoint;
			};
			player setVariable ["prosessingFinish", false, true];
		};
		sleep DYN_RACE_WAYPOINT_CHECK;
	};
};

//Vehicle damage
[] spawn {
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		//TODO: Decide what to do
		_vehicle = vehicle player;
		if(damage _vehicle == 1 || underwater _vehicle || underwater player) then
		{
			[] call DYN_fnc_ResetVehicle;
		};
		sleep DYN_RACE_VEHICLE_DAMAGE_CHECK;
	};
};

[] spawn
{
	DYN_RACE_RACERS_MARKERS = [];
	{
		
		_racer = _x;
		_player_name = _racer select 0;
		_vehicle = _racer select 2;
		
		//TODO: Fix
		_marker = createMarkerLocal [_player_name, position _vehicle];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "Empty";
		DYN_RACE_RACERS_MARKERS = [count DYN_RACE_RACERS_MARKERS, _marker];
	} foreach DYN_RACE_RACERS;
	
	//TODO FIx
	while {DYN_RACE_STATE == "ONGOING" && false} do
	{
		_i = 0;
		{
			_racer = _x;
			_player = _racer select 1;
			_vehicle = _racer select 2;
			_marker = DYN_RACE_RACERS_MARKERS select _i;

			_marker setMarkerPosLocal getPos _vehicle;
			_marker setMarkerDirLocal getDir _vehicle;
			_i = _i + 1;
		} foreach DYN_RACE_RACERS;
		sleep DYN_RACE_MARKER_UPDATE;
	};
};