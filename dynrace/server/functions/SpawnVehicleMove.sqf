/* DYN_RACE_SpawnVehicleMove: Spawn a set of units and let them move from a to b
 * Spawn vehicles and let the move from a to b. Can also spawn helis and boats.
 * 
 * [_vehicles_spawn_id, _vehiclesPerSpawn, _maxvehicles, _classname, _marker_name_from, _marker_name_to] call DYN_RACE_SpawnVehicleMove;
 * 
 * Parameters:
 * _vehicles_spawn_id: unique ID to identify vehicle spawn. Used to put a limit into spawned units
 * _vehiclesPerSpawn: vehicles to spawn
 * _maxvehicles: maximum vehicles which can be spawned in 1 race by this spawn
 * _classname: vehicle classname to spawn
 * _marker_name_from: marker where the units should spawn
 * _marker_name_to: marker where the units should move to
 * TODO: Change to DYN_RACE_SpawnVehicle
 */
if (!isServer) exitWith {} ;
"DYN_RACE_Spawn_Vehicle" call DYN_RACE_Debug;

_vehicles_spawn_id = _this select 0;
_vehiclesPerSpawn = _this select 1;
_maxvehicles = _this select 2;
_classname = _this select 3;
_marker_from = getMarkerPos (_this select 4);
_marker_to = getMarkerPos (_this select 5);

_vehicles = [];
_vehicles_to_spawn = _vehiclesPerSpawn;
_cur_vehicle_spawn_pos = -1;
_cur_vehicle_spawn = objNull;
_cur_vehicle_spawn_set = false;
_map_vehicles = DYN_RACE_MAP_VEHICLES;
for [{_i = 0},{_i<(count _map_vehicles)}, {_i=_i+1}] do
{
	
	_vehicle_spawn = _map_vehicles select _i;
	_lcl_vehicle_spawn_id = _vehicle_spawn select 0;
	if(_lcl_vehicle_spawn_id == _vehicles_spawn_id) then
	{
		
		_cur_vehicle_spawn = _vehicle_spawn;
		_cur_vehicle_spawn_set = true;
		_cur_vehicle_spawn_pos = _i;
		_lcl_vehicles = _vehicle_spawn select 1;
		
		_vehicles_to_spawn = _maxvehicles - (count _lcl_vehicles);
		if(_vehicles_to_spawn < 0) then
		{
			_vehicles_to_spawn = 0;
		};
	};
};

for [{_i = 0},{_i<_vehicles_to_spawn}, {_i=_i+1}] do 
{
	_vehiclePosition = [_marker_from, 0, _vehicles_to_spawn*15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
	
	_vehicle = [_vehiclePosition, (markerdir (_this select 4)), _classname, east] call BIS_fnc_spawnVehicle;

	(_vehicle select 0) allowFleeing 0;
	
	
	if !(_cur_vehicle_spawn_set) then
	{
		_vehicles set [_i, (_vehicle select 0)];
		_cur_vehicle_spawn = [_vehicles_spawn_id, _vehicles];
		DYN_RACE_MAP_VEHICLES set [count DYN_RACE_MAP_VEHICLES, _cur_vehicle_spawn];
	}
	else
	{
		_vehicles = _cur_vehicle_spawn select 1;
		_vehicles set [count _vehicles, (_vehicle select 0)];
		_cur_vehicle_spawn set [1 , _vehicles];
		DYN_RACE_MAP_VEHICLES set [_cur_vehicle_spawn_pos, _cur_vehicle_spawn];
	};
};
diag_log "Vehicles:";
diag_log DYN_RACE_MAP_VEHICLES;
_i = 0;
{
	_x doMove _marker_to;
	_i = _i + 1;
} forEach _vehicles;