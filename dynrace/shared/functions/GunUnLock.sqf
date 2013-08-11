/* DYN_fnc_GunUnLock: Unlocks the gunners gun of a single vehicle or a group.
* 
* Example1: _vehicle call DYN_fnc_GunUnLock;
* Example2: thislist call DYN_fnc_GunUnLock; //Trigger
*/
private ["_vehicle","_magNames","_ammoLeft","_magNamesCount","_i","_lastNameInt"];

if(typeName _this == "ARRAY") then
{
	{
		if(driver _x == player) then
		{
			_vehicle = _x;
		};
	}foreach _this;
}
else
{
	_vehicle = _this;
};

if (_vehicle getVariable ["gunLocked", false]) then
{
	_magazineInfo = _vehicle getVariable "magazineInfo";
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
	_vehicle setVariable ["gunLocked", false, true];
};