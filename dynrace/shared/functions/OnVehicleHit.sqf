//TODO: Eval
_vehicle = _this select 0;
_selectionName = _this select 1;
_damage = _this select 2;
_source = _this select 3;

//TODO: Implement source check so it doesn't break for bumps and other stupid things

if(DYN_RACE_DAMAGE_ENABLED) then
{
	_damage = _damage / 2;
}
else
{
	_damage = 0;
	if(speed _vehicle > 50) then
	{
		_diff = _damage;
		_vel = velocity _vehicle;
		_dir = getDir _vehicle;
		_vehicle setVelocity [(_vel select 0)-(sin _dir*_diff),(_vel select 1)-(cos _dir*_diff),(_vel select 2)];
	};
};

if(((damage _vehicle) + _damage) >= 1) then
{ //We don't want the vehicle to be destroyed.
	_damage = 0;
};

_damage;