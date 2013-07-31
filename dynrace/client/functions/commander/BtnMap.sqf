"DYN_RACE_BtnMap" call DYN_RACE_Debug;
if(DYN_RACE_SPECTATOR_CAM_FREELOOK) then
{
	DYN_RACE_SPECTATOR_CAM cameraeffect ["Terminate","back"];
	DYN_RACE_SPECTATOR_TARGET switchCamera "EXTERNAL";
	DYN_RACE_SPECTATOR_CAM_FREELOOK = false;
	DYN_RACE_SPECTATOR_CAM camCommit 0;
	openMap true;
};