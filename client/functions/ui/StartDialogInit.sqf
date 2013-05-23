/* DYN_RACE_StartDialogInit: Init and display the start diaglog
* 
*/
DYN_RACE_StartDialogInit = 
{
	"DYN_RACE_StartDialogInit" call DYN_RACE_Debug;
	private["_dialog","_list","_vehicles","_name","_veh","_pic"];
	disableSerialization;
	_dialog = findDisplay 4000;
	_list = _dialog displayCtrl 4001;
	lbClear _list;

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