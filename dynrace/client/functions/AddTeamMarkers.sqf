/* Adds collors above teams (green friendly, red enemy or colorteam in cats&mouse).


*/
_pType = [_this, 0, "isDriver"] call bis_fnc_param;

_myTeamNumber = player getVariable "teamNumber";
{
	_racer = _x;
	_player = _x select 1;
	_vehicle = _x select 2;
	if(_player != player && _player getVariable [_pType, false]) then
	{
		_arrowClass = "";
		if(DYN_RACE_TYPE == "CAT&MOUSE") then
		{
			_arrowClass = DYN_RACE_CATROBBERSCOLOR select (_player getVariable "teamNumber");
		}
		else
		{
			_arrowClass = if(_player getVariable "teamNumber" == _myTeamNumber) then {"Sign_Arrow_Large_Green_F"} else {"Sign_Arrow_Large_F"};
		};
		
		_indicator = _arrowClass createVehicleLocal [0,0,0];
		
		_BBR = boundingBoxReal _vehicle;
		_Dim1 = _BBR select 0;
		_Dim2 = _BBR select 1;
		//_maxWidth = abs ((_Dim2 select 0) - (_Dim1 select 0));
		//_maxLength = abs ((_Dim2 select 1) - (_Dim1 select 1));
		_maxHeight = abs ((_Dim2 select 2) - (_Dim1 select 2));
		
		_indicator attachTo [_vehicle,[0,0,(_maxHeight / 2)]];
	};
} foreach DYN_RACE_RACERS;