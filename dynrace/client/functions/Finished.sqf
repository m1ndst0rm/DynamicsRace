if(player in _this) then
{
	DYN_RACE_PLAYER_FINISHED = true;
	DYN_RACE_MUST_STAY_ON_ROAD_LOCAL = false;

	[vehicle player] spawn
	{
		_vehicle = _this select 0;
		_speed = speed _vehicle;
		_vehicle setFuel 0;
		while{ (_speed > 1) } do 
		{
			_diff = 0.2;
			_vel = velocity _vehicle;
			_dir = getDir _vehicle;
			_vehicle setVelocity [(_vel select 0)-(sin _dir*_diff),(_vel select 1)-(cos _dir*_diff),(_vel select 2)];
			_speed = speed _vehicle;
			sleep 0.01;
		};
		_vehicle setVelocity[0,0,0];
		//_vehicle enableSimulation false;
		
		_vehicle engineOn false;
		
		[] spawn DYN_RACE_SPEC_EnableSpectator;
	};
};