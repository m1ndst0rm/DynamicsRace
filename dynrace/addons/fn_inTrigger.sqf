//scriptName "Functions\misc\fn_inTrigger.sqf";
/*
	File: inTrigger.sqf
	Author: Karel Moricky

	Description:
	Detects whether is position within trigger area.

	Parameter(s):
		_this select 0: OBJECT or ARRAY - Trigger or trigger area
		_this select 1: ARRAY or OBJECT - Position
		_this select 2 (Optional): BOOL - true for scalar result (distance from border)

	Returns:
	Boolean (true when position is in area, false if not).
*/
private ["_trig","_position","_scalarresult","_tPos","_tPosX","_tPosY","_tArea","_tX","_tY","_tDir","_tShape","_in"];

_trig =		[_this,0,objnull,[objnull,[],""]] call bis_fnc_param;
_position =	[_this,1,[0,0,0]] call bis_fnc_param;
_scalarresult =	[_this,2,false,[false]] call bis_fnc_param;

if (typename _trig == typename objnull) then {
	if (_trig iskindof "emptydetector") then {_trig = [position _trig,triggerarea _trig];} else {_scalarresult = 0;};
};
if (typename _scalarresult == typename 00) exitwith {["%1 is not a trigger",_trig] call bis_fnc_error; false};
if (typename _trig == typename "") then {_trig = [markerpos _trig,markersize _trig + [markerdir _trig,markershape _trig == "rectangle"]]};

//--- Trigger position
_position = _position call bis_fnc_position;
_position resize 2;
_tPos = [_trig,0,[0,0,0],[[],objnull]] call bis_fnc_paramin;
if (typename _tPos == typename objnull) then {_tPos = position _tPos};
_tPos resize 2;
_tPosX = [_tPos,0,0,[0]] call bis_fnc_paramin;
_tPosY = [_tPos,1,0,[0]] call bis_fnc_paramin;

if (_position distance [_tPosX,_tPosY] == 0) then {["Compared positions '%1' and '%2' cannot be the same.",_position,_trig] call bis_fnc_error; _tPosY = _tPosY + 0.01;};

//--- Trigger area
_tArea = [_trig,1,0,[[],0]] call bis_fnc_paramin;
if (typename _tArea == typename 0) then {_tArea = [_tArea,_tArea,0,false]};
_tX = [_tarea,0,0,[0]] call bis_fnc_paramin;
_tY = [_tarea,1,0,[0]] call bis_fnc_paramin;
_tDir = [_tarea,2,0,[0]] call bis_fnc_paramin;
_tShape = [_tarea,3,false,[false]] call bis_fnc_paramin;

_in = false;
if (_tshape) then {
	private ["_difX","_difY","_dir","_relativeDir","_adis","_bdis","_borderdis","_positiondis"];

	//--- RECTANGLE
	_difx = (_position select 0) - _tPosx;
	_dify = (_position select 1) - _tPosy;
	_dir = atan (_difx / _dify);
	if (_dify < 0) then {_dir = _dir + 180};
	_relativedir = _tdir - _dir;
	_adis = abs (_tx / cos (90 - _relativedir));
	_bdis = abs (_ty / cos _relativedir);
	_borderdis = _adis min _bdis;
	_positiondis = _position distance _tPos;

	_in = if (_scalarresult) then {
		_positiondis - _borderdis;
	} else {
		if (_positiondis < _borderdis) then {true} else {false};
	};

} else {
	private ["_e","_posF1","_posF2","_total","_dis1","_dis2"];

	//--- ELLIPSE
	_e = sqrt(_tx^2 - _ty^2);
	_posF1 = [_tPosx + (sin (_tdir+90) * _e),_tPosy + (cos (_tdir+90) * _e)];
	_posF2 = [_tPosx - (sin (_tdir+90) * _e),_tPosy - (cos (_tdir+90) * _e)];
	_posF1 resize 2;
	_posF2 resize 2;
	_total = 2 * _tx;

	_dis1 = _position distance _posF1;
	_dis2 = _position distance _posF2;
	_in = if (_scalarresult) then {
		(_dis1+_dis2) - _total;
	} else {
		if (_dis1+_dis2 < _total) then {true} else {false};
	};
};

_in