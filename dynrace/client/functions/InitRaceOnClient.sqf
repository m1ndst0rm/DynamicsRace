systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";

DYN_RACE_PLAYER_FINISHED = false;
_firstWaypoint = (simpleTasks player) select 0;
player setCurrentTask _firstWaypoint;

closeDialog 4000;
closeDialog 4010;
closeDialog 4020;

cutText  ["", "BLACK OUT", 1];
sleep 1;

waitUntil { (!isNull(player getVariable ["vehicle", objNull])) || player getVariable ["isSpectator",false]};

if(player getVariable ["isSpectator",false]) then
{
	[] spawn DYN_RACE_SPEC_EnableSpectator;
}
else
{
	_vehicle = player getVariable "vehicle";
	if(player getVariable ["isDriver", false]) then
	{
		player moveInDriver _vehicle;
		//DYN_RACE_HANLDER_TURBOSTART = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 17 || (_this select 1 == 200)) then { [] call DYN_RACE_TurboStart; };"];
		//DYN_RACE_HANLDER_TURBOSTOP = (finddisplay 46) displayAddEventHandler ["keyup", "if ((_this select 1) == 17 || (_this select 1 == 200)) then { [] call DYN_RACE_TurboStop; }; "];
	};
	if(player getVariable ["isGunner", false]) then
	{
		player moveInGunner _vehicle;
	};

	if(DYN_RACE_TYPE == "SINGLE" || 
	(DYN_RACE_TYPE == "COPS&ROBBERS" && player getVariable "isDriver" && player getVariable "isRobber") ||
	(DYN_RACE_TYPE == "CAT&MOUSE" && player getVariable "isMouse")) then
	{
		DYN_RACE_LOCAL_SMOKE_ACTION = _vehicle addAction [format ["Deploy smokescreen (%1 left)",DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT], "dynrace\client\actions\SmokeScreen.sqf",[], 0, false];
	};

	_vehicle addEventHandler ["HandleDamage", {_this call DYN_RACE_OnVehicleHit}];

	if(_vehicle getVariable ["isCop", false]) then
	{
		//_vehicle call DYN_RACE_SetAsCopVehicle;
	};
};
cutText  ["", "BLACK IN", 1];