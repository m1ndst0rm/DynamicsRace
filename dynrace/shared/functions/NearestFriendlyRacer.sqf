_commander = _this select 0;
_pos = _this select 1;

_nearestRacer = objNull;
{
	_racer = _x;
	_player = _racer select 1;
	_vehicle = _racer select 2;
	
	_sameTeam = false;
	
	if ((_player getVariable ["teamNumber", -1] == _commader getVariable ["teamNumber", 0])
	|| _player getVariable ["isCop", false]) then
	{
		_sameTeam = true;
	};
	
	if(_sameTeam) then
	{
		if(isNull _nearestRacer) then
		{
			_nearestRacer = _vehicle;
		};
		if((_vehicle distance _pos) < _nearestRacer distance _pos) then
		{
			_nearestRacer = _vehicle;
		};
	};
} foreach DYN_RACE_RACERS;
_nearestRacer;