//TODO Replace and test: _idx = addMissionEventHandler ["Draw3D",
//onEachFrame
addMissionEventHandler ["Draw3D", 
{
	if(DYN_RACE_STATE != "IDLE" && DYN_RACE_TYPE != "CAT&MOUSE") then
	{
		//Player names
		_racerCount = count DYN_RACE_RACERS;
		_i= 0; for "_i" from 0 to (_racerCount - 1) do
		{
			_racer = DYN_RACE_RACERS select _i;
			_player = _racer select 1;
			if(_player getVariable ["isDriver", false] && !(_player getVariable["isCop", false]) && vehicle player != vehicle _player) then
			{
				if(_player != player) then
				{
					_distance = _player distance player;
					
					if(_distance < 50) then
					{
						_textSize = (0.04) - (0.04 * _distance / 50);
						_player_name = "";
						
						if(DYN_RACE_TYPE == "DUAL" || DYN_RACE_TYPE == "TEAM" || DYN_RACE_TYPE == "TEAM3" || (DYN_RACE_TYPE == "COPS&ROBBERS")) then
						{
							_player_name = format["Team %1", (((_racer select 1) getVariable "teamNumber") + 1)];
						}
						else
						{
							if(_player getVariable ["isMouse",false]) then
							{
								_player_name = format["T%1 MOUSE", (((_racer select 1) getVariable "teamNumber") + 1), _racer select 0];
							}
							else
							{
								_player_name = format["T%1 %2", (((_racer select 1) getVariable "teamNumber") + 1), _racer select 0];
							};
						};
						
						if(DYN_RACE_TYPE == "SINGLE") then
						{
							_player_name = _racer select 0;
						};
						
						_vehicle = _racer select 2;
						_playerpos = visiblePosition _player;
						_playerpos = [_playerpos select 0, _playerpos select 1, (_playerpos select 2) + 2];
						
						drawIcon3D ["", [1,1,1,1], _playerpos, 0, 0, 0, _player_name, 0,_textSize];
					};
				};
			};
		};
	};
}];