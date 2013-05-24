/* DYN_RACE_StartRaceOnClient: Starts the race on a client.
* This function should NOT be called directly. Internal function.
*
*/
DYN_RACE_StartRaceOnClient =
{
	"DYN_RACE_StartRaceOnClient" call DYN_RACE_Debug;
	systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";systemChat "";

	_firstWaypoint = (simpleTasks player) select 0;
	player setCurrentTask _firstWaypoint;
	_vehicle = vehicle player;
	_vehicle removemagazine "SmokeLauncherMag";

	sleep 5;
	
	for [{_i = 10},{_i>0}, {_i=_i-1}] do 
	{
		_text = format["<t align='center' valign='middle' size='1.8'>%1</t>", _i];
		[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
		
		if(_i <= 3) then
		{
			playSound "BEEP";
		};

		//hint format ["Race starting in:  %1", _i];
		sleep 1;
	};
	playSound "BEEP_HIGH";
	//Make sure the client waits untill the servers starts
	//waitUntil {!isNil {DYN_RACE_STARTTIME}};
    //waitUntil {!isNull DYN_RACE_STARTTIME};
	//Enable simultation so no delay
	//(vehicle player) enableSimulation true;
	_vehicle setFuel 1;
	_text = "<t align='center' valign='middle' size='2.0'>Go!</t>";
	[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
	waitUntil { DYN_RACE_STATE == "ONGOING" };
	[] spawn DYN_RACE_SpawnLocalTimer;
	[] spawn DYN_RACE_SpawnLocalRaceChecks;
	[] spawn DYN_RACE_SpawnLocalWeaponDir;
};