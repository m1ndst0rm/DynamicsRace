/* DYN_fnc_SetVehicleDamageHandler: 

*/
private ["_unit","_multiplication","_selections","_gethit","_selection","_i","_olddamage","_damage"];
_unit = _this select 0;
_unit setVariable ["selections", []];
_unit setVariable ["gethit", []];
_unit setVariable ["damageMultiplication", _this select 1];
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
		
		_maxDamage = 0.9;
		switch (_selection) do
		{
			case "HitLFWheel": { _maxDamage = 1};
			case "HitLF2Wheel": { _maxDamage = 1};
			case "HitRFWheel": { _maxDamage = 1};
			case "HitRF2Wheel": { _maxDamage = 1};
			
			case "HitRBWheel": { _maxDamage = 1};
			case "HitLBWheel": { _maxDamage = 1};
			
			case "HitReserveWheel": { _maxDamage = 1};

			case "HitFuel": { _maxDamage = 0.9};
			case "HitEngine": { _maxDamage = 0.9};
			case "HitEngine2": { _maxDamage = 0.9};
			case "HitEngine3": { _maxDamage = 0.9};
			case "HitBody": { _maxDamage = 0.9};
			case "HitHull": { _maxDamage = 0.9};
			 
			case "HitTransmission": { _maxDamage = 0.9}; 
			case "HitHydraulics": { _maxDamage = 0.9}; 
			case "HitTransmission": { _maxDamage = 0.9}; 
			
			case "HitLight ": { _maxDamage = 1}; 
			case "Light_R ": { _maxDamage = 1}; 
			case "Light_R2 ": { _maxDamage = 1}; 
			case "Light_L ": { _maxDamage = 1}; 
			case "Light_L2 ": { _maxDamage = 1}; 
			
			case "HitGlass1": { _maxDamage = 1};
			case "HitGlass2": { _maxDamage = 1};
			case "HitGlass3": { _maxDamage = 1};
			case "HitGlass4": { _maxDamage = 1};
			case "HitGlass5": { _maxDamage = 1};
			case "HitGlass6": { _maxDamage = 1};
			case "HitRGlass": { _maxDamage = 1};
			case "HitLGlass": { _maxDamage = 1};
		};
		_inflictedDamage= ((_this select 2) - _olddamage) * (_unit getVariable "damageMultiplication");
		_damage = _olddamage + _inflictedDamage;

		if(_damage > _maxDamage) then
		{
			_damage = _maxDamage;
		};
		_gethit set [_i, _damage];
		_damage;
	}
];