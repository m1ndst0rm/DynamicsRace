private ["_commander","_repairPercentage","_vehicle","_healFor","_damage","_newDamage"];

_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_repairPercentage = _this select 1;

_vehicle = [player,_pos] call DYN_fnc_NearestFriendlyRacer;

_healFor = _repairPercentage / 100;

_damage = damage _vehicle;
_newDamage = _damage - _healFor;

if(_newDamage < 0) then
{
	_newDamage = 0;
};
_vehicle setDamage _newDamage;

_text = "<t align='center' size='1.8'>Ally repaired!</t>";
[_text, -1, 0.05, 0.9, 0, 0, 11111] spawn BIS_fnc_dynamicText;