disableSerialization;
_dialog = findDisplay 4010;
_list = _dialog displayCtrl 4011;

_selectedIndex = Lbselection _list select 0;
if(isNil {_selectedIndex}) then {_selectedIndex = 0;};

lbClear _list;

//Teamz plx
_teamCount = count DYN_RACE_TEAMS;
_i= 0; for "_i" from 0 to (_teamCount - 1) do
{
	_team = DYN_RACE_TEAMS select _i;
	_teamId = format["%1", _i];
	_teamName = _team select 0;
	
	_list lbAdd format["%1",_teamName];
	_list lbSetData [(lbSize _list)-1, _teamId];
};

_list lbSetSelected [_selectedIndex, true];