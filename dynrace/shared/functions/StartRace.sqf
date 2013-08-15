/* DYN_fnc_StartRace: Call to start a race. 
* This function can be called on server to start the race
*
*/
"DYN_fnc_StartRace" call BIS_fnc_log;

DYN_RACE_CHAT = "Preparing race...";
publicVariable "DYN_RACE_CHAT";
if!(isDedicated) then
{
	[] call DYN_fnc_OnChatChange;
};

DYN_RACE_STATE = "INIT";
publicVariable "DYN_RACE_STATE";

[] spawn DYN_fnc_OnRaceStateChanged;