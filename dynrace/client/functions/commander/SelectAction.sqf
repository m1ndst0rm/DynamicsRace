private ["_dialog","_list","_item","_comActionsCount","_i","_action"];
disableSerialization;
_dialog = findDisplay 4030;
_list = _dialog displayCtrl 4031;

_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[4031,_item];

_comActionsCount = count DYN_RACE_COMMANDER_ENABLED_ACTIONS;
_i= 0; for "_i" from 0 to (_comActionsCount - 1) do
{
	_action = DYN_RACE_COMMANDER_ENABLED_ACTIONS select _i;
	if(_action select 0 == _item) then
	{
		DYN_RACE_COMMANDER_SELECTED_ACTION = _action;
		_uiObj = uiNamespace getVariable "DYN_COMTARGETDIAG";
		_targetter = _uiObj displayCtrl 4041;
		_color = [1,0,0,1]; //red
		_action_cost = DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
		if(_action_cost <= DYN_RACE_COMMANDER_RESOURCEPOINTS) then
		{
			_color = [0,1,0,1]; //Green
		};
		_targetter ctrlSetTextColor _color;
	};
};
DYN_RACE_COMDIALOG_OPEN = false;
closeDialog 4030;

