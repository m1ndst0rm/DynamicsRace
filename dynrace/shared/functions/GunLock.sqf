/* DYN_RACE_GunLock: Lock the gunners gun of a single vehicle or a group.
* 
* Example1: _vehicle call DYN_RACE_GunLock;
* Example2: thislist call DYN_RACE_GunLock; //Trigger
*/
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
//Only "Lock" the gun if it's not yet locked (else the gun's ammo will be set to zero).
if !(_vehicle getVariable ["gunLocked", false]) then
{	
	_magNames = _vehicle magazinesTurret [0];
	_ammoLeft = (_vehicle ammo (currentWeapon _vehicle));
	_vehicle setVariable ["magNames", _magNames, true];	
	_vehicle setVariable ["lastMagCount", _ammoLeft, true];	
	_vehicle setVariable ["gunLocked", true, true];	
	_vehicle setVehicleAmmo 0;
	{
		_magName = _x;
		_vehicle removeMagazinesTurret [_magName,[0]]; 
	} forEach _magNames;
};