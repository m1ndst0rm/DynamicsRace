/* DYN_RACE_VoteDialogVoteButton: Action handler called when a player pres the Vote button.
*
*/
"DYN_RACE_VoteDialogVoteButton" call DYN_RACE_Debug;
if(DYN_RACE_STATE == "IDLE") then 
{
	disableSerialization;
	_dialog = findDisplay 4000;
	
	_list = _dialog displayctrl 4001;
	_item = Lbselection _list select 0;
	if(isNil {_item}) then {_item = 0;};
	_item = lbData[4001,_item];

	DYN_RACE_VOTEDIALOG_OPEN = false;
	closeDialog 4000;
	//player setVariable [DYN_RACE_VOTE_TYPE, _item, true];
	
	_oldVoteType = DYN_RACE_VOTE_TYPE_CLIENT;
	
	switch (_oldVoteType) do
	{
		case "RACETYPE":
		{
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_RACE_ProcessClientVote", false] spawn BIS_fnc_MP;
			waitUntil { !(isNil {DYN_RACE_TYPE}) && {DYN_RACE_TYPE != ""}};
			if(DYN_RACE_TYPE != "COPS&ROBBERS") then
			{
				[] spawn DYN_RACE_VoteDialog;
			}
			else
			{	//Spawn team selection
				[] spawn DYN_RACE_TeamSelectionDialog;
			};
		};
		case "DAMAGETYPE":
		{
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_RACE_ProcessClientVote", false] spawn BIS_fnc_MP;
			sleep 2;
			if(DYN_RACE_TYPE != "CAT&MOUSE") then
			{
				DYN_RACE_VOTE_TYPE_CLIENT = "VEHICLETYPE";
				[] spawn DYN_RACE_VoteDialog;
			}
			else
			{
				[] spawn DYN_RACE_TeamSelectionDialog;
			};
		};
		case "VEHICLETYPE":
		{
			//Stahp.
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_RACE_ProcessClientVote", false] spawn BIS_fnc_MP;
			if(DYN_RACE_TYPE != "SINGLE") then
			{
				[] spawn DYN_RACE_TeamSelectionDialog;
			};
		};
	};
}
else
{
	hintC "Voting is not allowed at this time.";
	closeDialog 4000;
};