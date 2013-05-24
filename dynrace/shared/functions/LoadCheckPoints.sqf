DYN_RACE_CHECKPOINTS = [];
_allMarkersFound = false;
_i = 1;
while { !(_allMarkersFound) } do
{
	_marker_name = format ["DYN_Checkpoint_%1", _i];
	_pos = getMarkerPos _marker_name;
	
	if((_pos select 0 != 0) && (_pos select 1 != 0)) then
	{
		DYN_RACE_CHECKPOINTS set [count DYN_RACE_CHECKPOINTS, _marker_name];	
	}
	else
	{
		_allMarkersFound = true;
	};
	
	_i = _i + 1;
};