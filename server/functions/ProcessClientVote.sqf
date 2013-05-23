/* DYN_RACE_ProcessClientVote: Process client vote

*/
DYN_RACE_VOTE_COUNTDOWN_STARTED = false;
DYN_RACE_ProcessClientVote =
{
	"DYN_RACE_ProcessClientVote" call DYN_RACE_Debug;
	if(DYN_RACE_STATE == "IDLE") then
	{
		_clientId = _this select 0;
		_vehicleClass = _this select 1;
		_race = _this select 2;
		
		_vote = [_clientId, _vehicleClass, _race];
		DYN_RACE_VOTES set [count DYN_RACE_VOTES, _vote];
		
		_maxVoteCount = (if (isMultiplayer) then {count playableUnits} else {1});
		
		if(_maxVoteCount == count DYN_RACE_VOTES) then
		{
			[] call DYN_RACE_ProcessVotesAndStartRace;
		}
		else
		{
			if !(DYN_RACE_VOTE_COUNTDOWN_STARTED) then
			{
				[] spawn 
				{
					DYN_RACE_VOTE_COUNTDOWN_STARTED = true;
					DYN_RACE_CHAT = "30 seconds left to vote.";
					publicVariable "DYN_RACE_CHAT";
					[] call DYN_RACE_OnChatChange;
					
					sleep 15;
					
					if !(DYN_RACE_PROCESSING_VOTES) then
					{
						DYN_RACE_CHAT = "15 seconds left to vote.";
						publicVariable "DYN_RACE_CHAT";
						[] call DYN_RACE_OnChatChange;
						sleep 15;
						DYN_RACE_CHAT = "";
						publicVariable "DYN_RACE_CHAT";
					};
					
					if !(DYN_RACE_PROCESSING_VOTES && DYN_RACE_STATE == "IDLE") then
					{
						[] call DYN_RACE_ProcessVotesAndStartRace;
					};
				};
			};
		};
	};
};