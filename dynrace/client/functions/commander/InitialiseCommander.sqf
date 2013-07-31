//Init player as commander
[] call DYN_RACE_SPEC_EnableSpectator;
player allowDamage false;

closeDialog 4000;
closeDialog 4010;
closeDialog 4020;

DYN_RACE_COMMANDER_SELECTED_ACTION = "";

_comActionsCount = count DYN_RACE_COMMANDER_ACTIONS;

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
		
		};
	};
	_enabled = true;
	
	if(_enabled) then
	{
		if(_enableForDamageTypes == "BOTH" || (_enableForDamageTypes == "ENABLED" && DYN_RACE_DAMAGE_ENABLED) || (_enableForDamageTypes == "DISABLED" && !DYN_RACE_DAMAGE_ENABLED)) then
		{
			//Create buttons plx
			//IDD_MAIN_MAP == 12
			//IDC_MAP = 51
			//(findDisplay IDD_MAIN_MAP) createDisplay 
			
		};
	};
};