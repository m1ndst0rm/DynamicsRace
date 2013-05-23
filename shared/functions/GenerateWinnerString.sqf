/* DYN_RACE_GenerateWinnerString: returns a string containing the winners of the current race.
* Will be reset once a new race is started. 
*
* Returns:
* string _winners: String containing winners seperated with a newline (<br />).
*/
DYN_RACE_GenerateWinnerString =
{
	_message = "";
	_finished_players = call DYN_RACE_GetFinishedPlayers;
	_i = 1;
	_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
	
	_lengthLongestName = 0;
	{
		_player = _x;
		_playerName = name _player;
		_playerNameLength = count (toArray _playerName);
		if(_playerNameLength > _lengthLongestName) then
		{
			_lengthLongestName = _playerNameLength;
		};
	} forEach _units;
	
	{
		_racer = _x;
		_playerName = _racer select 0;
		
		_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
		_formatted_time = [_finish_time] call DYN_RACE_FormatTime;
		
		_spaces = "";
		_playerNameLength = count (toArray _playerName);
		if(_playerNameLength < _lengthLongestName) then
		{
			for [ {_j = 0}, {_j < (_lengthLongestName - _playerNameLength)}, {_j = _j + 1}] do
			{
				_spaces = _spaces + " ";
			};
		};
		
		_message = _message + format["%1: %2 %4- %3<br />", _i, _playerName, _formatted_time, _spaces];
		
		_i = _i + 1;
	} forEach _finished_players;
	
	{
		_racer = _x;
		_hasFinished = false;
		{
			_finished_racer = _x;
			if(_racer select 1 == _finished_racer select 1) then
			{
				_hasFinished = true;
			};
		} forEach _finished_players;
		
		
		if !(_hasFinished) then
		{
			_playerName = _racer select 0;
			
			_spaces = "";
			_playerNameLength = count (toArray _playerName);
			if(_playerNameLength < _lengthLongestName) then
			{
				for [ {_j = 0}, {_j < (_lengthLongestName - _playerNameLength)}, {_j = _j + 1}] do
				{
					_spaces = _spaces + " ";
				};
			};
			
			_message = _message + format["   %1%2 - Not finished<br />", _playerName, _spaces];
		};
	} forEach DYN_RACE_RACERS;
	_message;
};