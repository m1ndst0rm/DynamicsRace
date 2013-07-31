/* DYN_RACE_GetTeamName: return team name with format options
*	Param1: Teamno or team
*	Param2 (optional): format option
*			-0: Team 1: Player1, Player2, ....
*			-1: Team 1
*			-2: T1: Player1, Player2,...
*			-3: T1
*
*/
private ["_p0","_team","_teamNo","_formatOption","_teamName","_playerNames","_players","_playersCount","_i","_player"];
_p0= _this select 0;
_team = objNull;
_teamNo = -1;
if(typeName _p0 == "ARRAY") then
{
	_team = _p0;
	_teamNo = DYN_RACE_TEAMS find _team;
}
else
{
	_team = DYN_RACE_TEAMS select _p0;
	_teamNo = _p0;
};
_formatOption = 0;
if(count _this > 1) then
{
	_formatOption = _this select 1;
};

_teamName = "";
if(_formatOption < 2) then
{
	_teamName = format ["Team %1", _teamNo + 1];
}
else
{
	_teamName = format ["T%1", _teamNo + 1];
};

if(_formatOption == 0 || _formatOption == 2) then
{
	_playerNames = "";
	_players = _team select 2;
	_playersCount = count _players;
	_i= 0; for "_i" from 0 to (_playersCount - 1) do
	{
		_player = _players select _i;
		if(_i == _playersCount - 1) then
		{
			_playerNames = _playerNames + name _player;
		}
		else
		{
			_playerNames = format["%1%2, ", _playerNames, name _player];
		};
	};
	
	_teamName = format ["%1: %2", _teamName, _playerNames];
};
_teamName;