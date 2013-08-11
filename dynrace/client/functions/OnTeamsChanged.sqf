private ["_dialog"];
if(dialog) then
{
	disableSerialization;
	_dialog = findDisplay 4010;
	if!(isNull _dialog) then
	{
		[] call DYN_fnc_TeamSelectionDialogTeamSelectionChanged;
	};
};