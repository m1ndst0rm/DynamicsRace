/* DYN_RACE_OnRacersChanged: Function called when var DYN_RACE_RACERS is changed.
* This function updates all racers client and server sided.
* Will:
* Move player in vehicle client sided (because server cannot move player in vehicle)
* Update vehicle damageEnabled, player damageEnabled.
* Enable or disable simulation on a vehicle (preventing it from moving)
*/
DYN_RACE_OnRacersChanged =
{
	"DYN_RACE_OnRacersChanged" call DYN_RACE_Debug;
	//Update local racer settings. 
	_local_racers = DYN_RACE_RACERS;
	{
		//[playerName, netId player, netId vehicle, playerAllowDamage, vehicleAllowDamage, vehicleEnableSimulation, laptimes[lap,time]];
		_racer = _x;
		_player_netId = _racer select 1;
		_vehicle_netId = _racer select 2;
		_playerAllowDamage = _racer select 3;
		_vehicleAllowDamage = _racer select 4;
		_vehicleEnableSimulation = _racer select 5;
		
		_player = [_player_netId] call DYN_RACE_FindLocalPlayer;
		//diag_log format["UnitId: %1. Car id:%2", _player_netId, _vehicle_netId];
		
		//format ["Checking player_netId: %1. VehicleId: %2", _player_netId, _vehicle_netId] call DYN_RACE_Debug;
		if !(isNull _player) then
		{
			//_player allowDamage _playerAllowDamage;
			
			_playing_player_netId = [player] call DYN_RACE_GetObjectID;
			if (_player_netId == _playing_player_netId && (vehicle player == player)) then
			{
				player setVariable ["vehicleId", _vehicle_netId]; 
				_createSmokeAction = false;
				cutText  ["", "BLACK OUT", 1];
				sleep 1;
				_vehicle = [_vehicle_netId] call DYN_RACE_FindLocalVehicle;
				
				if(isNull (driver _vehicle)) then
				{
					player moveInDriver _vehicle;
					if(DYN_RACE_TYPE == "SINGLE") then
					{
						_createSmokeAction = true;
					};
				}
				else
				{
					player moveInGunner _vehicle;
					_createSmokeAction = true;
				};
							
				if(_createSmokeAction) then
				{
					_vehicle = vehicle player;
					DYN_RACE_LOCAL_SMOKE_ACTION = _vehicle addAction [format ["Deploy smokescreen (%1 left)",DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT], "dynrace\client\functions\CreateSmokeScreen.sqf",[], 0, false];
				};
				cutText  ["", "BLACK IN", 2];
			};
			
			if (vehicle _player != _player) then
			{
				if(DYN_RACE_TYPE == "DUAL") then
				{
					(vehicle _player) allowDamage true;
				}
				else
				{
					(vehicle _player) allowDamage _vehicleAllowDamage;
				};
				
				_fuel = (if (_vehicleEnableSimulation) then {1} else {0});
				(vehicle _player) setFuel _fuel;
				//(vehicle _player) addEventHandler ["HandleDamage", {_this call DYN_RACE_OnVehicleDamage}];
				(vehicle _player) addEventHandler ["HandleDamage", {_this call DYN_RACE_OnVehicleHit}];
			};
		};
	} forEach _local_racers;
};