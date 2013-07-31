_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_class = _this select 1;
_time = _this select 2;
_playerPos = _this select 3;

_special = "NONE";
if(_class isKindOf "Air") then
{
	_special = "FLY";
};
_vehicle = createVehicle [_class, _pos, [], 0, _special];
//_vehicle setPos (_pos);
 _nearest_racer = _pos call DYN_RACE_NearestRacer;
 
 //Let the spawned unit face the closest racer
 if !(isNull _nearest_racer) then
 {
	_pos2 = position _nearest_racer;
	_newDir = ((((_pos select 0) - (_pos2 select 0)) atan2 ((_pos select 1) - (_pos2 select 1))) + 360) % 360;
	_vehicle setDir _newDir;
};
_vehicle enableSimulation false;
[] call DYN_RACE_SPEC_DisableSpectator;
sleep 0.2;
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
sleep 0.2;
_vehicle enableSimulation true;
sleep _time - 5;
for [{_i = 5},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.4'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	sleep 1;
};
[] call DYN_RACE_SPEC_EnableSpectator;
sleep 0.2;
moveOut player;
sleep 0.1;
_vehicle setDamage 1;
_pos = [(getMarkerPos "respawn_west"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
player setPos _pos;