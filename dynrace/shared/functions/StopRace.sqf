/* DYN_RACE_STOP: Stops a running race
* This function can be called on any client connected to the server, or the server self.
*
*/
"DYN_RACE_Stop" call BIS_fnc_log;
DYN_RACE_STATE = "FINISHED";
publicVariableServer "DYN_RACE_STATE";

if(isServer && !(isMultiplayer)) then
{
	[] spawn DYN_fnc_OnRaceStateChanged;
};