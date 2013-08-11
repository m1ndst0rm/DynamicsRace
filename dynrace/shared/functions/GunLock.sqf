/* DYN_fnc_GunLock: Lock the gunners gun of a single vehicle or a group.
* 
* Example1: _vehicle call DYN_fnc_GunLock;
* Example2: thislist call DYN_fnc_GunLock; //Trigger
*/
private ["_vehicle","_magNames","_ammoLeft","_magName"];
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
	_magazineInfo = magazinesAmmoFull _vehicle;

	_vehicle setVariable ["magazineInfo", _magazineInfo, true];
	_vehicle setVariable ["gunLocked", true, true];	
	
	_vehicle setVehicleAmmo 0;
	{
		_magName = _x;
		_vehicle removeMagazinesTurret [_magName select 0,[0]]; 
	} forEach _magazineInfo;
};