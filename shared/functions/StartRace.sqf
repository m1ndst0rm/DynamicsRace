/* DYN_RACE_StartRace: Call to start a race. 
* This function can be called on any client connected to the server, or the server self. Should only be called ONCE (So not on each client & server).
*
* Params:
* _race_vehicle: Classname of the vehicle used for the racer
*/
DYN_RACE_StartRace = 
{
	"DYN_RACE_Start" call DYN_RACE_Debug;
	_race_vehicle = _this select 0;
	DYN_RACE_VEHICLE = _race_vehicle;
	DYN_RACE_STATE = "INIT";
	//Client starts race so sync vars to server
	publicVariableServer "DYN_RACE_VEHICLE";
	publicVariableServer "DYN_RACE_STATE";
	
	//TODO: Eval why we even implemented this.
	if(isServer && !(isMultiplayer)) then
	{
		[] spawn DYN_RACE_OnRaceStateChanged;
	};
};