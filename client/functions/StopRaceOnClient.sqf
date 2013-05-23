/* DYN_RACE_StopRaceOnClient: Stops a running race on a client.
* This function should NOT be called directly. Internal function.
*
*/
DYN_RACE_StopRaceOnClient =
{
	"DYN_RACE_StopRaceOnClient" call DYN_RACE_Debug;
	
	//Incase player hasn't stopped (didn't finish the race).
	[vehicle _player] spawn
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
	
	sleep 3;
	_winner_string = call DYN_RACE_GenerateWinnerString;

	_text = format["<t shadow='1' shadowColor='#006600' align='left' size='1'>%1</t>", _winner_string];
	[_text, -1, 0, 15, 0.2] spawn BIS_fnc_dynamicText;
	
	sleep 15;
	
	DYN_RACE_JIPPLAYER = false;
	
	[] spawn DYN_RACE_DisableSpectator;
	if((vehicle player) != player) then
	{
		_vehicle = (vehicle player);
		//_vehicle enableSimulation true;
		_vehicle setFuel 0;
		sleep 0.5;
		moveOut player;
	};
	//player enableSimulation true;
	_pos = [(getMarkerPos "respawn_west"), 0, 15, 0, 1, 50*(pi/180), 0] call BIS_fnc_findSafePos;
	player setPos _pos;
	player setcaptive false;
	hint "";
	sleep 10;
	systemChat "Pres 'v' to open the vote dialog.";
};