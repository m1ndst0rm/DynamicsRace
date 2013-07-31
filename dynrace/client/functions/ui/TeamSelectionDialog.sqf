if(DYN_RACE_STATE == "IDLE") then 
{
	waitUntil {count DYN_RACE_TEAMS > 0};
	disableSerialization;
	closeDialog 4010;
	createDialog "DYN_TeamSelectionDiag";
	
	 waitUntil {(!(isNull (findDisplay 4010)))};
    _teamSelectionDisplay = findDisplay 4010;
	_teamSelectionDisplay displayAddEventHandler ["KeyDown","_this call DYN_RACE_DisableClose"];
};
true;