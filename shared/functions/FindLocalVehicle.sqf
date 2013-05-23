/* DYN_RACE_FindLocalVehicle: Get local vehicle by net_id.
* 
* Params:
* _vehicle_net_id: netId of the vehicle.
*
* Returns:
* vehicle: returns a local vehicle object
*/
DYN_RACE_FindLocalVehicle =
{
	_vehicle_net_id = _this select 0;
	_units = vehicles;
	_vehicle = null;
	
	{
		_unit = _x;
		_unitId = [_unit] call DYN_RACE_GetObjectID;
		if(_unitId == _vehicle_net_id) then
		{
			_vehicle = _unit;
		};
	} forEach _units;
	
	_vehicle;
};