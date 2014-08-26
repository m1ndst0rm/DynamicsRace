/*
	Author: M1nd0

	Description:
	Initialises the race on a client. Closes dialogs, adds handlers

	Parameter(s):

	Returns:
*/
private ["_firstWaypoint","_vehicle"];
"DYN_fnc_InitRaceOnClient" call BIS_fnc_log;

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

	_addSmoke = false;
	if(DYN_RACE_TYPE == "SINGLE") then { _addSmoke = true; };
	if(DYN_RACE_TYPE == "COPS&ROBBERS" && (player getVariable "isDriver") && (player getVariable "isRobber")) then { _addSmoke = true; }; 
	if(DYN_RACE_TYPE == "CAT&MOUSE" && (player getVariable "isMouse")) then { _addSmoke = true; };
	
	if(_addSmoke) then
	{
		DYN_RACE_LOCAL_SMOKE_ACTION = (vehicle player) addAction [format ["Deploy smokescreen (%1 left)",DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT], "dynrace\client\actions\SmokeScreen.sqf",[], 0, false];
	};

	[_vehicle, DYN_RACE_DAMAGE_MULTIPLIER] call DYN_fnc_SetVehicleDamageHandler;

	if(player getVariable ["isCop", false]) then
	{
		_vehicle addAction ["Sirens On",{(_this select 0) animate ["BeaconsStart",1]},[],50,false,true,"","_target animationPhase 'BeaconsStart' < 0.5 AND Alive(_target) AND driver _target == _this"];
		_vehicle addAction ["Sirens Off",{(_this select 0) animate ["BeaconsStart",0]},[],51,false,true,"","_target animationPhase 'BeaconsStart' > 0.5 AND Alive(_target) AND driver _target == _this"]; 
	};
	
	if(DYN_RACE_TYPE == "CAT&MOUSE") then
	{
		[] call DYN_fnc_AddTeamMarkers;
	};
	if(DYN_RACE_TYPE == "CAT&MOUSE" || DYN_RACE_TYPE == "COPS&ROBBERS" || DYN_RACE_TYPE == "CAT&MOUSE&COMMANDER" || DYN_RACE_TYPE == "COPS&ROBBERS&COMMANDER") then
	{
		[] call DYN_fnc_DisplayHelp;
	};
};
cutText  ["", "BLACK IN", 1];

if(player getVariable ["isDriver", false]) then
{
	_text = "<t align='center' valign='middle' size='1.8'>Damage is disabled, press R to reset!</t>";
	if(DYN_RACE_DAMAGE_ENABLED) then
	{
		_text = "<t align='center' valign='middle' size='1.8'>Damage is enabled, press R to reset!</t>";
	};
	[_text, -1, -1, 4, 0.2] spawn BIS_fnc_dynamicText;
};
if(player getVariable ["isGunner", false]) then
{
	_text = "<t align='center' valign='middle' size='1.8'>Weapons disabled for the first 20 seconds!</t>";
	[_text, -1, -1, 4, 0.2] spawn BIS_fnc_dynamicText;
};