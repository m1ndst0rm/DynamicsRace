/* DYN_RACE_GetAvailableVehiclesFromConfig: Loads the vehicle data for the racer select list from avaiable classnames.
*
*/
DYN_RACE_GetAvailableVehiclesFromConfig = 
{
	"DYN_RACE_GetAvailableVehiclesFromConfig" call DYN_RACE_Debug;
	private["_cfgvehicles","_vehicles","_cur_vehicle","_classname","_scope","_picture","_vehicleclass","_name","_match","_compare"];
	_vehicles = [];
	
	if(count DYN_RACE_AVAILABLE_VEHICLES > 0) then
	{
		{
			_classname = _x;
			_vehicleclass = getNumber(configFile >> "CfgVehicles" >> _classname >> "vehicleclass");
			
			_name = getText(configFile >> "CfgVehicles" >> _classname >> "displayname");
			_picture = getText(configFile >> "CfgVehicles" >> _classname >> "picture");
			//diag_log format ["Max Speed: %1", _maxSpeed];
			
			if(_picture != "" && !(_classname in _vehicles)) then 
			{
				_vehicles set[count _vehicles, [_name,_classname,_picture]];
			};
		} foreach DYN_RACE_AVAILABLE_VEHICLES;
	};
	/* TODO: maybe imlement?
	else
	{
		_cfgvehicles = configFile >> "CfgVehicles";
		
		for "_i" from 0 to (count _cfgvehicles)-1 do
		{
			_cur_vehicle = _cfgvehicles select _i;
			if(isClass _cur_vehicle) then
			{
				_classname = configName _cur_vehicle;
				_vehicleclass = getNumber(_cur_vehicle >> "vehicleclass");
				_name = getText (_cur_vehicle >> "DisplayName");
				_picture = getText(_cur_vehicle >> "picture");
				_scope = getNumber(_cur_vehicle >> "scope"); //_scope >= 2 && 
				if( _picture != "" && !(_classname in _vehicles)) then
				{
					//diag_log format["Class: %1 - Type: %2 - Scope: %3 - Pic: %4 - WEP: %5",_classname,_vehicleclass,_scope,_picture,_cur_vehicle];
					_match = false;

					//TODO Check wether we should do this
					{
						if(_picture ==  (_x select 2)) then
						{
							_match = true;
						};
					} foreach _vehicles;
					
					if(!_match) then
					{
						_vehicles set[count _vehicles, [_name,_classname,_picture]];
					};
				};
			};
		};
	};
	*/
	_vehicles;
};