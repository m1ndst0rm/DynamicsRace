/* DYN_fnc_PlayerFinished: Trigger which should be called from editor
* Trigger to place over the finish line.
*
* Example: [thislist] call DYN_RACE_Finish;
*/
private ["_list","_local_racers","_racer_count","_i","_racer","_player","_currentCheckpoint","_currentCheckpointId","_lap_times","_time","_teamNumber","_players","_team","_finished_players","_finishedCount","_caughtCount","_doneCount"];
"DYN_fnc_PlayerFinished" call BIS_fnc_log;
if(DYN_RACE_STATE != "ONGOING") exitWith { };
if!(isServer) exitWith { };

_list = _this;

_local_racers = DYN_RACE_RACERS;
_racer_count = count _local_racers;

_i= 0; for "_i" from 0 to (_racer_count - 1) do
{
	_racer = _local_racers select _i;
	{
		_player = (driver _x);
		if(_player == (_racer select 1)) then
		{
			//Only save finish time if it's SINGLE race, or cat, robber 
			if(DYN_RACE_TYPE == "SINGLE" ||  _player getVariable ["isMouse", false] || _player getVariable ["isRobber", false] || DYN_RACE_TYPE == "DUAL" || DYN_RACE_TYPE == "TEAM" || DYN_RACE_TYPE == "TEAM3") then
			{			
				//TODO: Waypoint check
				//_currentCheckpoint = (currentTask _player);
				_currentCheckpointId = _player getVariable ["currentWaypointId", -1];//(simpleTasks _player) find _currentCheckpoint;
				if(_currentCheckpointId == count DYN_RACE_CHECKPOINTS - 1 || !(isPlayer _player)) then
				{ //Current checkpoint is finish.
					//We only save the finish time to the driver.
					
					_lap_times = _player getVariable "lapTimes";
					_time = DYN_RACE_ELAPSED_TIME;
					_lap_times set [count _lap_times, _time];
					
					_player setVariable ["lapTimes", _lap_times, true];
					_player setVariable ["prosessingFinish", true, true];
					
					if((count _lap_times == DYN_RACE_LAPS)) then
					{
						_teamNumber = _player getVariable ["teamNumber", -1];
						_player setVariable ["hasFinished", true, true];
						_players = [_player];
						if(_teamNumber != -1 && DYN_RACE_TYPE != "CAT&MOUSE") then
						{
							_team = DYN_RACE_TEAMS select _teamNumber;
							_players = _team select 2;
						};
						
						if(isMultiplayer || {(player == _player)}) then
						{
							[_players,"DYN_fnc_Finished",_players] call BIS_fnc_MP;
						};
					};
				};
			};
		};
	} forEach _list;
};

//publicVariable "DYN_RACE_RACERS";
//[] call DYN_fnc_OnRacersChanged;

_finished_players = call DYN_fnc_GetFinishedPlayers;

if(count _finished_players > 0 && DYN_RACE_FINISHTIME == -1 && DYN_RACE_TYPE != "COPS&ROBBERS") then
{
	//A racer finished. Only SINGLE players, DUAL player drivers, mice and robbers get a finished time. So only them can trigger this event.
	//TODO_GAMEPLAY: Do mice or robbers need to trigger this event?
	_time = diag_tickTime - DYN_RACE_STARTTIME; //(if (isMultiplayer) then {serverTime} else {time});
	DYN_RACE_FINISHTIME = _time;
	publicVariable "DYN_RACE_FINISHTIME";
	[] spawn {
		sleep DYN_RACE_TIMETOFINISH;
		
		//Don't retrigger finish if all players managed to finish.
		if (DYN_RACE_STATE != "FINISHED" && DYN_RACE_STATE != "IDLE") then
		{
			DYN_RACE_STATE = "FINISHED";
			publicVariable "DYN_RACE_STATE";

			[] call DYN_fnc_OnRaceStateChanged;
		};
	};
};

//[format ["%1 racers. %2 finished.", count DYN_RACE_RACERS, count _finished_players]] call BIS_fnc_log;

_finishedCount = (count _finished_players);
_caughtCount = {(_x select 1) getVariable ["isCaught", false]} count DYN_RACE_RACERS;
_doneCount = _finishedCount + _caughtCount;
if(DYN_RACE_DRIVERCOUNT == (count _finished_players) || (DYN_RACE_ROBBERCOUNT == _doneCount && DYN_RACE_TYPE == "COPS&ROBBERS")) then
{
	DYN_RACE_STATE = "FINISHED";
	publicVariable "DYN_RACE_STATE";

	[] call DYN_fnc_OnRaceStateChanged;
};