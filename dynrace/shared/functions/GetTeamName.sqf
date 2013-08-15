/* DYN_fnc_GetTeamName: return team name with format options
*	Param1: Teamno, team or player
*	Param2 (optional): format option
*			-0: Team 1: Player1, Player2, ....
*			-1: Team 1 || Playername in racetype SINGLE
*			-2: T1: Player1, Player2,...
*			-3: T1
*
*/
private ["_p0","_team","_teamNo","_formatOption","_teamName","_playerNames","_players","_playersCount","_i","_player"];
_p0 = _this select 0;
_formatOption = [_this, 1, 0] call bis_fnc_param;

_team = objNull;
_teamNo = -1;
if(typeName _p0 == "ARRAY") then
{
	_team = _p0;
	_teamNo = DYN_RACE_TEAMS find _team;
}
else
{
	if(typeName _p0 == "SCALAR") then
	{
		_team = DYN_RACE_TEAMS select _p0;
		_teamNo = _p0;
	}
	else
	{
		_teamNo = (_p0 getVariable "teamNumber");
		_team = DYN_RACE_TEAMS select _teamNo;
	};
};

_teamName = "";
if(_formatOption < 2) then
{
	if(DYN_RACE_TYPE == "CAT&MOUSE" || DYN_RACE_TYPE == "SINGLE") then
	{
		_teamName = _team select 0;
	}
	else
	{
		_teamName = format ["Team %1", _teamNo + 1];
	};
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