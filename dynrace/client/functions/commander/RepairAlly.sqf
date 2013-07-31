//TODO: Friendly check
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_repairPercentage = _this select 1;

_vehicle = [player,_pos] call DYN_RACE_NearestFriendlyRacer;

_healFor = (1 - (100 / (_repairPercentage - 100)));
_damage = damage _vehicle;
_newDamage = _damage - _healFor;

if(_newDamage < 0)
{
	_newDamage = 0;
}
_vehicle setDamage _newDamage;