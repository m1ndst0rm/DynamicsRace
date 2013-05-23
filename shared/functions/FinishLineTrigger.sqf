/* DYN_RACE_FinishLineTrigger: Trigger which should be called from editor
* Trigger to place over the finish line.
*
* Example: [thislist] call DYN_RACE_Finish;
*/
DYN_RACE_FinishLineTrigger = 
{
	"DYN_RACE_FinishLineTrigger" call DYN_RACE_Debug;
	if(DYN_RACE_STATE != "ONGOING") exitWith { };
	
	_list = _this select 0;
	
	_local_racers = DYN_RACE_RACERS;
	_racer_count = count _local_racers;
	[format ["Trigger DYN_RACE_FinishLineTrigger: %1", count _list]] call DYN_RACE_Debug;
	
	
	for [ {_i = 0}, {_i < _racer_count}, {_i = _i + 1}] do
	{
		_racer = _local_racers select _i;
		{
			_player = (driver _x);
			
			if(([_player] call DYN_RACE_GetObjectID) == (_racer select 1)) then
			{
				[format ["Racer '%1' finished", name _player]] call DYN_RACE_Debug;
				_lap_times = _racer select 6;
				_time = DYN_RACE_ELAPSED_TIME;//(if (isMultiplayer) then {serverTime - DYN_RACE_STARTTIME} else {time - DYN_RACE_STARTTIME});
				_lap_times set [count _lap_times, _time];
				if(isServer) then
				{
					//TODO: Waypoint check
					_racer set [6, _lap_times];
					
					_local_racers set [_i, _racer];
					DYN_RACE_RACERS = _local_racers;
					_player setCaptive true;
				};
				
				if !(isDedicated) then
				{
					_player_obj_id = [_player] call DYN_RACE_GetObjectID;
					_local_player_obj_id = [player] call DYN_RACE_GetObjectID;
					
					if(( _player_obj_id == _local_player_obj_id) && (count (_racer select 6) == DYN_RACE_LAPS)) then
					{
						DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = false;
						[] spawn DYN_RACE_EnableSpectator;
					};
				};
			};
			
			[vehicle _player] spawn
			{
				_vehicle = _this select 0;
				_speed = speed _vehicle;
				while{ (_speed > 1) } do 
				{
					_diff = 0.02;
					_vel = velocity _vehicle;
					_dir = getDir _vehicle;
					_vehicle setVelocity [(_vel select 0)-(sin _dir*_diff),(_vel select 1)-(cos _dir*_diff),(_vel select 2)];
					_speed = speed _vehicle;
					sleep 0.01;
				};
				_vehicle setVelocity[0,0,0];
				//_vehicle enableSimulation false;
				_vehicle setFuel 0;
				_vehicle engineOn false;
			};
			
			
		} forEach _list;
	};

	if(isServer) then
	{
		publicVariable "DYN_RACE_RACERS";
		[] call DYN_RACE_OnRacersChanged;

		_finished_players = call DYN_RACE_GetFinishedPlayers;
		
		if(count _finished_players > 0 && DYN_RACE_FINISHTIME == -1) then
		{
			//A racer finished. If first racer then init ending.
			_time = diag_tickTime - DYN_RACE_STARTTIME; //(if (isMultiplayer) then {serverTime} else {time});
			DYN_RACE_FINISHTIME = _time;
			publicVariable "DYN_RACE_FINISHTIME";
			[] spawn {
				sleep DYN_RACE_TIMETOFINISH;
				
				//Don't retrigger finish if all players managed to finish.
				if !(DYN_RACE_STATE == "FINISHED") then
				{
					DYN_RACE_STATE = "FINISHED";
					publicVariable "DYN_RACE_STATE";

					[] call DYN_RACE_OnRaceStateChanged;
				};
			};
		};
		
		[format ["%1 racers. %2 finished.", count DYN_RACE_RACERS, count _finished_players]] call DYN_RACE_Debug;
		if((count DYN_RACE_RACERS) == (count _finished_players)) then
		{
			DYN_RACE_STATE = "FINISHED";
			publicVariable "DYN_RACE_STATE";

			[] call DYN_RACE_OnRaceStateChanged;
		};
	};
};