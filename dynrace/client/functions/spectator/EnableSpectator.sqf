"DYN_RACE_EnableSpectator" call DYN_RACE_Debug;
titleCut ["", "BLACK OUT", 1];

DYN_RACE_HANDLER_SPECTATOR_SWITCH = (finddisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call DYN_RACE_SPEC_SwitchFreeLook;"];
DYN_RACE_HANDLER_SPECTATOR_SCROLL = (findDisplay 46) displayAddEventHandler ["mousezchanged", "_this call DYN_RACE_SPEC_SwitchPlayer;"];

DYN_RACE_SPECTATOR_CAM_FREELOOK = true;
DYN_RACE_SWITCHINGPLAYER = false;

{
	_racer = _x;
	_player = _x select 1;
	if(_player != player && _player getVariable ["isDriver", false]) then
	{
	
		DYN_RACE_SPECTATOR_TARGET = _player;
	};
} foreach DYN_RACE_RACERS;
DYN_RACE_SPECTATOR_CAM = "camconstruct" camCreate ((vehicle player) modelToWorld [0, 0, 1.75]);
DYN_RACE_SPECTATOR_CAM camConstuctionSetParams [(getPosATL (vehicle player)), 20000, 2000];
DYN_RACE_SPECTATOR_CAM cameraEffect ["internal", "back"];
DYN_RACE_SPECTATOR_CAM camPrepareTarget DYN_RACE_SPECTATOR_TARGET;
DYN_RACE_SPECTATOR_CAM camCommit 0;
titleCut ["", "BLACK IN", 1];
DYN_RACE_SPEC_ENABLED = true;
[] call DYN_RACE_DisplayHelp;
hint "";