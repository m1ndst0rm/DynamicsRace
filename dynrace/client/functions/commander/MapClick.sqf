"DYN_RACE_MapClick" call DYN_RACE_Debug;
_pos = _this select 0;
_units = _this select 1;
_shift = _this select 2;
_alt = _this select 3;

openMap false;

//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}]
_scriptExecuted = false;
{
	_action = _x;
	_action_name = _action select 0;

	if(DYN_RACE_COMMANDER_SELECTED_ACTION == _action_name) then
	{
		_action_cost = _action select 5; 
		_script = _action select 6;
		_succes = [player,_pos] call _script;
		if(_succes) then
		{
			DYN_RACE_COMMANDER_RESOURCEPOINTS = DYN_RACE_COMMANDER_RESOURCEPOINTS - _action_cost;
		};
		_scriptExecuted = true;
	};
} foreach DYN_RACE_COMMANDER_ACTIONS;
//If no button is selected teleport camera pos to map click pos.
if!(_scriptExecuted) then
{
	
	//DYN_RACE_SPECTATOR_CAM cameraEffect ["internal","back"];
	// setPos [_pos select 0 , _pos select 1, 20];
	//DYN_RACE_SPECTATOR_CAM_FREELOOK = true;	
	//DYN_RACE_SPECTATOR_CAM camCommit 0;
};