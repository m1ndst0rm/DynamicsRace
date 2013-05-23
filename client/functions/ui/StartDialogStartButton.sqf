/* DYN_RACE_StartDialogStartButton: Action handler called when a player pres the start race button.
*
*/
DYN_RACE_StartDialogStartButton =
{
	"DYN_RACE_StartDialogStartButton" call DYN_RACE_Debug;
	if(DYN_RACE_STATE == "IDLE") then 
	{
		disableSerialization;
		_dialog = findDisplay 4000;
		
		_list = _dialog displayctrl 4001;
		_item = Lbselection _list select 0;
		if(isNil {_item}) then {_item = 0;};
		_item = lbData[4001,_item];

		//[_item] call DYN_RACE_StartRace;
		[[netId player, _item, ""],"DYN_RACE_ProcessClientVote", false] spawn BIS_fnc_MP;
		closeDialog 4000;
	}
	else
	{
		hintC "Voting is not allowed at this time.";
		closeDialog 4000;
	};
};