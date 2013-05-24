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
			
			if(_picture != "" && !(_classname in _vehicles)) then 
			{
				_vehicles set[count _vehicles, [_name,_classname,_picture]];
			};
		} foreach DYN_RACE_AVAILABLE_VEHICLES;
	};
	_vehicles;
};