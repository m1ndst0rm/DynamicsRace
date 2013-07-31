/* DYN_RACE_VoteDialogInit: Init and display the Vote diaglog
* 
*/
"DYN_RACE_VoteDialogInit" call DYN_RACE_Debug;
private["_dialog","_list","_vehicles","_name","_veh","_pic"];
disableSerialization;

_dialog = findDisplay 4000;
_list = _dialog displayCtrl 4001;
lbClear _list;

switch (DYN_RACE_VOTE_TYPE_CLIENT) do
{
	case "RACETYPE":
	{
		ctrlSetText [4002, "Vote racetype"];
		{
			_raceType = _x select 0;
			_raceName = _x select 1;
			

			_list lbAdd format["%1",_raceName];
			_list lbSetData [(lbSize _list)-1,_raceType];
			ctrlShow [4001,true];
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
		_vehicles = [] call DYN_RACE_GetAvailableVehiclesFromConfig;
		{
			_name = _x select 0;
			_veh = _x select 1;
			_pic = _x select 2;
			//diag_log format["Adding Name: %1 - Class: %2 - Pic: %3",_name,_veh,_pic];
			_list lbAdd format["%1",_name];
			_list lbSetPicture [(lbSize _list)-1,_pic];
			_list lbSetData [(lbSize _list)-1,_veh];
			
			ctrlShow [4001,true];
		} foreach _vehicles;
	};
};