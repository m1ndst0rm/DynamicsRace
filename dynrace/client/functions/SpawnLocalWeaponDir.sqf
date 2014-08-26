#define WEAPON_DIR_CHECK 0.5
private ["_vehicle","_vehicleDir","_weapondirarray","_weaponDirection","_minAllowedDirection","_maxAllowedDirection"];

"DYN_fnc_SpawnLocalWeaponDir" call BIS_fnc_Log;
[] spawn {
	DYN_RACE_VEHICLE_WEAPON_ALLOWED = true;
	while{ (DYN_RACE_STATE == "ONGOING" && DYN_CAN_SHOOT_BACKWARDS == 0) } do 
	{
		if(vehicle player != player) then
		{
			_vehicle = vehicle player;
			if(player == gunner _vehicle) then
			{
				_vehicleDir = getDir _vehicle;
				_weapondirarray = _vehicle weaponDirection (primaryWeapon _vehicle);
				_weaponDirection = (_weapondirarray select 0) atan2 (_weapondirarray select 1);
				if(_weaponDirection < 0) then { _weaponDirection = _weaponDirection + 360; };
				
				_minAllowedDirection = _vehicleDir - 90;
				_maxAllowedDirection = _vehicleDir + 90;
				if(_weaponDirection < _minAllowedDirection || _weaponDirection > _maxAllowedDirection) then
				{
					if(DYN_RACE_VEHICLE_WEAPON_ALLOWED) then
					{
						DYN_RACE_VEHICLE_WEAPON_ALLOWED = false;
						
						_vehicle call DYN_fnc_GunLock;
					};
				}
				else
				{
					if!(DYN_RACE_VEHICLE_WEAPON_ALLOWED) then
					{
						_vehicle call DYN_fnc_GunUnLock;
						DYN_RACE_VEHICLE_WEAPON_ALLOWED = true;
					};
				};
			};
		};
		sleep WEAPON_DIR_CHECK;
	};
};	