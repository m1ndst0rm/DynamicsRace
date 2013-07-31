_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_class = _this select 1;
_time = _this select 2;

_grp = createGroup east;	       
_unit = _grp createunit [ _class , _pos, [], 0, "None"]; 

 _nearest_racer = _pos call DYN_RACE_NearestRacer;
 
 //Let the spawned unit face the closest racer
 if !(isNull _nearest_racer) then
 {
	_pos2 = position _nearest_racer;
	_newDir = ((((_pos select 0) - (_pos2 select 0)) atan2 ((_pos select 1) - (_pos2 select 1))) + 360) % 360;
	_unit setDir _newDir;
};

[] call DYN_RACE_SPEC_DisableSpectator;

_player = player;

selectPlayer _unit;

sleep _time - 5;
for [{_i = 5},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.4'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	sleep 1;
};

[] call DYN_RACE_SPEC_EnableSpectator;
selectPlayer _player;