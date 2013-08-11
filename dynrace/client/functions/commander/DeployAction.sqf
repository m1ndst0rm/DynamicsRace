"DYN_RACE_DeployAction" call BIS_fnc_log;
private ["_action_cost","_script","_handle"];
if((_this select 1) == 0) then
{
	[] spawn 
	{
		if (count DYN_RACE_COMMANDER_SELECTED_ACTION > 0 && !DYN_RACE_COMDIALOG_OPEN && !DYN_RACE_COMPROCESSINGACTION) then
		{
			_action_cost = DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
			
			if(_action_cost <= DYN_RACE_COMMANDER_RESOURCEPOINTS) then
			{
				DYN_RACE_COMPROCESSINGACTION = (DYN_RACE_COMMANDER_SELECTED_ACTION select 7);
				_pos = screenToWorld [0.5,0.5];
				_script = DYN_RACE_COMMANDER_SELECTED_ACTION select 6;
				DYN_RACE_COMMANDER_RESOURCEPOINTS = DYN_RACE_COMMANDER_RESOURCEPOINTS - _action_cost;
				_handle = [player,_pos] spawn _script;
				disableSerialization;
				_uiObj = uiNamespace getVariable "DYN_COMTARGETDIAG";
				_targetter = _uiObj displayCtrl 4041;
				if(DYN_RACE_COMPROCESSINGACTION) then
				{
					_targetter ctrlShow false;
					waitUntil {scriptDone _handle};
				};
				//Just to make sure player not instantly spawns a new action when player is firing
				sleep 2;
				_targetter ctrlShow true;
				DYN_RACE_COMPROCESSINGACTION = false;
			};
		};
	};
};
//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}]