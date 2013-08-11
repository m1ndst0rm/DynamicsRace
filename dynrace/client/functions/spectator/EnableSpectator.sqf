private ["_displayHelp","_racer","_player"];
"DYN_RACE_EnableSpectator" call BIS_fnc_log;
titleCut ["", "BLACK OUT", 1];

_displayHelp = [_this, 0, true] call bis_fnc_param;

DYN_RACE_HANDLER_SPECTATOR_SWITCH = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 47	) then {_this call DYN_fnc_SwitchFreeLook;};"];
DYN_RACE_HANDLER_SPECTATOR_SCROLL = (findDisplay 46) displayAddEventHandler ["mousezchanged", "_this call DYN_fnc_SwitchPlayer;"];

DYN_RACE_SPECTATOR_CAM_FREELOOK = true;
DYN_RACE_SWITCHINGPLAYER = false;
_possibleSpecs = [];
if(count DYN_RACE_RACERS > 0) then
{
	{
		_racer = _x;
		_player = _x select 1;
		if(_player != player && _player getVariable ["isDriver", false]) then
		{
			_possibleSpecs set [count _possibleSpecs, _player];//DYN_RACE_SPECTATOR_TARGET = _player;
		};
	} foreach DYN_RACE_RACERS;
	
	DYN_RACE_SPECTATOR_TARGET = _possibleSpecs select floor(random count _possibleSpecs);
};

DYN_RACE_SPECTATOR_CAM = "camconstruct" camCreate ((vehicle player) modelToWorld [0, 0, 1.75]);
DYN_RACE_SPECTATOR_CAM camConstuctionSetParams [(getPosATL (vehicle player)), 20000, 2000];
DYN_RACE_SPECTATOR_CAM cameraEffect ["internal", "back"];
DYN_RACE_SPECTATOR_CAM camPrepareTarget DYN_RACE_SPECTATOR_TARGET;
DYN_RACE_SPECTATOR_CAM camCommit 0;
titleCut ["", "BLACK IN", 1];
DYN_RACE_SPEC_ENABLED = true;
if(_displayHelp) then
{
	[] call DYN_fnc_DisplayHelp;
};
hint "";