DYN_RACE_CHECKPOINTS = [];
_allMarkersFound = false;
_i = 6;
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


if!(isDedicated) then
{
	_i = 1;
	{
		_checkpoint = _x;
		_taskname = format["Checkpoint: %1",_i]; 
		_checkpointTask = player createSimpleTask [_taskname];
		_checkpointTask setSimpleTaskDestination (getMarkerPos _checkpoint);
		_i = _i + 1;
	} forEach DYN_RACE_CHECKPOINTS;
};
_tArea = triggerArea DYN_RACE_FINISHTRIGGER;
_x = _tArea select 0;
_y = _tArea select 1;
_angle = _tArea select 2;
_isRectangle = _tArea select 3;

if(_isRectangle) then
{
	_tPos = [DYN_RACE_FINISHTRIGGER,0,[0,0,0],[[],objnull]] call bis_fnc_paramin;
	if (typename _tPos == typename objnull) then {_tPos = position _tPos};
	_tPos resize 2;
	_tPosX = [_tPos,0,0,[0]] call bis_fnc_paramin;
	_tPosY = [_tPos,1,0,[0]] call bis_fnc_paramin;
	
	_markerstr = createMarkerLocal["Finish",_tPos];
	_markerstr setMarkerShapeLocal "ICON";
	_markerstr setMarkerTypeLocal "Empty";
	
	DYN_RACE_CHECKPOINTS set [count DYN_RACE_CHECKPOINTS, "Finish"];
	if!(isDedicated) then
	{
		_checkpointTask = player createSimpleTask ["Finish"];
		_checkpointTask setSimpleTaskDestination _tPos;
	};
}
else
{
	if!(isDedicated) then
	{
		hintC "Finish triger must be a rectangle.";
	}
	else
	{
		diag_log "!!!WARNING:FINISH LINE TRIGER MUST BE RACTANGLE!!!";
	};
};