/* DYN_RACE_EnableSpectator: Enable spectator on local client
* Can only be called on local client. 
*/
DYN_RACE_EnableSpectator = 
{
	"DYN_RACE_EnableSpectator" call DYN_RACE_Debug;
	if (!(isDedicated)) then
	{
		[] spawn {
			
			sleep 3;
			titleCut ["", "BLACK OUT", 1];
			
			null = [] execVM "dynrace\addons\btk_spectator.sqf";
			titleCut ["", "BLACK IN", 5];
		};
	};
};