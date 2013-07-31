//Process a clients request to join a role in a team, and aknowlegde it if it's free. 
"ProcessTeamSpotChoose" call DYN_RACE_Debug;

_player = _this select 0;
_teamId = _this select 1;
_spotType = _this select 2;

waitUntil { !(DYN_RACE_LOCK_TEAMS) };

if(DYN_RACE_STATE == "IDLE") then
{
	DYN_RACE_LOCK_TEAMS = true;

	_currentTeamId = _player getVariable ["teamNumber", -1];
	if(_currentTeamId != -1) then
	{ //Remove player from current selected pos.
		_currentTeam = DYN_RACE_TEAMS select _currentTeamId;
		_spotTypes = _currentTeam select 1;
		_teamPlayers = _currentTeam select 2;
		{
			_spot = _x;
			_players = _spot select 2;
			_players = _players - [_player];
			_spot set [2, _players];
		} foreach _spotTypes;
		
		_teamPlayers = _teamPlayers - [_player];
		
		_currentTeam set [1, _spotTypes];
		_currentTeam set [2, _teamPlayers];
		_player setVariable ["teamNumber", -1, true];
		DYN_RACE_TEAMS set [_currentTeamId, _currentTeam];
		
		diag_log "Publishing new teams";
		diag_log DYN_RACE_TEAMS;
		publicVariable "DYN_RACE_TEAMS";
		[] spawn DYN_RACE_OnTeamsChanged;
	};

	_global_changed = false;
	_team = DYN_RACE_TEAMS select _teamId;
	_i = 0;

	_teamPlayers = _team select 2;
	_spotTypes = _team select 1;
	{
		_spot = _x;
		_spotName = _spot select 0;
		_spots = _spot select 1;
		_players = _spot select 2;
		if(_spotName == _spotType) then
		{
			if(count _players < _spots) then
			{
				_players set [count _players, _player];
				_teamPlayers set [count _teamPlayers, _player];
				_player setVariable ["teamNumber", _teamId, true];
				_global_changed = true;
				_spot set [2, _players];
			};
		};
		_spotTypes set[_i, _spot];
		_i = _i + 1;
	} foreach _spotTypes;

	if(_global_changed) then
	{
		//Publish new teams.
		
		_team set [1, _spotTypes];
		_team set [2, _teamPlayers];
		DYN_RACE_TEAMS set [_teamId, _team];
		
		publicVariable "DYN_RACE_TEAMS";
		if!(isDedicated) then
		{
			[] spawn DYN_RACE_OnTeamsChanged;
		};
		if!(DYN_RACE_TEAMCHOOSE_COUNTDOWN_STARTED) then
		{
			DYN_RACE_TEAMCHOOSE_COUNTDOWN_STARTED = true;
			[] spawn 
			{
				DYN_RACE_CHAT = "30 seconds to choose a team and role.";
				publicVariable "DYN_RACE_CHAT";
				if!(isDedicated) then
				{
					[] call DYN_RACE_OnChatChange;
				};
				sleep 15;
				DYN_RACE_CHAT = "15 seconds to choose a team and role.";
				publicVariable "DYN_RACE_CHAT";
				if!(isDedicated) then
				{
					[] call DYN_RACE_OnChatChange;
				};
				sleep 10;
				DYN_RACE_CHAT = "5 seconds to choose a team and role.";
				publicVariable "DYN_RACE_CHAT";
				if!(isDedicated) then
				{
					[] call DYN_RACE_OnChatChange;
				};
				sleep 5;
				[] call DYN_RACE_StartRace;
			};
		};
	};
	DYN_RACE_LOCK_TEAMS = false;
};