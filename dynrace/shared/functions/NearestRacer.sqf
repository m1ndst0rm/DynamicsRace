_pos = _this;

_nearestRacer = objNull;
{
	_racer = _x;
	_vehicle = _x select 2;
	if(isNull _nearestRacer) then
	{
		_nearestRacer = _vehicle;
	};
	if((_vehicle distance _pos) < _nearestRacer distance _pos) then
	{
		_nearestRacer = _vehicle;
	};
} foreach DYN_RACE_RACERS;
_nearestRacer;