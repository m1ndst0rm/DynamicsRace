/* DYN_RACE_SpawnLocalTimer: Spawns a local timer.
* Spawn a loop that displays the timer & finished players.
*/
"DYN_RACE_SpawnLocalTimer" call DYN_RACE_Debug;
[] spawn {
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{		
		//TODO: Lap times 
		_timedif = DYN_RACE_ELAPSED_TIME;
		_formatted_time = [_timedif] call DYN_RACE_FormatTime;
		
		
		_message ="";
		if(player getVariable ["isCommander", false]) then
		{
			_message = format ["Commander Points: %1\n\n", DYN_RACE_COMMANDER_RESOURCEPOINTS];
		};
		_message = format ["%1%2\n\n", _message,_formatted_time];

		_finished_players = [1] call DYN_RACE_GetFinishArray;
		
		{
			_racer = _x;
			_playerName = _racer select 0;
			_time = _racer select 1;
			_didFinish = _racer select 2;
			
			//_finish_time = [_racer] call DYN_RACE_GetRacerFinishedTime;
			//_formatted_time = [_finish_time] call DYN_RACE_FormatTime;
			if(_didFinish) then
			{
				_message = _message + format["%1 - %2\n", _playerName, _time];
			};
		} forEach _finished_players;
			
		hintSilent _message;
		//_text = format["<t align='center' size='1'>t%1</t>",_message];
		//[_text, safezoneX + 0.1 * safezoneW, safezoneY + safezoneW - 0.3, 1, 0] spawn BIS_fnc_dynamicText;	
		sleep 1;
	};
	hint "";
};	