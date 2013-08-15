/*
	Author: M1nd0

	Description:
	Initialises the race on a client. Closes dialogs, adds handlers

	Parameter(s):

	Returns:
*/
private ["_firstWaypoint","_vehicle"];

DYN_RACE_PLAYER_FINISHED = false;
_firstWaypointId = 0;
if(DYN_RACE_LAPS == 1) then
{
	_firstWaypointId = 1;
};
_firstWaypoint = (simpleTasks player) select _firstWaypointId;
player setCurrentTask _firstWaypoint;
player setVariable ["currentWaypointId", _firstWaypointId, true];

waitUntil { (!isNull(player getVariable ["vehicle", objNull])) || player getVariable ["isSpectator",false]};

closeDialog 4000;
closeDialog 4010;
closeDialog 4020;
DYN_VOTEDIALOG_OPEN = false;

cutText  ["", "BLACK OUT", 1];
sleep 1;

if(player getVariable ["isSpectator",false]) then
{
	[] call DYN_fnc_EnableSpectator;
}
else
{
	_vehicle = player getVariable "vehicle";
	if(player getVariable ["isDriver", false]) then
	{
		player moveInDriver _vehicle;
		DYN_RACE_HANLDER_RESET = (finddisplay 46) displayAddEventHandler ["keydown", "if ((_this select 1) == 19) then {[] call DYN_fnc_ResetVehicle;};"];
		//DYN_RACE_HANLDER_TURBOKEYPRESS = (finddisplay 46) displayAddEventHandler ["keydown", "_this call DYN_fnc_TurboKeyPress;"];
		//DYN_RACE_HANLDER_TURBOKEYRELEASE = (finddisplay 46) displayAddEventHandler ["keyup", "_this call DYN_fnc_TurboKeyRelease;"];
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

	[_vehicle, DYN_RACE_DAMAGE_MULTIPLIER] call DYN_fnc_SetVehicleDamageHandler;

	if(_vehicle getVariable ["isCop", false]) then
	{
		//_vehicle call DYN_fnc_SetAsCopVehicle;
	};
	
	if(DYN_RACE_TYPE == "CAT&MOUSE") then
	{
		[] call DYN_fnc_AddTeamMarkers;
	};
};
cutText  ["", "BLACK IN", 1];