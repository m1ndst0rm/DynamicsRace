"DYN_RACE_SwitchFreeLook" call BIS_fnc_log;
if !(DYN_RACE_SPECTATOR_CAM_FREELOOK) then
{
	DYN_RACE_SPECTATOR_CAM cameraEffect ["internal","back"];
	DYN_RACE_SPECTATOR_CAM setPos [((position DYN_RACE_SPECTATOR_TARGET) select 0) + ((sin (getdir DYN_RACE_SPECTATOR_TARGET)) * ( - 10)), ((position DYN_RACE_SPECTATOR_TARGET) select 1) + ((cos (getdir DYN_RACE_SPECTATOR_TARGET)) * (- 10)), ((position DYN_RACE_SPECTATOR_TARGET) select 2) + 2];
	DYN_RACE_SPECTATOR_CAM setDir getDir DYN_RACE_SPECTATOR_TARGET;
	DYN_RACE_SPECTATOR_CAM_FREELOOK = true;
	DYN_RACE_SPECTATOR_CAM camCommit 0;
}
else
{
	if(player getVariable ["isCommander", false]) then
	{
		DYN_RACE_SPECTATOR_CAM setPos [((position DYN_RACE_SPECTATOR_TARGET) select 0), ((position DYN_RACE_SPECTATOR_TARGET) select 1), ((position DYN_RACE_SPECTATOR_TARGET) select 2) + 100];
		DYN_RACE_SPECTATOR_CAM setDir getDir DYN_RACE_SPECTATOR_TARGET;
		DYN_RACE_SPECTATOR_CAM_FREELOOK = false;
		DYN_RACE_SPECTATOR_CAM camSetTarget DYN_RACE_SPECTATOR_TARGET;
		DYN_RACE_SPECTATOR_CAM camSetRelPos [0,0,100];
		DYN_RACE_SPECTATOR_CAM cameraEffect ["external", "back"];
		//DYN_RACE_SPECTATOR_CAM setVectorDirAndUp [[0,0,-1],[0,1,0]];
		DYN_RACE_SPECTATOR_CAM camCommit 0;
	}
	else
	{
		if(DYN_RACE_SPECTATOR_CAM_FREELOOK) then
		{
			DYN_RACE_SPECTATOR_CAM cameraeffect ["Terminate","back"];
			cutText [format["%1", (name DYN_RACE_SPECTATOR_TARGET)],"PLAIN DOWN"];
			DYN_RACE_SPECTATOR_TARGET switchCamera "EXTERNAL";
			DYN_RACE_SPECTATOR_CAM_FREELOOK = false;
			DYN_RACE_SPECTATOR_CAM camCommit 0;
		};
	};
};