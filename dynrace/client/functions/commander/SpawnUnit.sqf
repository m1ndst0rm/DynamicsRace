private ["_commander","_class","_time","_grp","_handle","_unit","_nearest_racer","_pos2","_newDir","_player","_i","_text"];
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_class = _this select 1;
_time = _this select 2;
_weaponToSelect = [_this, 3, "primary"] call bis_fnc_param;

_grp = createGroup east;	    
_handle = [false] spawn DYN_fnc_DisableSpectator;   
_unit = _grp createunit [ _class , _pos, [], 0, "None"];

switch (_weaponToSelect) do
{
	case "secundary":
    {
        _unit selectWeapon (secondaryWeapon _unit);
    };
};

_unit enableSimulation false;
_nearest_racer = _pos call DYN_fnc_NearestRacer;
 
//Let the spawned unit face the closest racer
if !(isNull _nearest_racer) then
{
	_pos2 = position _nearest_racer;
	_newDir = ((((_pos select 0) - (_pos2 select 0)) atan2 ((_pos select 1) - (_pos2 select 1))) + 360) % 360;
	_unit setDir _newDir - 180;
};

_player = player;
_pos = [(getMarkerPos "DYN_RACE_Respawn"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
player setPos _pos;
_unit setVariable ["isCommander", true];
_unit setVariable ["teamNumber", player getVariable "teamNumber"];
waitUntil {scriptDone _handle};
selectPlayer _unit;
_unit enableSimulation true;
sleep _time - 5;
for [{_i = 5},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.4'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	sleep 1;
};

[false] call DYN_fnc_EnableSpectator;
selectPlayer _player;
deleteVehicle _unit;
_pos = [(getMarkerPos "DYN_RACE_Respawn"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
player setPos _pos;