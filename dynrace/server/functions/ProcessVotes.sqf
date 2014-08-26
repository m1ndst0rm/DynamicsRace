if (!isServer) exitWith {} ;
private ["_all_votes","_vote_type","_voteCount","_i","_pVoteArray","_player_votes","_player_vote","_player_vote_type","_player_vote_vote","_typeVotes","_votes","_voteIndex","_startRace","_startTeamVote","_vehicleClassName","_wonRaceType","_voteAmount","_damageVote","_damage","_message","_vehicleVote","_vehicle","_vehicleName"];
"DYN_fnc_ProcessVotes" call BIS_fnc_log;
DYN_RACE_PROCESSING_VOTES = true;

d_fnc_getVoteWinner =
{
	//Return array with list of votes + count.
	_all_votes = [];
	_vote_type = _this;

	//[["",["RACETYPE","SINGLE"]]]
	_voteCount = count DYN_RACE_VOTES;
	_i = 0; for "_i" from 0 to (_voteCount - 1) do
	{
		
		//["",["RACETYPE","SINGLE"]]
		_pVoteArray = (DYN_RACE_VOTES select _i);
		_player_votes = _pVoteArray select 1;
		
		{
			//["RACETYPE","SINGLE"]
			_player_vote = _x;
			_player_vote_type = _player_vote select 0;
			_player_vote_vote = _player_vote select 1;
			if(_player_vote_type == _vote_type) then
			{
				_all_votes set [count _all_votes, _player_vote_vote];
			};
		} foreach _player_votes;
	};

	_typeVotes = [];
	
	{
		_player_vote = _x;
		_votes = [];
		_voteIndex = [_typeVotes, _player_vote] call BIS_fnc_findNestedElement;
	
		if(count _voteIndex != 0) then
		{
			_votes = _typeVotes select (_voteIndex select 0);
			_votes set [1, (_votes select 1) + 1];
			_typeVotes set [(_voteIndex select 0), _votes];
		}
		else
		{
			_votes = [_player_vote, 1];
			_typeVotes set [count _typeVotes, _votes];
		};
	} foreach _all_votes;
	
	_typeVotes = [_typeVotes, 1, "desc"] call KRON_ArraySort;

	_typeVotes select 0;
};
_vote_type = DYN_RACE_VOTE_TYPE;
_startRace = false;
_startTeamVote = false;

_vehicleClassName = "";
switch (_vote_type) do
{
	case "RACETYPE":
	{
		_wonRaceType = "RACETYPE" call d_fnc_getVoteWinner;
		DYN_RACE_TYPE = _wonRaceType select 0;
		_voteAmount =  _wonRaceType select 1;
		DYN_RACE_EXTRA_COM = false;
		if(DYN_RACE_TYPE == "COPS&ROBBERS&COMMANDER") then
		{
			DYN_RACE_TYPE = "COPS&ROBBERS";
			DYN_RACE_EXTRA_COM = true;		
		};
		if(DYN_RACE_TYPE == "CAT&MOUSE&COMMANDER") then
		{
			DYN_RACE_TYPE = "CAT&MOUSE";
			DYN_RACE_EXTRA_COM = true;
		};
		
		
		publicVariable "DYN_RACE_TYPE";
		if(DYN_RACE_TYPE != "COPS&ROBBERS") then
		{
			DYN_RACE_VOTE_TYPE = "DAMAGETYPE";
			DYN_RACE_VOTE_TYPE_CLIENT = DYN_RACE_VOTE_TYPE;
			publicVariable "DYN_RACE_VOTE_TYPE_CLIENT";
		}
		else
		{
			_vehicleClassName = DYN_RACE_OFFROAD_CLASS;
			DYN_RACE_DAMAGE_ENABLED = true;
			publicVariable "DYN_RACE_DAMAGE_ENABLED";
			_startTeamVote = true;
		};
		
		{
			if(_x select 0 == DYN_RACE_TYPE) then
			{
				DYN_RACE_CHAT = format["%1 won the vote with %2 votes.", _x select 1, _voteAmount];
			};
		} foreach DYN_RACE_TYPES;
		
		publicVariable "DYN_RACE_TYPE";
	};
	case "DAMAGETYPE":
	{ 
		_damageVote = "DAMAGETYPE" call d_fnc_getVoteWinner;
		_damage = _damageVote select 0;
		_message = "";
		if(_damage == "enabled") then
		{
			DYN_RACE_DAMAGE_ENABLED = true;
			_message = "Damage is enabled. ";
		}
		else
		{
			DYN_RACE_DAMAGE_ENABLED = false;
			_message = "Damage is disabled. ";
		};
		publicVariable "DYN_RACE_DAMAGE_ENABLED";
		if(DYN_RACE_TYPE != "CAT&MOUSE") then
		{
			_vehicleVote = "VEHICLETYPE" call d_fnc_getVoteWinner;

			_vehicle = "";
			if(isNil {_vehicleVote} ) then
			{
				//Set a random vehicle based on race type or extending voting time?
				if(DYN_RACE_TYPE == "SINGLE") then
				{
					_vehicle = DYN_RACE_AVAILABLE_VEHICLES_SINGLE select (floor (random count DYN_RACE_AVAILABLE_VEHICLES_SINGLE));
				}
				else
				{
					_vehicle = DYN_RACE_AVAILABLE_VEHICLES_SINGLE select (floor (random count DYN_RACE_AVAILABLE_VEHICLES_DUAL));
				};
			}
			else
			{
				_vehicle = _vehicleVote select 0;
			};
		
			_vehicleClassName = _vehicle;
			_vehicleName = getText(configFile >> "CfgVehicles" >> _vehicleClassName >> "displayname");
			_message = _message + format ["And the racecar will be a %1.", _vehicleName];
			DYN_RACE_VEHICLE = _vehicleClassName;
		};

		DYN_RACE_CHAT = _message;
		
		_startTeamVote = true;
		if(DYN_RACE_TYPE == "SINGLE") then
		{
			_startRace = true;
		};
	};
};
publicVariable "DYN_RACE_CHAT";

if!(isDedicated) then
{
	[] spawn DYN_fnc_OnChatChange;
};

DYN_RACE_VOTE_COUNTDOWN_STARTED = false;
DYN_RACE_PROCESSING_VOTES = false;
if(_startTeamVote) then
{
	[] call DYN_fnc_CreateTeams;
};
if(_startRace) then
{
	[] call DYN_fnc_StartRace;
};