/*
	Author: M1nd0
	Part of paradrop script used from: KillzoneKid
	Site: http://killzonekid.com/
	
	Description:
	Spawns a vehicle at a point with chutedrop

	Parameter(s):
	Param1: Position

	Returns:
*/
private ["_commander","_class","_time","_playerPos","_special","_vehicle","_nearest_racer","_pos2","_newDir","_handle","_i","_text"];
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_class = _this select 1;
_time = _this select 2;
_playerPos = _this select 3;

_special = "NONE";
if(_class isKindOf "Air") then
{
	_special = "FLY";
	_pos set [2, 100];
}
else
{//Paradrop height
	_pos set [2, 200];
};
_vehicle = createVehicle [_class, _pos, [], 0, _special];
_vehicle setPos (_pos);
_nearest_racer = _pos call DYN_fnc_NearestRacer;
 
 //Let the spawned unit face the closest racer
 if !(isNull _nearest_racer) then
 {
	_pos2 = position _nearest_racer;
	_newDir = ((((_pos select 0) - (_pos2 select 0)) atan2 ((_pos select 1) - (_pos2 select 1))) + 360) % 360;
	_vehicle setDir _newDir - 180;
};

if !(_class isKindOf "Air") then
{
	//Wait untill the vehicle has fallen quite a bit
	waitUntil {getPos _vehicle select 2 < 50};
	_class = "B_Parachute_02_F";
	_para = createVehicle [_class, [0,0,0], [], 0, "FLY"];
	_para setDir getDir _vehicle;
	_para setPos getPos _vehicle;
	_paras =  [_para];
	_vehicle attachTo [_para, [0,2,0]];
	{
		_p = createVehicle [_class, [0,0,0], [], 0, "FLY"];
		_paras set [count _paras, _p];
		_p attachTo [_para, [0,0,0]];
		_p setVectorUp _x;
	} count [
		[0.5,0.4,0.6],[-0.5,0.4,0.6],[0.5,-0.4,0.6],[-0.5,-0.4,0.6]
	];

	0 = [_vehicle, _paras] spawn {
		_veh = _this select 0;
		waitUntil {getPos _veh select 2 < 4};
		_vel = velocity _veh;
		detach _veh;
		_veh setVelocity _vel;
		playSound3D [
			"a3\sounds_f\weapons\Flare_Gun\flaregun_1_shoot.wss",
			_veh
		];
		{
			detach _x;
			_x disableCollisionWith _veh;   
		} count (_this select 1);
		_timeP = time + 5;
		waitUntil {time > _timeP};
		{
			if (!isNull _x) then {deleteVehicle _x};
		} count (_this select 1);
	};
};	
_handle = [false] spawn DYN_fnc_DisableSpectator;
titleCut ["", "BLACK OUT", 1];
waitUntil {scriptDone _handle};
switch (_playerPos) do
{
	case "DRIVER":
	{
		player moveInDriver _vehicle;
	};
	case "GUNNER":
	{
		player moveInGunner _vehicle;
	};
};
titleCut ["", "BLACK IN", 1];
sleep _time - 5;
for [{_i = 5},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.4'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	sleep 1;
};
[false] call DYN_fnc_EnableSpectator;
//waitUntil {scriptDone _handle};
moveOut player;
sleep 0.1;
_pos = [(getMarkerPos "DYN_RACE_Respawn"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
player setPos _pos;
//? OR deleteVehicle 
deleteVehicle _vehicle;