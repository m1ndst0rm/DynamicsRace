//Creates teams of current online players and publishes them to clients.
//["Name",[spotname, amount,[players], spottype],[players]]; //Players refereced double because of easier access.
private ["_total_racers","_teams","_i","_teamName","_team","_unevenPlayers","_robbers","_cops","_commanders","_racers","_chasers"];

DYN_RACE_TEAMS = [];
//_units = 
_total_racers = (if (isMultiplayer) then {{!(_x getVariable ["isSpectator", false])} count playableUnits} else {count switchableUnits});

switch (DYN_RACE_TYPE) do
{
	case "SINGLE":
	{
		_teams = _total_racers;
		
		_i= 0; for "_i" from 0 to (_teams - 1) do
		{
			_teamName = format ["Team %1", _i + 1];
			_team = [_teamName, [["DRIVER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
	};
	case "DUAL":
	{
		_teams = floor (_total_racers / 2);
		_i= 0; for "_i" from 0 to (_teams - 1) do
		{
			_teamName = format ["Team %1", _i + 1];
			_team = [_teamName, [["DRIVER", 1,[]],["GUNNER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
		
		if(_total_racers % 2 != 0) then
		{ //Uneven teams =(
			// teamName = "Commander";
			// _team = [_teamName, [["COMMANDER", 1,[]]],[]];
			// DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			teamName = "Commanders";
			_team = [_teamName, [["COMMANDER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
	};
	case "TEAM":
	{
		_teams = floor (_total_racers / 2);
		_i= 0; for "_i" from 0 to (_teams - 1) do
		{
			_teamName = format ["Team %1", _i + 1];
			_team = [_teamName, [["DRIVER", 1,[]],["COMMANDER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
		
		if(_total_racers % 2 != 0) then
		{ //Uneven teams =(
			teamName = "Commander";
			_team = [_teamName, [["COMMANDER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
	};
	case "TEAM3":
	{
		_teams = floor (_total_racers / 3);
		_i= 0; for "_i" from 0 to (_teams - 1) do
		{
			_teamName = format ["Team %1", _i + 1];
			_team = [_teamName, [["DRIVER", 1,[]],["GUNNER", 1,[]],["COMMANDER", 1,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
		
		_unevenPlayers = _total_racers % 3;
		
		if(_unevenPlayers != 0) then
		{
			//_unevenPlayers
			_teamName = "Commanders";
			_team = [_teamName, [["COMMANDER", 2,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
	};
	case "COPS&ROBBERS":
	{
		if(DYN_RACE_EXTRA_COM) then
		{
			//Robbers & Cops
			_robbers = round(_total_racers / 5); //(1 robber team (2p) per 5 players
			_cops = floor(_total_racers / 2 ); //2 cops per robber
			_commanders = _total_racers - (_robbers * 2) - _cops; //1 com per robber team
			_i= 0; for "_i" from 0 to (_robbers - 1) do
			{
				_teamName = format ["Robbers team %1", _i + 1];
				_team = [_teamName, [["ROBBER", 1,[]],["GUNNER",1,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
			
			_teamName = format ["Cops", _i + 1];
			_team = [_teamName, [["COP", _cops,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			
			if(_commanders > 0) then
			{
				_teamName = format ["Commanders", _i + 1];
				_team = [_teamName, [["COMMANDER", _commanders,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
		}
		else
		{
			_robbers = round(_total_racers / 4); //(1 robber team (2p) per 4 players
			_cops = _total_racers - (_robbers * 2);  //2 cops per robber
			_i= 0; for "_i" from 0 to (_robbers - 1) do
			{
				_teamName = format ["Robbers team %1", _i + 1];
				_team = [_teamName, [["ROBBER", 1,[]],["GUNNER",1,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
			
			_teamName = format ["Cops", _i + 1];
			_team = [_teamName, [["COP", _cops,[]]],[]];
			DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		};
	};
	case "CAT&MOUSE":
	{
		if(DYN_RACE_EXTRA_COM) then
		{
			_teams = floor (_total_racers / 4);
			_unevenPlayers = _total_racers % 4;
			
			_i= 0; for "_i" from 0 to (_teams - 1) do
			{
				_teamName = format ["Team %1", _i + 1];
				_commanders = 1;
				if(_i < _unevenPlayers) then
				{
					_commanders = 2;
				};
				_team = [_teamName, [["MOUSE", 1,[]],["CAT", 2,[]],["COMMANDER", _commanders,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
		}
		else
		{
			//Each team has Cat & 2 mice = 3 drivers.
			_teams = floor (_total_racers / 3);
			_i= 0; for "_i" from 0 to (_teams - 1) do
			{
				_teamName = format ["Team %1", _i + 1];
				_team = [_teamName, [["MOUSE", 1,[]],["CAT", 2,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
			
			_unevenPlayers = _total_racers % 3;
			
			if(_unevenPlayers != 0) then
			{
				//_unevenPlayers
				//_teamName = "Commanders";
				//_team = [_teamName, [["COMMANDER", 2,[]]],[]];
				//DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
				_teamName = "Commanders";
				_team = [_teamName, [["COMMANDER", _unevenPlayers,[]]],[]];
				DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
			};
		};
	};
	case "HELICHASE":
	{
		_racers = round(_total_racers / 3 * 2); //(1 robber team (2p) per 5 players
		_chasers = _total_racers - _racers;  //2 cops per robber
		
		_teamName = "Fugitives";
		_team = [_teamName, [["ROBBER", _racers,[]]],[]];
		DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
		
		_teamName = "Heli chasers";
		_team = [_teamName, [["HELI", _chasers,[]]],[]];
		DYN_RACE_TEAMS set [count DYN_RACE_TEAMS, _team];
	};
};
publicVariable "DYN_RACE_TEAMS";
if(DYN_RACE_TYPE != "SINGLE") then
{
	[[],"DYN_fnc_TeamSelectionDialog", true] call BIS_fnc_MP;
};