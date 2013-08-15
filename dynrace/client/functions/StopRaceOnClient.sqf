/* DYN_fnc_StopRaceOnClient: Stops a running race on a client.
* This function should NOT be called directly. Internal function.
*
*/
private ["_vehicle","_speed","_diff","_vel","_dir"];
"DYN_fnc_StopRaceOnClient" call BIS_fnc_log;

(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANLDER_RESET];
(finddisplay 46) displayRemoveEventHandler ["keydown", DYN_RACE_HANLDER_TURBOKEYPRESS];
(finddisplay 46) displayRemoveEventHandler ["keyup", DYN_RACE_HANLDER_TURBOKEYRELEASE];

//Incase player hasn't stopped (didn't finish the race).
if(player getVariable ["isDriver",false]) then
{
	[vehicle player] spawn
	{
		_vehicle = _this select 0;
		_speed = speed _vehicle;
		while{ (_speed > 1) } do 
		{
			_diff = 0.02;
			_vel = velocity _vehicle;
			_dir = getDir _vehicle;
			_vehicle setVelocity [(_vel select 0)-(sin _dir*_diff),(_vel select 1)-(cos _dir*_diff),(_vel select 2)];
			_speed = speed _vehicle;
			sleep 0.01;
		};
		
		//_vehicle enableSimulation false;
		_vehicle setFuel 0;
		_vehicle engineOn false;
	};
};
sleep 3;
titleCut ["", "BLACK OUT", 1];
[false] call DYN_fnc_DisableSpectator;
sleep 1;
if((vehicle player) != player) then
{
	moveOut player;
};
sleep 0.1;

_pos = [(getMarkerPos "respawn_west"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
player setPos _pos;

hint "";

titleCut ["", "BLACK IN", 2];

disableSerialization;
createDialog "DYN_ScoreBoardDiag";

waitUntil {DYN_RACE_STATE == "IDLE"};

DYN_RACE_JIPPLAYER = false;
player setVariable ["JIPPLAYER", false, true];