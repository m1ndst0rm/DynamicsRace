/* DYN_fnc_SpawnLocalTimer: Spawns a local timer.
* Spawn a loop that displays the timer & finished players.
*/
private ["_timedif","_formatted_time","_message","_currentCheckpoint","_racerPosWeight","_racerCount","_i","_racer","_player","_currentCheckpointId","_laptTimes","_currentPosWeight","_racerPosWeightCount","_myPos","_obj","_finished_players","_playerName","_time","_didFinish","_finish_time","_text"];

"DYN_fnc_SpawnLocalTimer" call BIS_fnc_log;
[] spawn {
	
	disableSerialization;
	4050 cutRsc ["DYN_InfoDiag","PLAIN"]; 
	_uiObj = uiNamespace getVariable "DYN_INFODIAG";
	_textObject = _uiObj displayCtrl 4051;
	_positionObject = _uiObj displayCtrl 4052;
	_timeObject = _uiObj displayCtrl 4053;
	
	_textObject ctrlShow false;
	
	_robbers = [];
	{
		_racer = _x;
		_player = _racer select 1;
		
		if(_player getVariable ["isRobber", false]) then
		{
			if(_player getVariable ["isDriver", false]) then
			{
				_robbers set [count _robbers, _player];
			};
		};
	} foreach DYN_RACE_RACERS;
	
	
	
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		//TODO: Lap times 
		_timedif = DYN_RACE_ELAPSED_TIME;
		_formatted_time = [_timedif] call DYN_fnc_FormatTime;
		_timeObject ctrlSetStructuredText parseText _formatted_time;
		
		_message = "";
		if(player getVariable ["isCommander", false]) then
		{
			_message = format ["Commander Points: %1<br/><br/>", DYN_RACE_COMMANDER_RESOURCEPOINTS];
			if(count DYN_RACE_COMMANDER_SELECTED_ACTION > 0) then
			{
				_actionDescription= DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
				_actionCost = DYN_RACE_COMMANDER_SELECTED_ACTION select 3; 
				_message = _message + format ["Selected action: %2<br/>Cost: %1", _actionDescription, _actionCost];
			};
		};

		if(DYN_RACE_TYPE == "COPS&ROBBERS") then
		{
			_caughtCount = {_x getVariable ["isCaught", false]} count _robbers;
			
			_caughtMessage = format ["<t size='3'>%1</t><t size='1.5'>/%2 robbers caught</t>", _caughtCount,  count _robbers];
			_positionObject ctrlSetStructuredText parseText _caughtMessage;
		}
		else
		{
			_currentCheckpoint = (currentTask player);
			
			_racerPosWeight = [];
			_racerCount = count DYN_RACE_RACERS;
			_i= 0; for "_i" from 0 to (_racerCount - 1) do
			{
				_racer = DYN_RACE_RACERS select _i;
				_player = _racer select 1;
				if(!(_player getVariable ["isCop", false]) && !(_player getVariable ["isGunner", false]) && !(_player getVariable ["isCat", false])) then
				{
					_currentCheckpointId = _player getVariable "currentWaypointId";
					_laptTimes = _player getVariable ["lapTimes",[]];
					_currentPosWeight = (_currentCheckpointId * 10000) + ((count _laptTimes) * count DYN_RACE_CHECKPOINTS * 10000) + (_player getVariable ["previousWaypointDistance", 0]);
					_racerPosWeight set [count _racerPosWeight, [_player, _currentPosWeight]];
				};
			};
			
			_racerPosWeight = [_racerPosWeight, 1, "desc"] call KRON_ArraySort;
			
			_racerPosWeightCount = count _racerPosWeight;
			_myPos = -1;
			_i= 0; for "_i" from 0 to (_racerPosWeightCount - 1) do
			{
				_obj = _racerPosWeight select _i;
				_player = _obj select 0;
				
				if(_player == player || _player getVariable["teamNumber", -1] == player getVariable["teamNumber", -2]) then
				{
					_myPos = _i + 1;
				};
			};
			
			_pos = format ["<t size='3'>%1</t><t size='1.5'>/%2</t>", _myPos, _racerPosWeightCount];
			
			_positionObject ctrlSetStructuredText parseText _pos;
		};
		
		_finished_players = [1] call DYN_fnc_GetFinishArray;
		_finishedPlayersCount =  {_x select 2} count _finished_players;
		_displayCount = _finishedPlayersCount min 10;
		_curDisplay = 0;
		_i= 0; for "_i" from 0 to ((count _finished_players) - 1) do
		{
			_racer = _finished_players select _i;
			_playerName = _racer select 0;
			_time = _racer select 1;
			_didFinish = _racer select 2;
			
			if(_didFinish) then
			{
				if(_curDisplay < _displayCount) then
				{
					_message = _message + format["%1 - %2<br/>", _playerName, _time];
					_curDisplay = _curDisplay + 1;
				};
			};
		};
		
		if(_displayCount == 0 && !(player getVariable ["isCommander", false])) then
		{
			_textObject ctrlShow false;
		}
		else
		{
			_textObjectPos = ctrlPosition _textObject;
			_textObject ctrlShow true;
			_textObject ctrlSetPosition [_textObjectPos select 0, _textObjectPos select 1, _textObjectPos select 2, 0.5 + (_displayCount * 0.05)];
			_textObject ctrlSetStructuredText parseText format ["%1",_message];
			_textObject ctrlCommit 0;
		};

		sleep 1;
	};
	_textObject ctrlShow false;
	_positionObject ctrlShow false;
	_timeObject ctrlShow false;
	_uiObj closeDisplay 0;
};	