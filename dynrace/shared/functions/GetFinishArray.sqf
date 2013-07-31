/*Returns array with all players/taems with finishs tatus
*[["Name","FinishTime", Did finish],...]
*
*	Param1 (optional): format option
*			-0: Team 1: Player1, Player2, ....
*			-1: Team 1
*			-2: T1: Player1, Player2,...
*			-3: T1
*/
_finished_players = call DYN_RACE_GetFinishedPlayers;
_finished_players_array = [];

_formatOption = 0;
if(count _this > 0) then
{
	_formatOption = _this select 0;
};

{
	_racer = _x;
	
	_playerName = _racer select 0;
	_player = _racer select 1;
	
	_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
	_formatted_time = [_finish_time] call DYN_RACE_FormatTime;
	
	_teamNumber = _player getVariable ["teamNumber", -1];
	
	_displayName = _playerName;
	if(DYN_RACE_TYPE != "SINGLE") then
	{
		_displayName = [_teamNumber, _formatOption] call DYN_RACE_GetTeamName;
	};
	
	_finished_players_array set [count _finished_players_array, [_displayName, _formatted_time, true, _teamNumber]];
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

	if (!_hasFinished && _player getVariable["isDriver", false] && !(_player getVariable["isCat", false]) && !(_player getVariable["isCop", false])) then
	{
		_playerName = _racer select 0;

		_teamNumber = _player getVariable ["teamNumber", -1];
	
		_displayName = _playerName;
		if(DYN_RACE_TYPE != "SINGLE") then
		{
			_displayName =  [_teamNumber, _formatOption] call DYN_RACE_GetTeamName;
		};
		
		_text = "DNF";

		if(_player getVariable ["isCaught", false]) then
		{
			_text = "Arrested";
		};
		
		_finished_players_array set [count _finished_players_array, [_displayName, _text, false, _teamNumber]];
	};
} forEach DYN_RACE_RACERS;

_finished_players_array;