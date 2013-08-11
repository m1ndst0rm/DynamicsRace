/* DYN_fnc_OnPlayerDisconnect: Function which gets excecuted when a player disconnects. 
* Function checks wheter the player is a racer and removes him from the racers if so.
* This function is only called on the server
* TODO: Implement leaving when gunner / driver
*/
private ["_local_racers","_racer","_vehicle"];

"DYN_fnc_OnPlayerDisconnect" call BIS_fnc_log;
_id = _this select 0;
_name = _this select 1;
_uid = _this select 2;
_local_racers = DYN_RACE_Racers;
{
	_racer = _x;
	if(netId (_racer select 1) == _uid) then
	{
		_vehicle = (_racer select 2);
		deleteVehicle _vehicle;
		
		_local_racers = _local_racers - _racer;
	};
} forEach _local_racers;

DYN_RACE_Racers = _local_racers;
publicVariable "DYN_RACE_Racers";
[] call DYN_fnc_OnRacersChanged;

//Check if any players left else finish the race.
if(count DYN_RACE_Racers == 0) then
{
	if(DYN_RACE_STATE != "IDLE") then
	{
		DYN_RACE_STATE = "FINISHED";
		publicVariable "DYN_RACE_STATE";
		[] call DYN_fnc_OnRaceStateChanged;
	};
};