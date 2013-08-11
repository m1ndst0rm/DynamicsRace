private ["_comDisplay","_comActionsCount","_dialog","_list","_i","_action"];
disableSerialization;
_comDisplay = findDisplay 4030;
_comActionsCount = count DYN_RACE_COMMANDER_ENABLED_ACTIONS;

_dialog = findDisplay 4030;
_list = _dialog displayCtrl 4031;
lbClear _list;
_i= 0; for "_i" from 0 to (_comActionsCount - 1) do
{
	//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}]
	_action = DYN_RACE_COMMANDER_ENABLED_ACTIONS select _i;
	
	_list lbAdd format["%1",_action select 3];
	_list lbSetData [(lbSize _list)-1, _action select 0];
};
_list lbSetSelected [(DYN_RACE_COMMANDER_ENABLED_ACTIONS find DYN_RACE_COMMANDER_SELECTED_ACTION), true];