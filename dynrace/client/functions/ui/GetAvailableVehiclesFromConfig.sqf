/* DYN_fnc_GetAvailableVehiclesFromConfig: Loads the vehicle data for the racer select list from avaiable classnames.
*
*/
private ["_vehicles","_classname","_vehicleclass","_picture"];
"DYN_fnc_GetAvailableVehiclesFromConfig" call BIS_fnc_log;
private["_cfgvehicles","_vehicles","_cur_vehicle","_classname","_scope","_picture","_vehicleclass","_name","_match","_compare"];
_vehicles = [];


switch (DYN_RACE_TYPE) do
{
	case "SINGLE":
	{
		DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_SINGLE;
	};
	case "DUAL":
	{
		DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_DUAL;
	};
	case "TEAM":
	{
		DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_SINGLE;
	};
	case "TEAM3":
	{
		DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_DUAL;
	};
	case "HELICHASE":
	{
		DYN_RACE_AVAILABLE_VEHICLES = DYN_RACE_AVAILABLE_VEHICLES_DUAL;
	};
};


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