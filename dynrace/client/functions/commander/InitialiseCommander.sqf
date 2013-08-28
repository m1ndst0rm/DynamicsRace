//Init player as commander
private ["_comActionsCount","_i","_action","_enableForRaceTypes","_enableForDamageTypes","_enabled"];
DYN_RACE_COMDIALOG_OPEN = false;

//Wait for racers to be fully initialized. Gives some time to watch the teams.
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
			DYN_RACE_COMMANDER_ENABLED_ACTIONS set [count DYN_RACE_COMMANDER_ENABLED_ACTIONS, _action];
		};
	};
};

[] call DYN_fnc_AddTeamMarkers;