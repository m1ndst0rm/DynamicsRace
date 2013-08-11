private ["_dialog","_list","_item","_comActionsCount","_textControl","_i","_action","_hint","_cost","_text"];
disableSerialization;
_dialog = findDisplay 4030;
_list = _dialog displayCtrl 4031;

_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[4031,_item];

_comActionsCount = count DYN_RACE_COMMANDER_ENABLED_ACTIONS;
_textControl = _dialog displayctrl 4033;

_i= 0; for "_i" from 0 to (_comActionsCount - 1) do
{
	_action = DYN_RACE_COMMANDER_ENABLED_ACTIONS select _i;
	if(_action select 0 == _item) then
	{
		//array ["name",[racetyp1,racetyp2],damageEnabledthingy,"displayName","hint","cost",{script}]
		//DYN_RACE_COMMANDER_SELECTED_ACTION = _action;
		_name = _action select 3;
		_hint = _action select 4;
		_cost = _action select 5;
		_text = format ["Name: %1<br/>Cost: %2 points<br/>Description:%3", _name,  _cost, _hint];
		_textControl ctrlSetStructuredText parseText _text;
		
		// if(_cost > DYN_RACE_COMMANDER_RESOURCEPOINTS) then
		// {
			// //ermagad not enough points.
		// };
	};
};