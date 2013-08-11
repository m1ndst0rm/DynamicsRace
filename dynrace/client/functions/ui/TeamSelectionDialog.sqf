if(DYN_RACE_STATE == "IDLE") then 
{
	private ["_teamSelectionDisplay"];
	waitUntil {count DYN_RACE_TEAMS > 0};
	
	disableSerialization;
	closeDialog 4000;
	closeDialog 4010;
	createDialog "DYN_TeamSelectionDiag";
	
	 waitUntil {(!(isNull (findDisplay 4010)))};
    _teamSelectionDisplay = findDisplay 4010;
	_teamSelectionDisplay displayAddEventHandler ["KeyDown","_this call DYN_fnc_DisableClose"];
};
true;