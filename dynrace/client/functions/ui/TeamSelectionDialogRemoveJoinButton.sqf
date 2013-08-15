disableSerialization;
_teamSelectionDialog = findDisplay 4010;
if!(isNull _teamSelectionDialog) then
{
	_joinButton = _teamSelectionDialog displayCtrl 4014;
	_joinButton ctrlShow false;
};