disableSerialization;
_dialog = findDisplay 4010;
_list = _dialog displayCtrl 4011;

_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[4011,_item];

_spotlist = _dialog displayCtrl 4013;
_selectedIndex = Lbselection _spotlist select 0;
if(isNil {_selectedIndex}) then {_selectedIndex = 0;};

lbClear _spotlist;
if !(isNil {_item}) then 
{
	_team = DYN_RACE_TEAMS select (parseNumber _item);
	
	_teamSpots = _team select 1;
	{
		_teamSpot = _x;
		_spotType = _teamSpot select 0;
		_spotAmount = _teamSpot select 1;
		_players = _teamSpot select 2;
		_spotName = "";
		
		switch (_spotType) do
		{
			case "DRIVER":
			{
				_spotName = "Racer";
			};
			case "ROBBER":
			{
				_spotName = "Driver";
			};
			case "COP":
			{
				_spotName = "Cop";
			};
			case "MOUSE":
			{
				_spotName = "Mouse";
			};
			case "CAT":
			{
				_spotName = "Cat";
			};
			case "GUNNER":
			{
				_spotName = "Gunner";
			};
			case "COMMANDER":
			{
				_spotName = "Commander";
			};
			case "HELI":
			{
				_spotName = "Chopper pilot";
			};
			case "SPECTATOR":
			{
				_spotName = "Specator";
			};
		};
		
		_i= 0; for "_i" from 0 to (_spotAmount - 1) do
		{
			_wholeName = format ["%1 %2", _spotName, _i + 1];
			if(count _players >= (_i + 1)) then
			{
				_name = name (_players select _i);
				_wholeName = format ["%1: %2",_wholeName, _name];
			}
			else
			{
				_wholeName = format ["%1: Empty",_wholeName];
			};
			
			_spotlist lbAdd format["%1",_wholeName];
			_spotlist lbSetData [(lbSize _spotlist)-1,_spotType];
		};
	} foreach _teamSpots;
};
_spotlist lbSetSelected [_selectedIndex, true];