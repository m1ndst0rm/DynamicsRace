/* DYN_RACE_VehicleDamageHandler: 

*/
DYN_RACE_VehicleDamageHandler =
{
	_unit = _this select 0;
	_multiplication = _this select 1;
	_unit setVariable ["selections", []];
	_unit setVariable ["gethit", []];
	_unit addEventHandler
	[
		"HandleDamage",
		{
			_unit = _this select 0;
			_selections = _unit getVariable ["selections", []];
			_gethit = _unit getVariable ["gethit", []];
			_selection = _this select 1;
			if !(_selection in _selections) then
			{
				_selections set [count _selections, _selection];
				_gethit set [count _gethit, 0];
			};
			_i = _selections find _selection;
			_olddamage = _gethit select _i;
			_damage = _olddamage + ((_this select 2) - _olddamage) * _multiplication;
			_gethit set [_i, _damage];
			_damage;
		}
	];
};