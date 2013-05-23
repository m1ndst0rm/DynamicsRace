//TODO: Think about implementing turbo
DYN_RACE_TURBO_ENABLED = false;

DYN_RACE_TURBO_SCRIPT =
{
	_sleepTimeOriginal = 0.05;
	_sleepTime = _sleepTimeOriginal;
	_velIncrease = 0.2;
	_vehicle = vehicle player;
	_maxSpeed = getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "maxSpeed");
	
	while {DYN_RACE_TURBO_ENABLED} do
	{
		_vehicle = vehicle player;
		if(_vehicle != player) then
		{
			_sleepTime = _sleepTimeOriginal;
			_speed = speed _vehicle;
			_pos = getPosATL _vehicle;
			if(_speed > 0 && _pos select 2 < 0.2) then
			{
				_vel = velocity _vehicle;
				_dir = getdir _vehicle;
				
				_dvelIncrease = _velIncrease - (_speed / (_maxSpeed min 130) * _velIncrease); 
				
				if(_speed < _maxSpeed) then
				{
					_vehicle setVelocity [(_vel select 0)+(sin _dir*_dvelIncrease),(_vel select 1)+(cos _dir*_dvelIncrease),(_vel select 2)];
				};
			};
		}
		else
		{
			_sleepTime = 1;
		};
		
		sleep _sleepTime;
	};
};

DYN_RACE_TurboStop =
{
	DYN_RACE_TURBO_ENABLED = false;
	true;
};

DYN_RACE_TurboStart =
{
	if!(DYN_RACE_TURBO_ENABLED) then
	{
		"Starting turbo" call DYN_RACE_Debug;
		DYN_RACE_TURBO_ENABLED = true;
		DYN_RACE_TURBO_HANDLE = [] spawn DYN_RACE_TURBO_SCRIPT;
	};
};