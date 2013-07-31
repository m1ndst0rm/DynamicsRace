/* DYN_RACE_StartRaceOnServer: Starts the race on the server.
* This function should NOT be called directly. Internal function.
*
*/
if (!isServer) exitWith {};
"DYN_RACE_StartRaceOnServer" call DYN_RACE_Debug;
sleep 15;

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
[] spawn DYN_RACE_SpawnServerRaceChecks;

publicVariable "DYN_RACE_STATE";
publicVariable "DYN_RACE_RACERS";

[] call DYN_RACE_OnRaceStateChanged;
[] call DYN_RACE_OnRacersChanged;

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
[] call DYN_RACE_OnRacersChanged;