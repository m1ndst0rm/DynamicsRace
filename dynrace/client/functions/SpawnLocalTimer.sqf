/* DYN_fnc_SpawnLocalTimer: Spawns a local timer.
* Spawn a loop that displays the timer & finished players.
*/
#define DYN_RACE_LOOPTIMER 1
#define DYN_RACE_LOOPCOMMANDER 1
#define DYN_RACE_LOOPPOSITION 0.2

private ["_timedif","_formatted_time","_message","_currentCheckpoint","_racerPosWeight","_racerCount","_i","_racer","_player","_currentCheckpointId","_laptTimes","_currentPosWeight","_racerPosWeightCount","_myPos","_obj","_finished_players","_playerName","_time","_didFinish","_finish_time","_text"];

"DYN_fnc_SpawnLocalTimer" call BIS_fnc_log;
disableSerialization;
4050 cutRsc ["DYN_InfoDiag","PLAIN"]; 

	//Disable textobject, will be enabled when commander
_uiObj = uiNamespace getVariable "DYN_INFODIAG";
_textObject = _uiObj displayCtrl 4051;
_textObject ctrlShow false;

[] spawn {
	disableSerialization;
	_uiObj = uiNamespace getVariable "DYN_INFODIAG";

	_timeObject = _uiObj displayCtrl 4053;
	
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		//TODO: Lap times 
		_timedif = DYN_RACE_ELAPSED_TIME;
		_formatted_time = [_timedif] call DYN_fnc_FormatTime;
		_timeObject ctrlSetStructuredText parseText format ["<t align='left'>TIME<t><t align='right'>%1<t>", _formatted_time];
		sleep DYN_RACE_LOOPTIMER;
	};
	sleep 1;
	_timeObject ctrlShow false;
	_uiObj closeDisplay 0;
};	
//Commander



if(player getVariable ["isCommander", false]) then
{
	[] spawn 
	{
		disableSerialization;
		_uiObj = uiNamespace getVariable "DYN_INFODIAG";
		_textObject = _uiObj displayCtrl 4051;
		_textObject ctrlShow true;

		_timeObject = _uiObj displayCtrl 4053;
		
		_positionObject = _uiObj displayCtrl 4052;
		_positionObjectPosition = ctrlPosition _positionObject ;
		_positionObjectPosition set [1, (_positionObjectPosition select 1) - 0.2];
		_positionObject ctrlSetPosition _positionObjectPosition;
		_positionObject ctrlCommit 0;
		
		_i= 0; for "_i" from 0 to 5 do
		{
			_posText = _uiObj displayCtrl (4060 + _i);
			_posTextPosition = ctrlPosition _posText ;
			_posTextPosition set [1, (_posTextPosition select 1) - 0.2];
			_posText ctrlSetPosition _posTextPosition;
			_posText ctrlCommit 0;
			
			_posNumber = _uiObj displayCtrl (4070 + _i);
			_posNumberPosition = ctrlPosition _posNumber ;
			_posNumberPosition set [1, (_posNumberPosition select 1) - 0.2];
			_posNumber ctrlSetPosition _posNumberPosition;
			_posNumber ctrlCommit 0;
		};
		
		_timeObjectPosition = ctrlPosition _timeObject ;
		_timeObjectPosition set [1, (_timeObjectPosition select 1) - 0.2];
		_timeObject ctrlSetPosition _timeObjectPosition;
		_timeObject ctrlCommit 0;
			
		while{ (DYN_RACE_STATE == "ONGOING") } do 
		{
			_message = format ["Commander Points: %1<br/><br/>", DYN_RACE_COMMANDER_RESOURCEPOINTS];
			if(count DYN_RACE_COMMANDER_SELECTED_ACTION > 0) then
			{
				_actionDescription= DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
				_actionCost = DYN_RACE_COMMANDER_SELECTED_ACTION select 3; 
				_message = _message + format ["Selected action: %2<br/>Cost: %1", _actionDescription, _actionCost];
			};
			 _textObject ctrlSetStructuredText parseText format ["%1",_message];

			sleep DYN_RACE_LOOPCOMMANDER;
		};
		
		_positionObject = _uiObj displayCtrl 4052;
		_positionObjectPosition = ctrlPosition _positionObject ;
		_positionObjectPosition set [1, (_positionObjectPosition select 1) + 0.2];
		_positionObject ctrlSetPosition _positionObjectPosition;
		_positionObject ctrlCommit 0;
		
		_i= 0; for "_i" from 0 to 5 do
		{
			_posText = _uiObj displayCtrl (4060 + _i);
			_posTextPosition = ctrlPosition _posText ;
			_posTextPosition set [1, (_posTextPosition select 1) + 0.2];
			_posText ctrlSetPosition _posTextPosition;
			_posText ctrlCommit 0;
			
			_posNumber = _uiObj displayCtrl (4070 + _i);
			_posNumberPosition = ctrlPosition _posNumber ;
			_posNumberPosition set [1, (_posNumberPosition select 1) + 0.2];
			_posNumber ctrlSetPosition _posNumberPosition;
			_posNumber ctrlCommit 0;
		};
		
		_timeObjectPosition = ctrlPosition _timeObject ;
		_timeObjectPosition set [1, (_timeObjectPosition select 1) + 0.2];
		_timeObject ctrlSetPosition _timeObjectPosition;
		_timeObject ctrlCommit 0;
		
		_textObject ctrlShow false;
		
	};
};
//Position & positions

if(DYN_RACE_TYPE == "COPS&ROBBERS") then
{
	disableSerialization;
	_uiObj = uiNamespace getVariable "DYN_INFODIAG";
	
	_i= 0; for "_i" from 0 to 5 do
	{
		_posText = _uiObj displayCtrl (4060 + _i);
		_posText ctrlShow false;
		
		_posNumber = _uiObj displayCtrl (4070 + _i);
		_posNumber ctrlShow false;
	};
};

[] spawn 
{
	disableSerialization;
	_uiObj = uiNamespace getVariable "DYN_INFODIAG";
	_positionObject = _uiObj displayCtrl 4052;
	
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
	
	_maxShowOriginal = if (DYN_RACE_TYPE == "CAT&MOUSE") then {6} else {4};
	_myTeamNumber = player getVariable["teamNumber", -2];
	_myTeam = DYN_RACE_TEAMS select _myTeamNumber;
	
	while{ (DYN_RACE_STATE == "ONGOING") } do 
	{
		//_timeCheck = diag_tickTime;
		if(DYN_RACE_TYPE == "COPS&ROBBERS") then
		{
			_caughtCount = {_x getVariable ["isCaught", false]} count _robbers;
			
			_caughtMessage = format ["<t size='3'>%1</t><t size='1.5'>/%2 robbers caught</t>", _caughtCount,  count _robbers];
			_positionObject ctrlSetStructuredText parseText _caughtMessage;
		}
		else
		{		
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
			//diag_log _racerPosWeight;
			_racerPosWeightCount = count _racerPosWeight;
			_myPos = -1;
			
			_i= 0; for "_i" from 0 to (_racerPosWeightCount - 1) do
			{
				_obj = _racerPosWeight select _i;
				_player = _obj select 0;
				
				if(_player == player || _player getVariable["teamNumber", -1] == _myTeamNumber) then
				{
					_myPos = _i + 1;
				};
			};
			
			_pos = format ["<t size='3'>POS %1</t><t size='1.5'>/%2</t>", _myPos, _racerPosWeightCount];
			_positionObject ctrlSetStructuredText parseText _pos;
			
			_ranking = [];
			_maxShow = _maxShowOriginal min _racerPosWeightCount;
			
			if(DYN_RACE_TYPE == "CAT&MOUSE") then
			{
				_i= 0; for "_i" from 0 to (_maxShow -1) do
				{
					_racer = (_racerPosWeight select _i) select 0;
					_racer setVariable ["pos",_i + 1];
					_ranking set [_i, _racer];
				};
			}
			else
			{
				_p1 = (_racerPosWeight select 0) select 0;
				
				if(_myPos == 1) then
				{//We are first, r
					_ranking set [0, player];
					player setVariable ["pos",1];
					_i= 1; for "_i" from 0 to (_maxShow - 1) do
					{
						_racer = (_racerPosWeight select _i) select 0;
						_racer setVariable ["pos",_i + 1];
						_ranking set [_i, _racer];
					};
				}
				else
				{
					_ranking set [0, _p1];
					_p1 setVariable ["pos",1];
					if(_myPos == 2) then
					{
						_ranking set [1, player];
						player setVariable ["pos",2];
						
						_i= 2; for "_i" from 0 to (_maxShow -1) do
						{
							_racer = (_racerPosWeight select _i) select 0;
							_racer setVariable ["pos",_i+1];
							_ranking set [_i, _racer];
						};
					}
					else
					{
						if(_myPos != _racerPosWeightCount) then
						{
							_beforeMe = (_racerPosWeight select (_myPos - 2) select 0); //-2 is because myPos is readable no and no 0 for pos 1.
							_afterMe = (_racerPosWeight select (_myPos)) select 0; 

							_ranking set [1, _beforeMe];
							_beforeMe setVariable ["pos",_myPos -1];
							_ranking set [2, player];
							player setVariable ["pos",_myPos];
							_ranking set [3, _afterMe];
							_afterMe setVariable ["pos",_myPos + 1];
						}
						else
						{	//Last
							_p2 = (_racerPosWeight select 1) select 0; 
							_ranking set [1, _p2];
							_p2 setVariable ["pos",2];
							
							_beforeMe = (_racerPosWeight select (_myPos - 2)) select 0; //-2 is because myPos is readable no and no 0 for pos 1.
							_ranking set [2, _beforeMe];
							_beforeMe setVariable ["pos",_myPos - 1];
							_ranking set [3, player];
							player setVariable ["pos",_myPos];
						};
					};
				};
			};
			
			_larger = ({_x getVariable "pos" > 9} count _ranking > 0);
			_multiplier = if(_larger) then {0.04} else {0.03};
			_i= 0; for "_i" from 0 to 5 do
			{
				_posText = _uiObj displayCtrl (4060 + _i);
				_posNumber = _uiObj displayCtrl (4070 + _i);
				_show = _i < _maxShow;
				_posNumber ctrlShow _show;
				_posText ctrlShow _show;
				if(_show) then
				{
					_player = _ranking select _i;
					_tName = [_player, 1] call DYN_fnc_GetTeamName;
					_finishTime = [_player] call DYN_fnc_GetRacerFinishedTime;
					_finishTimeString = "";
					if(_finishTime != -1) then
					{
						//diag_log "Finish time";
						//diag_log _finishTime;
						_timeString = [_finishTime] call DYN_fnc_FormatTime;
						_finishTimeString = format [": %1",_timeString];
					};
					
					_displayText = format ["%1%2", _tName, _finishTimeString];
					_posText ctrlSetText _displayText;
					_posNumber ctrlSetText format["%1",(_player getVariable "pos")];
					
					_numberColor = if (_player == player || (_player getVariable "teamNumber" == _myTeamNumber) || _i == 0) then {[0.75, 0.75, 0.75, 1]} else {[0.45, 0.45, 0.45, 1]};
					_textColor = if (_player == player || (_player getVariable "teamNumber" == _myTeamNumber)) then {[0.75, 0.75, 0.75, 1]} else {[0.45, 0.45, 0.45, 1]};
					
					_numberBackgroundColor = [0,0,0,1];
					_textBackgroundColor = [0.2,0.2,0.2,1];
					if(DYN_RACE_TYPE == "CAT&MOUSE" && (_player == player || (_player getVariable "teamNumber" == _myTeamNumber))) then
					{
						_numberBackgroundColor = DYN_RACE_CATROBBERSCOLORCODES select _myTeamNumber;
						_textBackgroundColor = _numberBackgroundColor;
						
						_numberColor = [0,0,0,1];
						_textColor = [0,0,0,1];
					};
					
					_posNumber ctrlSetBackgroundColor _numberBackgroundColor;
					_posText ctrlSetBackgroundColor _textBackgroundColor;
					
					_posNumber ctrlSetTextColor _numberColor;
					_posText ctrlSetTextColor _textColor;
					
					_posTextPosition = ctrlPosition _posText;
					_posNumberPosition = ctrlPosition _posNumber;
					
					_posTextPosition set [0, safezoneX + safezoneW - 0.32 + _multiplier];
					_posTextPosition set [2, 0.28 - _multiplier];
					
					_posNumberPosition set [2, _multiplier];
					
					_posText ctrlSetPosition _posTextPosition;
					_posText ctrlCommit 0;
					_posNumber ctrlSetPosition _posNumberPosition;
					_posNumber ctrlCommit 0;
				};
			};
		};
		
		//diag_log format ["Loop in: %1 ms", diag_tickTime - _timeCheck];
		
		sleep DYN_RACE_LOOPPOSITION;
	};
	
	_positionObject ctrlShow false;
	_i= 0; for "_i" from 0 to 5 do
	{
		_posNumber = _uiObj displayCtrl (4060 + _i);
		_posText = _uiObj displayCtrl (4070 + _i);
		_posNumber ctrlShow false;
		_posText ctrlShow false;
	};
};