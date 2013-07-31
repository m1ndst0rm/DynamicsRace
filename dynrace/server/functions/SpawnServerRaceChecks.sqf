#define DYN_RACE_SLEEP_FINISHCHECK 0.1
#define DYN_RACE_SLEEP_COPCHECK 1
if (!isServer) exitWith {};

[] spawn{
	while {DYN_RACE_STATE == "ONGOING"} do
	{
		DYN_RACE_ELAPSED_TIME = diag_tickTime - DYN_RACE_STARTTIME;
		publicVariable "DYN_RACE_ELAPSED_TIME";
		sleep 1;
	};
};

[] spawn {
//Finish check
	while {DYN_RACE_STATE == "ONGOING"} do
	{
		_pCount = count DYN_RACE_RACERS;
		_i= 0; for "_i" from 0 to (_pCount - 1) do
		{
			_racer = DYN_RACE_RACERS select _i;
			_player = _racer select 1;
			if !(_player getVariable ["hasFinished", false]) then
			{
				if(_player getVariable ["isDriver", false]) then
				{
					if!(_player getVariable ["isCop", false] || _player getVariable ["isCat", false]) then
					{
						_lapTimes = _player getVariable ["laptTimes", []];
						if(count _lapTimes != DYN_RACE_LAPS) then
						{
							if!(_player getVariable ["prosessingFinish", false]) then
							{
								_finished = [DYN_RACE_FINISHTRIGGER, _player] call DYN_RACE_InTrigger;
								if(_finished) then
								{
									diag_log "Calling p finished";
									[_player] call DYN_RACE_PlayerFinished;
								};
							};
						};
					};
				};
			};
		};
		sleep DYN_RACE_SLEEP_FINISHCHECK;
	};
};

if(DYN_RACE_TYPE == "COPS&ROBBERS") then
{
	[] spawn {
		_cops = []; _robbers = [];
		{
			_racer = _x;
			_player = _racer select 1;
			if(_player getVariable ["isCop", false]) then
			{
				_cops set [count _cops, _racer select 2];
			};
			
			if(_player getVariable ["isRobber", false]) then
			{
				if(_player getVariable ["isDriver", false]) then
				{
					_robbers set [count _robbers, [_player, 0]];
				};
			};
		} foreach DYN_RACE_RACERS;
		_copsCount = count _cops;
		_robbersCount = count _robbers;
		waitUntil { DYN_RACE_ELAPSED_TIME > 30 };
		_speedCheck = DYN_RACE_ROBBER_SPEEDLIMIT + 1;
		_distanceLimit = DYN_RACE_ROBBER_DISTANCELIMIT + 1;
		while {DYN_RACE_STATE == "ONGOING"} do
		{
			_i= 0; for "_i" from 0 to (_robbersCount - 1) do
			{
				_robberArray = _robbers select _i;
				_robber = _robberArray select 0;
				_robberPoliceNearTime = _robberArray select 1;
				_robberSpeed = speed _robber;
				if(speed _robber < _speedCheck && _robberSpeed > (_speedCheck * -1)) then
				{
					_copNear = false;
					_j= 0; for "_j" from 0 to (_copsCount - 1) do
					{
						_cop = _cops select _j;

						if(_cop distance _robber < _distanceLimit) then
						{
							_robberPoliceNearTime = _robberPoliceNearTime + DYN_RACE_SLEEP_COPCHECK;
							_copNear = true;
						};
					};
					
					if!(_copNear) then
					{
						_robberPoliceNearTime = 0;
					};
				}
				else
				{
					_robberPoliceNearTime = 0;
				};
				_robberArray set [1, _robberPoliceNearTime];
				_robbers set [_i, _robberArray];
				
				if(_robberPoliceNearTime > DYN_RACE_ROBBER_TIMELIMIT && !(_robber getVariable ["isCaught", false])) then
				{	//Caught
					_teamNumber = _robber getVariable ["teamNumber", -1];

					_robber setVariable ["isCaught", true, true];
					_players = [_robber];
					if(_teamNumber != -1) then
					{
						_team = DYN_RACE_TEAMS select _teamNumber;
						_players = _team select 2;
					};
					
					if(isMultiplayer || {(player == _robber)}) then
					{
						[_players,"DYN_RACE_Finished",_players] spawn BIS_fnc_MP;
					};
					
					if ({((_x select 0) getVariable ["isCaught", false] || (_x select 0) getVariable ["hasFinished", false])} count _robbers == count _robbers) then
					{//All
						//End race with cops as winners
						DYN_RACE_STATE = "FINISHED";
						publicVariable "DYN_RACE_STATE";

						[] call DYN_RACE_OnRaceStateChanged;
					}
					else
					{//Just one, broadcast message
						diag_log format ["Teamno %1 got caught.", _teamNumber];
						_teamName = [_teamNumber, 1] call DYN_RACE_GetTeamName;
						DYN_RACE_DISPLAYMESSAGE = format["%1 got caught!", _teamName];
						publicVariable "DYN_RACE_DISPLAYMESSAGE";

						[] call DYN_RACE_OnDisplayMessageChanged;
					};
				};
			};
			
			sleep DYN_RACE_SLEEP_COPCHECK;
		};
	};
}; 