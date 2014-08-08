_type = _this select 0; //Car, Air
_onlyUnArmed = _this select 1;

_root = configFile >> "CfgVehicles";
_rootCount = count _root;
_foundClasses = [];
_foundVehicleNames = [];
for "_i" from 0 to _rootCount - 1 do
{
	_obj = _root select _i;
	if(isClass _obj) then
	{
		_className = configName _obj;
		
		if(_className isKindOf _type && !(_className isKindOf "Autonomous")) then
		{
			_scope = getNumber (configFile >> "CfgVehicles" >> _className >> "scope");
			//2 = public, eg allowed vehicles
			_crew = getText (configFile >> "CfgVehicles" >> _className >> "crew");
			_displayName = getText (configFile >> "CfgVehicles" >> _className >> "Displayname"); 
			//diag_log format ["%1:%2(%3)", _className, _crew,_displayName];
			
			
			if(_scope == 2 && !(_crew == "B_UAV_AI") && !(_crew == "O_UAV_AI") && !(_crew == "I_UAV_AI")) then
			{
				_add = false;
				if(_type == "Car" || _type == "Tank" || _type == "Armored") then
				{
					_turrets = getArray (configFile >> "CfgVehicles" >> _className >> "Turrets" >> "MainTurret" >> "weapons");
					
					if(count _turrets > 0 && !_onlyUnArmed) then
					{
						_add = true;
					};
					
					if(count _turrets == 0 && _onlyUnArmed) then
					{
						_add = true;
					};
				}
				else
				{
					_add = true;
				};
				if(_add) then
				{
					//diag_log format ["Adding:%1:%2(%3)", _className, _crew,_displayName];
					if !(_displayName in _foundVehicleNames) then
					{
						_foundVehicleNames set [count _foundVehicleNames, _displayName];
						_foundClasses set [count _foundClasses, _className];
					};
				};
			};
		};
	};
};
_foundClasses;