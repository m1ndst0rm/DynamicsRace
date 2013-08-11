private ["_dialog","_scoreList","_finish_array","_finish_array_count","_myPos","_i","_score","_placeString"];
disableSerialization;

_dialog = findDisplay 4020;
_scoreList = _dialog displayCtrl 4021;
lnbClear _scoreList;

_finish_array = [0] call DYN_fnc_GetFinishArray;
_finish_array_count = count _finish_array;
_myPos = -1;
_i= 0; for "_i" from 0 to (_finish_array_count - 1) do
{
	_score = _finish_array select _i;
	
	if(_score select 3 == player getVariable ["teamNumber", -1]) then
	{
		_myPos = _i;
	};
	
	_placeString = "";
	switch (_i) do
	{
		case 0:
		{
			_placeString = "1st";
		};
		case 1:
		{
			_placeString = "2nd";
		};
		case 2:
		{
			_placeString = "3rd";
		};
		default
		{
			_placeString = format["%1th", _i + 1];
		};
	};

	if!(_score select 2) then
	{
		_placeString = " ";
	};
	_scoreList lnbAddRow [_placeString, (_score select 0), (_score select 1)];
};
lnbSetCurSelRow [4021, _myPos];