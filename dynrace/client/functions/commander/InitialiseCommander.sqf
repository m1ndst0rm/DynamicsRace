//Init player as commander
private ["_comActionsCount","_i","_action","_enableForRaceTypes","_enableForDamageTypes","_enabled"];
player allowDamage false;
DYN_RACE_COMDIALOG_OPEN = false;
closeDialog 4000;
closeDialog 4010;
closeDialog 4020;

[] call DYN_fnc_EnableSpectator;
[0,-1] call DYN_fnc_SwitchPlayer;

DYN_RACE_COMMANDER_SELECTED_ACTION = [];
_comActionsCount = count DYN_RACE_COMMANDER_ACTIONS;
DYN_RACE_COMMANDER_ENABLED_ACTIONS = [];
DYN_RACE_COMPROCESSINGACTION = false;
_i= 0; for "_i" from 0 to (_comActionsCount - 1) do
{
	_action = DYN_RACE_COMMANDER_ACTIONS select _i;
	_enableForRaceTypes = _action select 1;
	_enableForDamageTypes = _action select 2;
	
	_enabled = false;
	if(count _enableForRaceTypes != 0) then
	{
		if(DYN_RACE_TYPE in _enableForRaceTypes) then
		{
			_enabled = true;
		};
	}
	else
	{
		_enabled = true;
	};
	if(_enabled) then
	{
		if(_enableForDamageTypes == "BOTH" || (_enableForDamageTypes == "ENABLED" && DYN_RACE_DAMAGE_ENABLED) || (_enableForDamageTypes == "DISABLED" && !DYN_RACE_DAMAGE_ENABLED)) then
		{
			//Create buttons plx
			//IDD_MAIN_MAP == 12
			//IDC_MAP = 51
			//(findDisplay IDD_MAIN_MAP) createDisplay 
			DYN_RACE_COMMANDER_ENABLED_ACTIONS set [count DYN_RACE_COMMANDER_ENABLED_ACTIONS, _action];
		};
	};
};

_myTeamNumber = player getVariable "teamNumber";
{
	_racer = _x;
	_player = _x select 1;
	_vehicle = _x select 2;
	if(_player != player && _player getVariable ["isDriver", false]) then
	{
		_arrowClass = if(_player getVariable "teamNumber" == _myTeamNumber) then {"Sign_Arrow_Large_Green_F"} else {"Sign_Arrow_Large_F"};
		_indicator = _arrowClass createVehicleLocal [0,0,0];
		
		_BBR = boundingBoxReal _vehicle;
		_Dim1 = _BBR select 0;
		_Dim2 = _BBR select 1;
		_maxWidth = abs ((_Dim2 select 0) - (_Dim1 select 0));
		_maxLength = abs ((_Dim2 select 1) - (_Dim1 select 1));
		_maxHeight = abs ((_Dim2 select 2) - (_Dim1 select 2));
		
		_indicator attachTo [_vehicle,[0,0,(_maxHeight / 2)]];
	};
} foreach DYN_RACE_RACERS;