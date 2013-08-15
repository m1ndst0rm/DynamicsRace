/* DYN_fnc_StartRaceOnServer: Starts the race on the server.
* This function should NOT be called directly. Internal function.
*
*/
if (!isServer) exitWith {};
private ["_racer_count","_i","_racer","_player","_mustWait","_sleep"];
"DYN_fnc_StartRaceOnServer" call BIS_fnc_log;
//10 second countdown
sleep 10;

DYN_RACE_STARTTIME = diag_tickTime;
publicVariable "DYN_RACE_STARTTIME";

//TODO: FIX server side vehicle enabling?
_racer_count = count DYN_RACE_RACERS;

for [ {_i = 0}, {_i < _racer_count}, {_i = _i + 1}] do
{
	_racer = DYN_RACE_RACERS select _i;
	_player = _racer select 1;
	
	
	_mustWait = false;
	
	if(DYN_RACE_TYPE == "COPS&ROBBERS" || DYN_RACE_TYPE == "CAT&MOUSE") then
	{
		_mustWait = true;
	};
	
	if ((_player getVariable ["isRobber", false]) ||
	(_player getVariable ["isMouse", false]) ||
	(_player getVariable ["isGunner", false])) then
	{
		_mustWait = false;
	};
	
	if!(_mustWait) then
	{
		_racer set [5, true];
		DYN_RACE_RACERS set [_i, _racer];
	};
};

//This call actually makes sure the players vehicle is enabled.
DYN_RACE_STATE = "ONGOING";
[] spawn DYN_fnc_SpawnServerRaceChecks;

publicVariable "DYN_RACE_STATE";
publicVariable "DYN_RACE_RACERS";

[] call DYN_fnc_OnRaceStateChanged;
[] call DYN_fnc_OnRacersChanged;

_sleep = 10;
if(DYN_RACE_TYPE == "CAT&MOUSE") then
{
	_sleep = 5;
};
sleep _sleep;
for [ {_i = 0}, {_i < _racer_count}, {_i = _i + 1}] do
{
	_racer = DYN_RACE_RACERS select _i;
	_racer set [5, true];
	DYN_RACE_RACERS set [_i, _racer];
};

publicVariable "DYN_RACE_RACERS";
[] call DYN_fnc_OnRacersChanged;