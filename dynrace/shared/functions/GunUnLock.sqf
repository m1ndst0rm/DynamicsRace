/* DYN_RACE_GunUnLock: Unlocks the gunners gun of a single vehicle or a group.
* 
* Example1: _vehicle call DYN_RACE_GunUnLock;
* Example2: thislist call DYN_RACE_GunUnLock; //Trigger
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

if (_vehicle getVariable ["gunLocked", false]) then
{
	_magNames = _vehicle getVariable "magNames";
	_ammoLeft = _vehicle getVariable "lastMagCount";
	_magNamesCount = count _magNames;
	for [ {_i = 0}, {_i < (_magNamesCount)}, {_i = _i + 1}] do
	{
		_vehicle addMagazineTurret [_magNames select _i, [0]];
	};
	_lastNameInt = (count _magNames) - 1;

	_vehicle setAmmo [currentweapon _vehicle, _ammoLeft];
	_vehicle setVariable ["gunLocked", false, true];
};