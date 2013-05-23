/* DYN_RACE_GetFinishedPlayers: Return all finished players orderd by finishtime
*
* Returns:
* Array[DYN_RACER]: _finished_players;
*/
DYN_RACE_GetFinishedPlayers =
{
	_finished_players = [];
	
	_tempFinished = [];
	{
		_racer = _x;
		_laptimes = _racer select 6;
		if((count _laptimes) == DYN_RACE_LAPS) then
		{
			_racer_netId = _racer select 1;
			_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
			_tempFinished set [count _tempFinished, [_racer_netId,_finish_time]];
		};
	} foreach DYN_RACE_RACERS;
	
	_ordered_players = [_tempFinished, 1] call KRON_ArraySort;
	
	{
		_ordered_player = _x;
		_racer_netId = _ordered_player select 0;
		{
			_racer = _x;
			if(_racer select 1 == _racer_netId) then
			{
				_finished_players set [count _finished_players, _racer];
			};
		} forEach DYN_RACE_RACERS;
	} forEach _ordered_players;
	
	_finished_players;
};