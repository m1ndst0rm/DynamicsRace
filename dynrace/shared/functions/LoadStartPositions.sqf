"DYN_fnc_LoadStartPositions" call BIS_fnc_log;
private ["_allMarkersFound","_i","_marker_name"];

DYN_RACE_START_POSITIONS = [];
_allMarkersFound = false;
_i = 1;
while { !(_allMarkersFound) } do
{
	_marker_name = format ["start_position_%1", _i];
	_pos = getMarkerPos _marker_name;
	
	if((_pos select 0 != 0) && (_pos select 1 != 0)) then
	{
		DYN_RACE_START_POSITIONS set [count DYN_RACE_START_POSITIONS, _marker_name];	
	}
	else
	{
		_allMarkersFound = true;
	};
	
	_i = _i + 1;
};