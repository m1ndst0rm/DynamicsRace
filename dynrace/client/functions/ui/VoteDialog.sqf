/* DYN_RACE_VoteDialog: Launch the dialog for voting
*
*/
if(count _this > 0) then
{
	sleep (_this select 0);
};

if(DYN_RACE_STATE == "IDLE") then 
{
	if!(DYN_RACE_VOTEDIALOG_OPEN) then
	{
		disableSerialization;
		closeDialog 4000;
		DYN_RACE_VOTEDIALOG_OPEN = true;
		createDialog "DYN_Diag";
		
		waitUntil {(!(isNull (findDisplay 4000)))};
		_voteDisplay = findDisplay 4000;
		_voteDisplay displayAddEventHandler ["KeyDown","_this call DYN_RACE_DisableClose;"];
	};
};
true;