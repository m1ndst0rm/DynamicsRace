/* DYN_fnc_VoteDialogInit: Init and display the Vote diaglog
* 
*/
private ["_dialog","_list","_raceType","_raceName","_vehicles","_veh","_pic"];
"DYN_fnc_VoteDialogInit" call BIS_fnc_log;
private["_dialog","_list","_vehicles","_name","_veh","_pic"];
disableSerialization;

_dialog = findDisplay 4000;
_list = _dialog displayCtrl 4001;
lbClear _list;

switch (DYN_RACE_VOTE_TYPE_CLIENT) do
{
	case "RACETYPE":
	{
		_total_racers = (if (isMultiplayer) then {{!(_x getVariable ["isSpectator", false])} count playableUnits} else {count switchableUnits});
		ctrlSetText [4002, "Vote racetype"];
		{
			_raceType = _x select 0;
			_raceName = _x select 1;
			_minPlayers = _x select 3;

			if(_total_racers >= _minPlayers) then
			{
				_list lbAdd format["%1",_raceName];
				_list lbSetData [(lbSize _list)-1,_raceType];
				ctrlShow [4001,true];
			};
		} foreach DYN_RACE_TYPES;
	};
	case "DAMAGETYPE":
	{
		ctrlSetText [4002, "Vote damage"];
		_list lbAdd "Enable damage";
		_list lbSetData [(lbSize _list)-1,"enabled"];
		
		_list lbAdd "Disable damage";
		_list lbSetData [(lbSize _list)-1,"disabled"];
		ctrlShow [4001,true];
	};
	case "VEHICLETYPE":
	{
		ctrlSetText [4002, "Vote vehicle"];
		_vehicles = [] call DYN_fnc_GetAvailableVehiclesFromConfig;
		{
			_name = _x select 0;
			_veh = _x select 1;
			_pic = _x select 2;
			_list lbAdd format["%1",_name];
			_list lbSetPicture [(lbSize _list)-1,_pic];
			_list lbSetData [(lbSize _list)-1,_veh];
			
			ctrlShow [4001,true];
		} foreach _vehicles;
	};
};