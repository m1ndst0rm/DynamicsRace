/* DYN_RACE_DamageEnabled: Change the damage state of all players or vehicles
 * 
 * Enable or disable damage vehicles or drivers. 
 * 
 * [_type, _damageEnabled] call DYN_RACE_DamageEnabled;
 * 
 * Parameters:
 * 	_type: "PLAYER" or "VEHICLE"
 * 	_damageEnabled: bool respresenting if the unit should recieve damage
 * 	
 */
DYN_RACE_DamageEnabled = 
{
	"DYN_RACE_DamageEnabled" call DYN_RACE_Debug;
	_type = _this select 0;
	_damageEnabled = _this select 1;
	_racers_count = count DYN_RACE_RACERS;
	for [ {_i = 0}, {_i < _racers_count}, {_i = _i + 1}] do
	{
		_racer = DYN_RACE_RACERS select _i;
		switch (_type) do
		{
			case "PLAYER":
			{
				_racer set [3, _damageEnabled];
			};
			case "VEHICLE":
			{
				_racer set [4, _damageEnabled];
			};
		};
		DYN_RACE_RACERS set [_i, _racer];
	};

	publicVariable "DYN_RACE_RACERS";
	[] call DYN_RACE_OnRacersChanged;
};