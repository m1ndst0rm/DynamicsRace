/* DYN_fnc_ProcessClientVote: Process client vote

*/
if (!isServer) exitWith {} ;
private ["_clientId","_voteType","_vote","_votePoint","_player_vote","_vote_array","_vote_array_point","_vote_array_vote","_maxVoteCount","_currentVoteCount","_racer_vote","_compareRacteType","_voteText"];
"DYN_fnc_ProcessClientVote" call BIS_fnc_log;
if(DYN_RACE_STATE == "IDLE") then
{
	_clientId = _this select 0;
	_voteType = _this select 1;
	_vote = _this select 2;
	
	//If for some reason someone votes after voting closes or when second vote starts.
	//if(DYN_RACE_VOTE_TYPE != _voteType) exitWith {} ;
	//TODO Eleminate old votes
	
	_votePoint = [DYN_RACE_VOTES, _clientId] call BIS_fnc_findNestedElement;
	_player_vote = [];
	if(count _votePoint == 0) then
	{
		_player_vote = [_clientId, [[_voteType, _vote]]];
		DYN_RACE_VOTES set [count DYN_RACE_VOTES, _player_vote];
	}
	else
	{
		_player_vote = DYN_RACE_VOTES select (_votePoint select 0);
		_vote_array = _player_vote select 1;
		
		_vote_array_point = [_vote_array, _vote] call BIS_fnc_findNestedElement;
		
		if(count _vote_array_point == 0) then
		{
			_vote_array set [count _vote_array, [_voteType, _vote]];
		}
		else
		{ //Change excisting vote
			_vote_array_vote = _vote_array select (_vote_array_point select 0);
			_vote_array_vote set [1, _vote];
			_vote_array set[(_vote_array_point select 0), _vote_array_vote];
		};
		_player_vote set [1, _vote_array];
		DYN_RACE_VOTES set [(_votePoint select 0), _player_vote];
	};
	

	_maxVoteCount = (if (isMultiplayer) then {{isPlayer _x}count playableUnits} else {1});
	
	_currentVoteCount = 0;
	
	{
		_racer_vote = _x;
		_vote_array = _racer_vote select 1;
		{
			_vote = _x;
			_compareRacteType = DYN_RACE_VOTE_TYPE;
			if!(DYN_RACE_VOTE_TYPE == "RACETYPE") then
			{
				if(!isNil {DYN_RACE_TYPE}) then
				{
					if(DYN_RACE_TYPE != "CAT&MOUSE") then
					{
						_compareRacteType = "VEHICLETYPE";
					};
				}
				else
				{
					_compareRacteType = "VEHICLETYPE";
				};
			};
			if(_vote select 0 == _compareRacteType) then
			{
				_currentVoteCount = _currentVoteCount + 1;
			};
		} foreach _vote_array;
	} foreach DYN_RACE_VOTES;
	
	
	
	if(_maxVoteCount == _currentVoteCount) then
	{
		[] call DYN_fnc_ProcessVotes;
	}
	else
	{
		if !(DYN_RACE_VOTE_COUNTDOWN_STARTED) then
		{
			[] spawn 
			{
				_voteText = " a racetype.";
				if(DYN_RACE_VOTE_TYPE != "RACETYPE") then
				{
					if(DYN_RACE_TYPE != "CAT&MOUSE") then
					{
						_voteText = " if damage should be enabled and to vote a race vehicle.";
					}
					else
					{
						_voteText = " if damage should be enabled.";
					};
				};
				DYN_RACE_VOTE_COUNTDOWN_STARTED = true;
				DYN_RACE_CHAT = "30 seconds left to vote" + _voteText;
				publicVariable "DYN_RACE_CHAT";
				if!(isDedicated) then
				{
					[] call DYN_fnc_OnChatChange;
				};
				sleep 15;
				
				if (!DYN_RACE_PROCESSING_VOTES && count DYN_RACE_TEAMS == 0) then
				{
					DYN_RACE_CHAT = "15 seconds left to vote" + _voteText;
					publicVariable "DYN_RACE_CHAT";
					if!(isDedicated) then
					{
						[] call DYN_fnc_OnChatChange;
					};
					sleep 15;
					DYN_RACE_CHAT = "";
					publicVariable "DYN_RACE_CHAT";
				};
				
				if (!DYN_RACE_PROCESSING_VOTES && DYN_RACE_STATE == "IDLE" && count DYN_RACE_TEAMS == 0) then
				{
					[] call DYN_fnc_ProcessVotes;
				};
			};
		};
	};
};