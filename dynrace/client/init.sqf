if (isNil {player} || isNull player) then
{
	DYN_RACE_JIPPLAYER = true;
}
else
{
	DYN_RACE_JIPPLAYER = false;
};

[] spawn 
{
	// Wait for join in progress
	waitUntil {!isNil {player}};
	waitUntil {!isNull player};
	
	DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = DYN_RACE_MUST_STAY_ON_ROAD;
	DYN_PLAYER_VEHICLE_FLIPPED = false;
	DYN_PLAYER_VEHICLE_RESET_TIME = 0;
	DYN_PLAYER_ON_ROAD = true;
	DYN_RACE_LAST_WARNING = 0;
	
	//enableRadio false;
	
	_i = 1;
	{
		_checkpoint = _x;
		_taskname = (if (_i == (count DYN_RACE_CHECKPOINTS)) then { "Finish" } else {format["Checkpoint: %1",_i]});
		_checkpointTask = player createSimpleTask [_taskname];
		_checkpointTask setSimpleTaskDestination (getMarkerPos _checkpoint);
		_i = _i + 1;
	} forEach DYN_RACE_CHECKPOINTS;
	
	player allowDamage false;
	removeAllItems player;
	removeAllWeapons player;
	
	waitUntil {!(isNull (findDisplay 46))};
	
	(finddisplay 46) displayRemoveAllEventHandlers "keydown";
	(finddisplay 46) displayRemoveAllEventHandlers "keyup";
	
	
	(finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 19) then {[] call DYN_RACE_ResetVehicle;};"];
	(finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 47) then {[] call DYN_RACE_StartDialog;};"];
	//TODO: Look into this we need proper acceleration
	(finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 17 || (_this select 1 == 200)) then { [] call DYN_RACE_TurboStart; };"];
	(finddisplay 46) displayAddEventHandler ["keyup", "if ((_this select 1) == 17 || (_this select 1 == 200)) then { [] call DYN_RACE_TurboStop; }; "];
	if(DYN_RACE_JIPPLAYER && DYN_RACE_STATE != "IDLE" && DYN_RACE_STATE != "FINISHED") then
	{
		waitUntil {(DYN_RACE_STATE == "ONGOING")};
		[] spawn DYN_RACE_EnableSpectator;
	};
	
	waitUntil{!(isNil "BIS_fnc_init")};
	["Dynamics Race","by M1nd0"] spawn BIS_fnc_infoText;
	
	if(DYN_RACE_STATE == "IDLE") then
	{
		sleep 5;
		//[] call DYN_RACE_StartDialog;
		systemChat "Pres 'v' to open the vote dialog.";
	};
};