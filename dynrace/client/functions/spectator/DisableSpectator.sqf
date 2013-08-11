private ["_displayFades"];

"DYN_RACE_DisableSpectator" call BIS_fnc_log;
_displayFades = true;
if(count _this > 0) then
{
	_displayFades = _this select 0;
};

if(_displayFades) then
{
	titleCut ["", "BLACK OUT", 1];
};
sleep 2;

if(DYN_RACE_SPEC_ENABLED) then
{
	DYN_RACE_SPECTATOR_CAM camSetTarget player;
	DYN_RACE_SPECTATOR_CAM camCommit 0;
	player cameraEffect ["terminate","back"];
	player switchCamera "INTERNAL";
	
	camDestroy DYN_RACE_SPECTATOR_CAM;

	(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANDLER_SPECTATOR_SWITCH];
	(finddisplay 46) displayRemoveEventHandler ["mousezchanged", DYN_RACE_HANDLER_SPECTATOR_SCROLL];
};
DYN_RACE_SPEC_ENABLED = false;
if(_displayFades) then
{
	titleCut ["", "BLACK IN", 2];
};