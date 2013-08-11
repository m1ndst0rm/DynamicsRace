/* DYN_fnc_GetFinishedPlayers: Return all finished players orderd by finishtime
*
* Returns:
* Array[DYN_RACER]: _finished_players;
*/
private ["_finished_players","_tempFinished","_racer","_player","_laptimes","_finish_time","_ordered_players","_ordered_player"];
_finished_players = [];

_tempFinished = [];
{
	_racer = _x;
	_player = _racer select 1;
	_laptimes = _player getVariable ["lapTimes",[]];
	if((count _laptimes) == DYN_RACE_LAPS) then
	{
		_player = _racer select 1;
		_finish_time = [_racer] call DYN_fnc_GetRacerFinishedTime;
		_tempFinished set [count _tempFinished, [_player,_finish_time]];
	};
} foreach DYN_RACE_RACERS;

_ordered_players = [_tempFinished, 1] call KRON_ArraySort;

{
	_ordered_player = _x;
	_player = _ordered_player select 0;
	{
		_racer = _x;
		if(_racer select 1 == _player) then
		{
			_finished_players set [count _finished_players, _racer];
		};
	} forEach DYN_RACE_RACERS;
} forEach _ordered_players;

_finished_players;