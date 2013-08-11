/* DYN_fnc_StartRace: Call to start a race. 
* This function can be called on server to start the race
*
* Params:
* _race_vehicle: Classname of the vehicle used for the racer
*/
private ["_race_vehicle"];
"DYN_fnc_StartRace" call BIS_fnc_log;

DYN_RACE_STATE = "INIT";
publicVariable "DYN_RACE_STATE";

[] spawn DYN_fnc_OnRaceStateChanged;