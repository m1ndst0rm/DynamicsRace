private ["_commander","_duration","_intesity","_vehicle","_maxSpeed","_speed","_sleep","_velIncrease","_i","_diff","_vel","_dir","_dvelIncrease"];
//TODO: Fix it so it only works on friendly
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
_duration = _this select 1;
_intesity = _this select 2;

_vehicle = [player,_pos] call DYN_fnc_NearestFriendlyRacer;
if!(isNull _vehicle) then
{
	_maxSpeed = getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "maxSpeed");

	_speed = speed _vehicle;
	_sleep = 0.01;
	_velIncrease = (1) * _intesity;
	_to = _duration / _sleep;
	for [{_i=0},{_i <= _to},{_i=_i+1}] do 
	{
		_diff = 0.02;
		_vel = velocity _vehicle;
		_dir = getDir _vehicle;
		
		_dvelIncrease = _velIncrease - (_speed / (_maxSpeed min 130) * _velIncrease); 
		
		_vehicle setVelocity [(_vel select 0)+(sin _dir*_diff),(_vel select 1)+(cos _dir*_diff),(_vel select 2)];
		_speed = speed _vehicle;
		sleep _sleep;
	};
};