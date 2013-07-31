/* DYN_RACE_StartRaceOnClient: Starts the race on a client.
* This function should NOT be called directly. Internal function.
*
*/
"DYN_RACE_StartRaceOnClient" call DYN_RACE_Debug;
sleep 5;

[] spawn
{
	waitUntil { DYN_RACE_STATE == "ONGOING" };
	[] spawn DYN_RACE_SpawnLocalTimer;
	
	if!(player getVariable ["isSpectator",false]) then
	{
		[] spawn DYN_RACE_SpawnLocalRaceChecks;
		
		if(DYN_RACE_TYPE == "DUAL") then
		{
			[] spawn DYN_RACE_SpawnLocalWeaponDir;
		};
	};
};
_wait = 0;
if(DYN_RACE_TYPE == "COPS&ROBBERS" || DYN_RACE_TYPE == "CAT&MOUSE") then
{
	_mustWait = true;
	if ((player getVariable ["isRobber", false]) ||
	(player getVariable ["isMouse", false]) ||
	(player getVariable ["isGunner", false])) then
	{
		_mustWait = false;
	};
	
	if(_mustWait) then
	{
		_text = "<t align='center' valign='middle' size='1.8'>Robbers get a 10 second headstart</t>";
		_wait = 10;
		if(DYN_RACE_TYPE == "CAT&MOUSE") then
		{
			_text = "<t align='center' valign='middle' size='1.8'>Mice get a 5 second headstart</t>";
			_wait = 5;
		};
		
		[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	};
};

for [{_i = 10 + _wait},{_i>0}, {_i=_i-1}] do 
{
	_text = format["<t align='center' valign='middle' size='1.8'>%1</t>", _i];
	[_text, -1, -1, 2, 0.2] spawn BIS_fnc_dynamicText;
	
	if(_i <= 3) then
	{
		playSound "BEEP";
	};
	sleep 1;
};
playSound "BEEP_HIGH";
//Make sure the client waits untill the servers starts
//waitUntil {!isNil {DYN_RACE_STARTTIME}};
//waitUntil {!isNull DYN_RACE_STARTTIME};
//Enable simultation so no delay
//(vehicle player) enableSimulation true;
_text = "<t align='center' valign='middle' size='2.0'>Go!</t>";
[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;

if!(player getVariable ["isSpectator",false]) then
{
	_vehicle = vehicle player;
	_vehicle setFuel 1;
	
	sleep 20;
	if(player getVariable ["isGunner", false]) then
	{
		_text = "<t align='center' valign='middle' size='2.0'>Guns unlocked!</t>";
		[_text, -1, -1, 1, 0.2] spawn BIS_fnc_dynamicText;
	};
	_vehicle call DYN_RACE_GunUnLock;
};