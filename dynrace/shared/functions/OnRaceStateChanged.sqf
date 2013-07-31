/* DYN_RACE_OnRaceStateChanged: Function called when the variable DYN_RACE_STATE switches state. 
*
*/
format ["Switching race state to %1", DYN_RACE_STATE] call DYN_RACE_Debug;
switch (DYN_RACE_STATE) do
{
	case "IDLE":
	{
	
	};
	case "INIT": 
	{
		if(isServer) then
		{
			[] call DYN_RACE_InitRace;
		};
		if!(isDedicated) then
		{
			if(player getVariable ["isCommander", false]) then
			{
				[] spawn DYN_RACE_COM_InitialiseCommander;
			}
			else
			{	
				[] spawn DYN_RACE_InitRaceOnClient;
			};
		};
	};
	case "STARTING":
	{ //Countdown timer
		if(isServer) then
		{
			[] spawn DYN_RACE_StartRaceOnServer;
		};
		if!(isDedicated) then
		{
			if(player getVariable ["isCommander", false]) then
			{
				[] spawn DYN_RACE_COM_StartRaceAsCommander;
			}
			else
			{
				[] spawn DYN_RACE_StartRaceOnClient;
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
			diag_log "Spawn race stop on server";
			[] spawn DYN_RACE_StopRaceOnServer;
		};
		if!(isDedicated) then
		{
			diag_log "Spawn race stop on client";
			[] spawn DYN_RACE_StopRaceOnClient;
		};
	};
}; 