private ["_allMarkersFound","_i","_marker_name","_checkpoint","_taskname","_checkpointTask","_tArea","_y","_angle","_isRectangle","_tPos","_tPosX","_tPosY","_markerstr"];
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
		if(isServer) then
		{
			if(DYN_RACE_LAPS != 1 || (DYN_RACE_LAPS == 1 && _i > 1)) then
			{
				_vehicle = createVehicle ["Sign_Circle_F", _pos, [], 0, "CAN_COLLIDE"]; 
				_vehicle setPos _pos;
				_vehicle setDir (markerDir _marker_name);
			};
		};
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
	if(DYN_RACE_LAPS == 1) then
	{
		_i = 0;
	};
	
	{
		_checkpoint = _x;
		_taskname = format["Checkpoint: %1",_i]; 
		_checkpointTask = player createSimpleTask [_taskname];
		_checkpointTask setSimpleTaskDestination (getMarkerPos _checkpoint);
		_i = _i + 1;
	} forEach DYN_RACE_CHECKPOINTS;
};
_tArea = triggerArea DYN_RACE_FINISHTRIGGER;
_width = _tArea select 0;
_height = _tArea select 1;
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
	if(isServer) then
	{
		_finishX  = _tPosX +  (_width * sin(_angle - 180));
		_finishY  = _tPosY + (_width * cos(_angle - 180));
		_finish = createVehicle ["Land_FinishGate_01_wide_F", [_finishX, _finishY, 0], [], 0, "NO_COLLIDE"]; 
		_finish setPos [_finishX, _finishY, 0];
		_finish setDir _angle;
	};
}
else
{
	["The finish line trigger must be a retangle."] call BIS_fnc_error;
};