/* DYN_fnc_VoteDialogVoteButton: Action handler called when a player pres the Vote button.
*
*/
private ["_dialog","_list","_item","_oldVoteType"];
"DYN_fnc_VoteDialogVoteButton" call BIS_fnc_log;
if(DYN_RACE_STATE == "IDLE") then 
{
	disableSerialization;
	_dialog = findDisplay 4000;
	
	_list = _dialog displayctrl 4001;
	_item = Lbselection _list select 0;
	if(isNil {_item}) then {_item = 0;};
	_item = lbData[4001,_item];

	DYN_VOTEDIALOG_OPEN = false;
	closeDialog 4000;
	//player setVariable [DYN_RACE_VOTE_TYPE, _item, true];
	
	_oldVoteType = DYN_RACE_VOTE_TYPE_CLIENT;
	
	switch (_oldVoteType) do
	{
		case "RACETYPE":
		{
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_fnc_ProcessClientVote", false] call BIS_fnc_MP;
			waitUntil { !(isNil {DYN_RACE_TYPE}) && {DYN_RACE_TYPE != ""}};
			if(DYN_RACE_TYPE != "COPS&ROBBERS") then
			{
				[] spawn DYN_fnc_VoteDialog;
			}
		};
		case "DAMAGETYPE":
		{
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_fnc_ProcessClientVote", false] call BIS_fnc_MP;
			sleep 2;
			if(DYN_RACE_TYPE != "CAT&MOUSE") then
			{
				DYN_RACE_VOTE_TYPE_CLIENT = "VEHICLETYPE";
				[] spawn DYN_fnc_VoteDialog;
			}
		};
		case "VEHICLETYPE":
		{
			//Stahp.
			[[netId player, DYN_RACE_VOTE_TYPE_CLIENT, _item],"DYN_fnc_ProcessClientVote", false] call BIS_fnc_MP;
		};
	};
}
else
{
	hintC "Voting is not allowed at this time.";
	closeDialog 4000;
};