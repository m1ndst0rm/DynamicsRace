/* DYN_RACE_DisableSpectator: Disable spectator on local client
* Can only be called on local client. 
*/
DYN_RACE_DisableSpectator =
{
	"DYN_RACE_DisableSpectator" call DYN_RACE_Debug;
	if (!(isDedicated)) then
	{
		titleCut ["", "BLACK OUT", 1];
		sleep 2;

		btk_spectator_cam camSetTarget player;
		player cameraEffect ["terminate","back"];
		player switchCamera "INTERNAL";
		btk_spectator_cam_enabled = false;
		camDestroy btk_spectator_cam;
		
		titleCut ["", "BLACK IN", 2];
	};
};