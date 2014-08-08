/* DYN_fnc_OnRaceStateChanged: Function called when the variable DYN_RACE_STATE switches state. 
*
*/
format ["Switching race state to %1", DYN_RACE_STATE] call BIS_fnc_log;
switch (DYN_RACE_STATE) do
{
	case "IDLE":
	{
	
	};
	case "INIT": 
	{
		if(isServer) then
		{
			if(isNil "DYN_RACE_VEHICLE") then
			{
				[] call DYN_fnc_LoadStartPositions;
			}
			else
			{
				[DYN_RACE_VEHICLE] call DYN_fnc_LoadStartPositions;
			};
			[] spawn DYN_fnc_InitRace;
		};
		if!(isDedicated) then
		{
			waitUntil {DYN_RACE_INITPREPDONE};
			if(player getVariable ["isCommander", false]) then
			{
				[] spawn DYN_fnc_ComInitialiseCommander;
			}
			else
			{	
				[] spawn DYN_fnc_InitRaceOnClient;
			};
		};
	};
	case "STARTING":
	{ //Countdown timer
		if(isServer) then
		{
			[] spawn DYN_fnc_StartRaceOnServer;
		};
		if!(isDedicated) then
		{
			if(player getVariable ["isCommander", false]) then
			{
				[] spawn DYN_fnc_ComStartRaceAsCommander;
			}
			else
			{
				[] spawn DYN_fnc_StartRaceOnClient;
			}
		};
	};
	case "ONGOING":
	{ 
		//Only called once when game starts
	};
	case "FINISHED":
	{
		if(isServer) then
		{
			[] spawn DYN_fnc_StopRaceOnServer;
		};
		if!(isDedicated) then
		{
			[] spawn DYN_fnc_StopRaceOnClient;
		};
	};
}; 