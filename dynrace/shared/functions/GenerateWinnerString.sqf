/* DEPRECATED
* DYN_RACE_GenerateWinnerString: returns a string containing the winners of the current race.
* Will be reset once a new race is started. 
*
* Returns:
* string _winners: String containing winners seperated with a newline (<br />).
*/
hintc "DEPRECATED";
_finished_players = call DYN_RACE_GetFinishedPlayers;
_i = 1;

_finished_players_time_array = [];

{
	_racer = _x;
	
	_playerName = _racer select 0;
	_palyer = _racer select 1;
	
	_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
	_formatted_time = [_finish_time] call DYN_RACE_FormatTime;
	
	_teamNumber = _player getVariable ["teamNumber", -1];
	
	_displayName = _playerName;
	if(_teamNumber != -1) then
	{
		_displayName = _teamNumber call DYN_RACE_GetTeamName;
	};
	
	_finished_players_time_array = _finished_players_time_array + [format["%1: %2", _i, _displayName], _formatted_time];
	_i = _i + 1;
} forEach _finished_players;

{
	_racer = _x;
	_player = _racer select 1;
	_hasFinished = false;
	{
		_finished_racer = _x;
		if(_racer select 1 == _finished_racer select 1) then
		{
			_hasFinished = true;
		};
	} forEach _finished_players;
	
	if !(_hasFinished && _player getVariable["isDriver", false]) then
	{
		_playerName = _racer select 0;
		
		_teamNumber = _player getVariable ["teamNumber", -1];
	
		_displayName = _playerName;
		if(_teamNumber != -1) then
		{
			_displayName = _teamNumber call DYN_RACE_GetTeamName;
		};
		
		_finished_players_time_array = _finished_players_time_array + [format["-: %1",  _displayName], "DNF"];
	};
} forEach DYN_RACE_RACERS;
_finished_players_time_array call BIS_fnc_alignTabs;