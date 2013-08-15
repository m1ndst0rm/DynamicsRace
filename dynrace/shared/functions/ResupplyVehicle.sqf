private ["_magNames","_vehicle","_magNamesCount","_i"];
_vehicle = vehicle player;
_magazineInfo = _vehicle getVariable ["defaultMagazineInfo",[]];
{	
	_magazine = _x;
	
	_loaded = false;//_magazine select 2;
	if(_loaded) then
	{
		_ammoLeft = _magazine select 1;
		_vehicle setAmmo [currentweapon _vehicle, _ammoLeft];
	}
	else
	{
		_magName = _magazine select 0;
		_vehicle addMagazineTurret [_magName, [0]];
	};
} foreach _magazineInfo;