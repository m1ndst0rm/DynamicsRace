/* DYN_fnc_LoatStartPositions:  Gets al start positions either from excisting map markers or calculates them.
* Param1 (optional): Vehicle class in order to calculate distance between positions based on bounding box.
*
*/
"DYN_fnc_LoadStartPositions" call BIS_fnc_log;
private ["_vehicle","_allMarkersFound","_i","_marker_name","_angle","_lenBehind","_lenBetween","_vehicleClass","_start_pos","_bbr","_p1","_p2","_maxWidth","_maxLength","_newx","_newy","_nearRoads","_nearestRoad","_found","_connectedRoads","_x1","_y1","_x2","_y2","_marker_name1","_marker_name2"];

_vehicleClass = [_this, 0, DYN_RACE_ROBBER_CLASS] call BIS_fnc_param;

_pos_main = getMarkerPos "DYN_RACE_Start_Position";
if((_pos_main select 0 == 0) && (_pos_main select 1 == 0)) then
{//Read excisting map markers for start positions
	DYN_RACE_START_POSITIONS = [];
	_allMarkersFound = false;
	_i = 1;
	while { !(_allMarkersFound) } do
	{
		_marker_name = format ["DYN_RACE_Start_Position_%1", _i];
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
}
else
{ //Create dynamic start positions
	//clear excising markers
	{
		deleteMarkerLocal _x;
	} forEach DYN_RACE_START_POSITIONS;
	DYN_RACE_START_POSITIONS = [];
	

	_pos = getMarkerPos "DYN_RACE_Start_Position";
	_currentFacing = markerDir "DYN_RACE_Start_Position";

	_vehicle = createVehicle [_vehicleClass, _pos, [], 0, "NONE"];
	_bbr = boundingBoxReal _vehicle;
	_vehicle setDir markerDir "DYN_RACE_Start_Position";
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));
	
	_dirV = vectorDir _vehicle;
	
	deleteVehicle _vehicle;
	_lenBehind = _maxLength + 2;
	_lenBetween = (_maxWidth / 2) + 0.5;
	
	for "_i" from 1 to 64 step 2 do 
	{
		//Calculate new position behind current position

		_newx = (_pos select 0) - (_lenBehind * sin(_currentFacing));
		_newy = (_pos select 1) - (_lenBehind * cos(_currentFacing));
				
		if(DYN_RACE_MUST_STAY_ON_ROAD) then
		{ //Place the new pos on center of the road
			if (isOnRoad [_newx, _newy]) then
			{//Only check this if the pos x meters behind last pos is already on road. Else it's pretty safe to assume the road ended.
				_leftP = [_newx, _newy];
				_rightP = [_newx, _newy];
				
				//Sideamount is for crossings (else the while could go on really really long)
				_sideAmount = 0;
				while {isOnRoad _leftP && _sideAmount < 10} do
				{
					_leftP set [0, (_leftP select 0) + (1 * sin(_currentFacing - 90))];
					_leftP set [1, (_leftP select 1) + (1 * cos(_currentFacing - 90))];
					_sideAmount = _sideAmount + 1;
				};
				
				_sideAmount = 0;
				while {isOnRoad _rightP && _sideAmount < 10} do
				{
					_rightP set [0, (_rightP select 0) + (1 * sin(_currentFacing + 90))];
					_rightP set [1, (_rightP select 1) + (1 * cos(_currentFacing + 90))];
					_sideAmount = _sideAmount + 1;
				};
				
				_newx = ((_leftP select 0) + (_rightP select 0)) / 2;
				_newy = ((_leftP select 1) + (_rightP select 1)) / 2;
			};
			_oldFacing =_currentFacing;
			_currentFacing = ((((_pos select 0) - _newx) atan2 ((_pos select 1) - _newy)) + 360) % 360;
		};
		_x1 = _newx + (_lenBetween * sin(_currentFacing + 90)); 
		_y1 = _newy + (_lenBetween * cos(_currentFacing + 90)); 
		_x2 = _newx + (_lenBetween * sin(_currentFacing - 90)); 
		_y2 = _newy + (_lenBetween * cos(_currentFacing - 90)); 
		
		_marker_name1 = format ["DYN_RACE_Start_Position_%1", _i];
		_marker_name2 = format ["DYN_RACE_Start_Position_%1", _i + 1];
		
		createMarkerLocal [_marker_name1, [_x1,_y1]];
		createMarkerLocal [_marker_name2, [_x2,_y2]];
		
		_marker_name1 setMarkerDirLocal _currentFacing;
		_marker_name2 setMarkerDirLocal _currentFacing;
		
		//"Sign_Arrow_Large_Green_F" createVehicleLocal [_x1,_y1];
		//"Sign_Arrow_Large_Green_F" createVehicleLocal [_x2,_y2];
		
		DYN_RACE_START_POSITIONS set [count DYN_RACE_START_POSITIONS, _marker_name1];	
		DYN_RACE_START_POSITIONS set [count DYN_RACE_START_POSITIONS, _marker_name2];	
		
		_pos set [0, _newx];
		_pos set [1, _newy];
		
	};
};