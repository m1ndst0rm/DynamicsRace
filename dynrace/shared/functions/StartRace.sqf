/* DYN_RACE_StartRace: Call to start a race. 
* This function can be called on server to start the race
*
* Params:
* _race_vehicle: Classname of the vehicle used for the racer
*/
"DYN_RACE_StartRace" call DYN_RACE_Debug;

DYN_RACE_STATE = "INIT";
publicVariable "DYN_RACE_STATE";

[] spawn DYN_RACE_OnRaceStateChanged;