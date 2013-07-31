DYN_RACE_HANLDER_MAP = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 50) then {[] call DYN_RACE_COM_BtnMap;};"];

sleep 5;

for [{_i = 10},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.8'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	
	if(_i <= 3) then
	{
		playSound "BEEP";
	};
	sleep 1;
};
playSound "BEEP_HIGH";
_text = "<t align='center' valign='middle' size='2.0'>Go!</t>";
[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
waitUntil { DYN_RACE_STATE == "ONGOING" };
[] spawn DYN_RACE_SpawnLocalTimer;

onMapSingleClick "[_pos, _units, _shift, _alt] call DYN_RACE_COM_MapClick;false;";

DYN_RACE_COMMANDER_RESOURCEPOINTS = 0;
while{ (DYN_RACE_STATE == "ONGOING") } do 
{
	DYN_RACE_COMMANDER_RESOURCEPOINTS = DYN_RACE_COMMANDER_RESOURCEPOINTS + 1;
	//Check which buttons should be enabled.
	{
		_action = _x;
		//Do magic
	} foreach DYN_RACE_COMMANDER_ACTIONS;
	
	sleep 1;
};

//Race is over. Remove the handlers etc
onMapSingleClick "";
(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANLDER_MAP];
openMap false;