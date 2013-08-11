_type = _this select 0; //Car, Air
_onlyUnArmed = _this select 1;

_root = configFile >> "CfgVehicles";
_rootCount = count _root;
_foundClasses = [];
for "_i" from 0 to _rootCount - 1 do
{
	_obj = _root select _i;
	if(isClass _obj) then
	{
		_className = configName _obj;
		
		if(_className isKindOf _type) then
		{
			_scope = getNumber (configFile >> "CfgVehicles" >> _className >> "scope");
			//2 = public, eg allowed vehicles
			if(_scope == 2) then
			{
				
				_turrets = getArray (configFile >> "CfgVehicles" >> _className >> "Turrets" >> "MainTurret" >> "weapons");
				
				if(count _turrets > 0 && !_onlyUnArmed) then
				{
					_foundClasses set [count _foundClasses, _className];
				};
				
				if(count _turrets == 0 && _onlyUnArmed) then
				{
					_foundClasses set [count _foundClasses, _className];
				};
			};
		};
	};
};
_foundClasses;