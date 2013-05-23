/* DYN_RACE_SpawnLocalTimer: Spawns a local timer.
* Spawn a loop that displays the timer & finished players.
*/
DYN_RACE_SpawnLocalTimer = 
{
	"DYN_RACE_SpawnLocalTimer" call DYN_RACE_Debug;
	[] spawn {
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{		
			//TODO: Lap times 
			_timedif = DYN_RACE_ELAPSED_TIME;
			_formatted_time = [_timedif] call DYN_RACE_FormatTime;
			
			_message = format ["%1\n\n", _formatted_time];

			_finished_players = call DYN_RACE_GetFinishedPlayers;
			
			{
				_racer = _x;
				_playerName = _racer select 0;
				
				_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
				_formatted_time = [_finish_time] call DYN_RACE_FormatTime;
				_message = _message + format["%1 - %2\n", _playerName, _formatted_time];
			} forEach _finished_players;
				
			hint _message;
			sleep 1;
		};
	};	
};