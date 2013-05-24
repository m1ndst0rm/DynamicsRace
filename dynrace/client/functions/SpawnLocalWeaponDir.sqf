WEAPON_DIR_CHECK = 0.5;
DYN_RACE_SpawnLocalWeaponDir =
{
	"DYN_RACE_SpawnLocalWeaponDir" call DYN_RACE_Debug;
	[] spawn {
		DYN_RACE_VEHICLE_WEAPON_ALLOWED = true;
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			//diag_log "Checking weapons";
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
							_magNames = _vehicle magazinesTurret [0];
							_ammoLeft = (vehicle player ammo (currentWeapon vehicle player));
							diag_log format["Ammoleft: %1", _ammoLeft];
							_vehicle setVariable ["magNames", _magNames, true];	
							_vehicle setVariable ["lastMagCount", _ammoLeft, true];	
							
							_vehicle setVehicleAmmo 0;
							
							{
								_magName = _x;
								_vehicle removeMagazinesTurret [_magName,[0]]; 
							} forEach _magNames;
							
						};
					}
					else
					{
						if!(DYN_RACE_VEHICLE_WEAPON_ALLOWED) then
						{
							_magNames = _vehicle getVariable "magNames";
							_ammoLeft = _vehicle getVariable "lastMagCount";
							_magNamesCount = count _magNames;
							for [ {_i = 0}, {_i < (_magNamesCount)}, {_i = _i + 1}] do
							{
								_vehicle addMagazineTurret [_magNames select _i, [0]];
							};
							_lastNameInt = (count _magNames) - 1;
							
							(vehicle player) setAmmo [currentweapon (vehicle player), _ammoLeft];
							DYN_RACE_VEHICLE_WEAPON_ALLOWED = true;
						};
					};
				};
			};
			sleep WEAPON_DIR_CHECK;
		};
	};	
};