//TODO Replace and test: _idx = addMissionEventHandler ["Draw3D",
//onEachFrame
addMissionEventHandler ["Draw3D", 
{
	if(DYN_RACE_STATE == "ONGOING" || DYN_RACE_STATE == "INIT" ||  DYN_RACE_STATE == "STARTING") then
	{
		//Player names
		{
			_racer = _x;
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
		} foreach DYN_RACE_RACERS;
		// if(player getVariable ["isCommander", false]) then
		// {
			// if(DYN_RACE_SPEC_ENABLED) then
			// {
				// _color = [1,0,0,1];
				// if(count DYN_RACE_COMMANDER_SELECTED_ACTION > 0) then
				// {
					// _action_cost = DYN_RACE_COMMANDER_SELECTED_ACTION select 5; 
					// if(_action_cost <= DYN_RACE_COMMANDER_RESOURCEPOINTS) then
					// {
						// //Green
						// _color = [0,1,0,1];
					// };
				// };
				
				// _playerPos = getPosATL DYN_RACE_SPECTATOR_CAM;
				// drawIcon3D [
					// "\a3\ui_f\data\IGUI\Cfg\TacticalDisplay\targettexture_gs.paa",
					// _color,
					// [_playerPos select 0,_playerPos select 1,2.3],
					// 2,
					// 2,
					// direction DYN_RACE_SPECTATOR_CAM,
					// "",
					// 0,
					// 0.03,
					// "PuristaMedium"
				// ];
			// };
		// };
		//checkpoints
		// _currentCheckpoint = (currentTask player);
		// if(_currentCheckpoint != taskNull) then
		// {
			// _currentCheckpointDestination = taskDestination _currentCheckpoint;
			// _distance = (_currentCheckpointDestination distance player);
			// if(_distance < 250) then
			// {
				// _text = "Checkpoint";
				// _textSize = (0.1) - (0.1 * _distance / 250);
				// _currentCheckpointId = (simpleTasks player) find _currentCheckpoint;
				// if(_currentCheckpointId == count DYN_RACE_CHECKPOINTS - 1) then
				// {
					// _text = "FINISH";
				// };
				// _currentCheckpointDestination = [_currentCheckpointDestination select 0, _currentCheckpointDestination select 1, 3];
				// drawIcon3D ["", [1,1,1,1], _currentCheckpointDestination, 0, 0, 0, _text, 0,_textSize];
			// };
		// };
	};
}];