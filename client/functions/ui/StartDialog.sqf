/* DYN_RACE_StartDialog: Launch the dialog for selecting the vehicle and starting the race.
*
*/
DYN_RACE_StartDialog = 
{
	if(DYN_RACE_STATE == "IDLE") then 
	{
		closeDialog 4000;
		createDialog "DYN_Diag";
		disableSerialization;
	};
	true;
};