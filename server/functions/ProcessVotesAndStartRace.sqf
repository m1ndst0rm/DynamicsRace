DYN_RACE_PROCESSING_VOTES = false;
DYN_RACE_ProcessVotesAndStartRace =
{
	"DYN_RACE_ProcessVotesAndStartRace" call DYN_RACE_Debug;
	DYN_RACE_PROCESSING_VOTES = true;
	_vehicleVotes = [];
	_raceVotes = [];
	{
		_vote = _x;
		_playerVehicleVote = _vote select 1;
		_playerRaceVote = _vote select 2;
		
		_vehicleVoteFound = false;
		for [ {_i = 0}, {_i < count _vehicleVotes}, {_i = _i + 1}] do
		{
			_vehicleVote = _vehicleVotes select _i;
			if(_vehicleVote select 0 == _playerVehicleVote) then
			{
				_vehicleVoteFound = true;
				_vehicleVote set [1, (_vehicleVote select 1) + 1];
				_vehicleVotes set [_i, _vehicleVote]; 
			};
		};
		if !(_vehicleVoteFound) then
		{
			_vehicleVote = [_playerVehicleVote, 1];
			_vehicleVotes set [count _vehicleVotes, _vehicleVote];
		};
		
	} forEach DYN_RACE_VOTES;
	
	_vehicleVotes = [_vehicleVotes, 1, "desc"] call KRON_ArraySort;
	_vehicleClassName = (_vehicleVotes select 0) select 0;
	format ["Starting race with vehicle: %1", _vehicleClassName] call DYN_RACE_Debug;
	[_vehicleClassName] call DYN_RACE_StartRace;
	DYN_RACE_VOTE_COUNTDOWN_STARTED = false;
	DYN_RACE_PROCESSING_VOTES = false;
};