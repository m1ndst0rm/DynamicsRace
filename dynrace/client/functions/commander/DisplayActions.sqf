disableSerialization;

if(DYN_RACE_STATE == "ONGOING") then 
{
	if(!DYN_RACE_COMDIALOG_OPEN && !DYN_RACE_COMPROCESSINGACTION) then
	{
		private ["_comDisplay"];
		disableSerialization;
		closeDialog 4030;
		DYN_RACE_COMDIALOG_OPEN = true;
		createDialog "DYN_CommanderDiag";
		
		waitUntil {(!(isNull (findDisplay 4030)))};
		_comDisplay = findDisplay 4030;
		_comDisplay displayAddEventHandler ["KeyDown","if(_this select 1 == 1) then {DYN_RACE_COMDIALOG_OPEN = false;closeDialog 4030;};true;"];
	};
};
true;