/* DYN_RACE_InitRace: Initializes the race. Spawns vehicles e.t.c.
* This function should NOT be called directly. Internal function.
*
*/
DYN_RACE_InitRace =
{
	if (!isServer) exitWith {};
	"DYN_RACE_InitRace" call DYN_RACE_Debug;
	DYN_RACE_RACERS = [];
	
	//TODO: Experiment
	//_vehicle_class = getText(configFile >> "CfgVehicles" >> DYN_RACE_VEHICLE >> "vehicleclass");
	//format ["Race vehicle class: %1", _vehicle_class] call DYN_RACE_Debug;
	
	//Start race with all the users which are currently online
	_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
	
	//Randomize all online players for starting positions
	//TODO: implement new BIS_fnc_arrayShuffle 
	_random_units = [];
	_units_count = count _units;
	for [ {_i = 0}, {_i < _units_count}, {_i = _i + 1}] do
	{
		_unit = _units call BIS_fnc_selectRandom;
		_random_units set [_i, _unit];
		_units = _units - [_unit];
	};
	_units = _random_units;
	
	_temp_model = DYN_RACE_VEHICLE createVehicle (getMarkerPos "DYN_RACE_Marker_Start");
	_box = boundingBox _temp_model;
	deleteVehicle _temp_model;
	
	_box_min = _box select 0;
	_box_max = _box select 1;
	_vehicle_width = (_box_max select 0) - (_box_min select 0);
	_vehicle_length = (_box_max select 1) - (_box_min select 1);
	_width_between_vehicle = 3;
	_height_between_vehicle = 3;

	_increment = 0;
	switch (DYN_RACE_TYPE) do
	{
		case "SINGLE":
		{
			_increment = 1;
		};
		case "DUAL":
		{
			_increment = 2;
		};
	};

	for [ {_i = 0}, {_i < _units_count}, {_i = _i + _increment}] do
	{
		_player = _units select _i;
		
		//_start_pos = getMarkerPos "DYN_RACE_Marker_Start";
		//_start_pos_dir = markerDir "DYN_RACE_Marker_Start";
		//_multiplier = floor(_i / 2);
		//_mod = (_i mod 2);
		//_pos_differential_side = (_width_between_vehicle / 2) + (0.5 * _vehicle_width);
		//if(_mod == 1) then
		//{
		//	_pos_differential_side = -1 * _pos_differential_side;
		//};
		//_pos_differential_forward = -((_vehicle_length * _multiplier) + (_height_between_vehicle * _multiplier));
		
		//_racer_object_location_x = (_start_pos select 0) + ((sin _start_pos_dir) * _pos_differential_forward) + ((sin _start_pos_dir + 90) * _pos_differential_side);
		//_racer_object_location_y = (_start_pos select 1) + ((cos _start_pos_dir) * _pos_differential_forward) + ((cos _start_pos_dir + 90) * _pos_differential_side);
		//_racer_object_location_z = (_start_pos select 2);
		
		//[format ["Creating race start pos: OldX:%1 OldY:%2 --NewX:%3 NewY:%4", (_start_pos select 0), (_start_pos select 1), _racer_object_location_x, _racer_object_location_y]] call DYN_RACE_Debug;
		
		_racer_pos = [_racer_object_location_x, _racer_object_location_y, _racer_object_location_z];

		_start_pos = getMarkerPos (DYN_RACE_START_POSITIONS select _i);
		_racer_object = createVehicle [DYN_RACE_VEHICLE, _start_pos, [], 0, "NONE"];
		_racer_object setFuel 0;

		//_racer_object setPos [_racer_object_location_x, _racer_object_location_y, _racer_object_location_z];
		//_racer_object setDir _start_pos_dir;
		
		_start_pos = [_start_pos select 0, _start_pos select 1, (_start_pos select 2) + 1];
		_racer_object setPos (_start_pos);
		_racer_object setDir (markerDir (DYN_RACE_START_POSITIONS select _i));
		
		_player_id = [_player] call DYN_RACE_GetObjectID;
		_racer_object_id = [_racer_object] call DYN_RACE_GetObjectID;
		_lap_times = [];
		
		//Move AI inside vehicle server sided.
		if !(isPlayer _player) then
		{
			_player moveInDriver _racer_object;	
		};
		
		switch (DYN_RACE_TYPE) do
		{
			case "SINGLE":
			{
				//For AI/local
				_racer_object allowDamage DYN_RACE_DAMAGE_ENABLED;
			};
			case "DUAL":
			{
				_racer_object allowDamage true;
				_gunner_pos = _i + 1;
				_gunner = objNull;
				if(_gunner_pos > count _units) then
				{ //Uneven player amount add AI
					//TODO:
				}
				else
				{
					_gunner = _units select _gunner_pos;
				};
				
				//AI
				_gunner moveInGunner _racer_object;
				_gunner_id = [_gunner] call DYN_RACE_GetObjectID;
				
				DYN_RACE_RACERS set [count DYN_RACE_RACERS, [name _gunner, _gunner_id, _racer_object_id, false, DYN_RACE_DAMAGE_ENABLED, false, _lap_times]];
			};
		};
		DYN_RACE_RACERS set [count DYN_RACE_RACERS, [name _player, _player_id, _racer_object_id, false, DYN_RACE_DAMAGE_ENABLED, false, _lap_times]];
	};
	
	DYN_RACE_STATE = "STARTING";
	
	publicVariable "DYN_RACE_RACERS";
	publicVariable "DYN_RACE_STATE";

    [] call DYN_RACE_OnRacersChanged;
	[] call DYN_RACE_OnRaceStateChanged;

	//Add waypoints for AI units. Not that they will be a match
	_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
	{
		_unit = _x;
		if !(isPlayer _unit) then
		{
			_unit allowFleeing 0;
			{
				_checkpoint = _x;
				_wp = (group _unit) addWaypoint [getMarkerPos _checkpoint, 25]; 
				_wp setWaypointType "MOVE"; 
				_wp setWaypointSpeed "FULL"; 
				_wp setWaypointBehaviour "AWARE";
			} foreach DYN_RACE_CHECKPOINTS;
		};
	} foreach _units;
};