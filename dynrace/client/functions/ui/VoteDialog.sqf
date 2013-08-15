/* DYN_fnc_VoteDialog: Launch the dialog for voting
*
*/
if(count _this > 0) then
{
	sleep (_this select 0);
};

if(DYN_RACE_STATE == "IDLE") then 
{
	if!(DYN_VOTEDIALOG_OPEN) then
	{
		private ["_voteDisplay","_total_racers"];
		_total_racers = count ([] call DYN_fnc_GetAvailableRacers);
		if(_total_racers > 1) then
		{
			disableSerialization;
			closeDialog 4000;
			DYN_VOTEDIALOG_OPEN = true;
			createDialog "DYN_Diag";
			
			waitUntil {(!(isNull (findDisplay 4000)))};
			_voteDisplay = findDisplay 4000;
			_voteDisplay displayAddEventHandler ["KeyDown","_this call DYN_fnc_DisableClose;"];
		}
		else
		{
			hintC "Not enough players online to start a vote.";
		};
	};
};
true;