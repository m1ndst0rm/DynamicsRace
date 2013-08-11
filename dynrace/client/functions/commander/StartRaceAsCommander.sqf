private ["_i","_text","_targetter","_color","_action_cost"];
sleep 15;

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
[] spawn DYN_fnc_SpawnLocalTimer;

//DYN_RACE_HANLDER_MAP = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 50) then {[] call DYN_fnc_ComBtnMap;};"];
//onMapSingleClick "[_pos, _units, _shift, _alt] call DYN_fnc_ComMapClick;false;";
DYN_RACE_HANLDER_COMACTIONS = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 57) then {[] call DYN_fnc_ComDisplayActions;};"];
DYN_RACE_HANDLER_COMACTIVEACTION = (finddisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call DYN_fnc_ComDeployAction;"];
//(finddisplay 46) createDisplay "DYN_COMTARGETDiag";
4040 cutRsc ["DYN_COMTARGETDiag","PLAIN"]; 

DYN_RACE_COMMANDER_RESOURCEPOINTS = 0;
disableSerialization;
while{ (DYN_RACE_STATE == "ONGOING") } do 
{
	DYN_RACE_COMMANDER_RESOURCEPOINTS = DYN_RACE_COMMANDER_RESOURCEPOINTS + 1;
	//cutRsc ["DYN_COMTARGETDiag","PLAIN"];
	_uiObj = uiNamespace getVariable "DYN_COMTARGETDIAG";
	_targetter = _uiObj displayCtrl 4041;
	_color = [1,0,0,1]; //red
	if(count DYN_RACE_COMMANDER_SELECTED_ACTION > 0) then
	{
		_action_cost = DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
		if(_action_cost <= DYN_RACE_COMMANDER_RESOURCEPOINTS) then
		{
			_color = [0,1,0,1]; //Green
		};
	};
	
	_targetter ctrlSetTextColor _color;
	_targetter ctrlShow DYN_RACE_SPEC_ENABLED;
	sleep 1;
};

//Race is over. Remove the handlers etc
onMapSingleClick "";
(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANLDER_MAP];
(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANLDER_COMACTIONS];
(finddisplay 46) displayRemoveEventHandler ["MouseButtonDown", DYN_RACE_HANDLER_COMACTIVEACTION];
openMap false;