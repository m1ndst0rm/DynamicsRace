titleCut ["", "BLACK OUT", 1];
sleep 2;

if(DYN_RACE_SPEC_ENABLED) then
{
	DYN_RACE_SPECTATOR_CAM camSetTarget player;
	player cameraEffect ["terminate","back"];
	player switchCamera "INTERNAL";
	camDestroy DYN_RACE_SPECTATOR_CAM;

	(finddisplay 46) displayRemoveEventHandler ["MouseButtonDown", DYN_RACE_HANDLER_SPECTATOR_SWITCH];
	(finddisplay 46) displayRemoveEventHandler ["mousezchanged", DYN_RACE_HANDLER_SPECTATOR_SCROLL];
};
DYN_RACE_SPEC_ENABLED = false;
titleCut ["", "BLACK IN", 2];