private ["_z","_availableTargets","_racersCount","_i","_possibleTarget","_currentTargetPos"];
if!(DYN_RACE_SWITCHINGPLAYER) then
{
	DYN_RACE_SWITCHINGPLAYER = true;

	"DYN_RACE_SwitchPlayer" call BIS_fnc_log;
	_z = _this select 1;

	_availableTargets = [];

	_racersCount = count DYN_RACE_RACERS;
	_i= 0; for "_i" from 0 to (_racersCount - 1) do
	{
		_possibleTarget = (DYN_RACE_RACERS select _i) select 1;
		if(_possibleTarget getVariable ["isDriver", false]) then
		{
			_availableTargets set [count _availableTargets, _possibleTarget];
		};
	} foreach DYN_RACE_RACERS;
	
	_currentTargetPos = _availableTargets find DYN_RACE_SPECTATOR_TARGET;
	
	if (_z < 0) then
	{ //Scroll down
		_currentTargetPos = _currentTargetPos - 1;
	}
	else
	{ //Scrol up
		_currentTargetPos = _currentTargetPos + 1;
	};

	if(_currentTargetPos < 0) then { _currentTargetPos = (count _availableTargets - 1);};
	if(_currentTargetPos > (count _availableTargets -1)) then { _currentTargetPos = 0;};

	DYN_RACE_SPECTATOR_TARGET = _availableTargets select _currentTargetPos; 

	cutText [format["%1", name DYN_RACE_SPECTATOR_TARGET],"PLAIN DOWN"];

	if (DYN_RACE_SPECTATOR_CAM_FREELOOK) then 
	{
		DYN_RACE_SPECTATOR_CAM setpos [((position DYN_RACE_SPECTATOR_TARGET) select 0) + ((sin (getdir DYN_RACE_SPECTATOR_TARGET)) * ( - 10)), ((position DYN_RACE_SPECTATOR_TARGET) select 1) + ((cos (getdir DYN_RACE_SPECTATOR_TARGET)) * (- 10)), ((position DYN_RACE_SPECTATOR_TARGET) select 2) + 2];
		DYN_RACE_SPECTATOR_CAM setdir getdir DYN_RACE_SPECTATOR_TARGET;
	} 
	else 
	{
		if(player getVariable ["isCommander", false]) then
		{
	DYN_RACE_SPECTATOR_CAM setPos [((position DYN_RACE_SPECTATOR_TARGET) select 0), ((position DYN_RACE_SPECTATOR_TARGET) select 1), ((position DYN_RACE_SPECTATOR_TARGET) select 2) + 100];
		DYN_RACE_SPECTATOR_CAM setDir getDir DYN_RACE_SPECTATOR_TARGET;
		DYN_RACE_SPECTATOR_CAM_FREELOOK = false;
		DYN_RACE_SPECTATOR_CAM camSetTarget DYN_RACE_SPECTATOR_TARGET;
		DYN_RACE_SPECTATOR_CAM camSetRelPos [0,0,100];
		DYN_RACE_SPECTATOR_CAM cameraEffect ["external", "back"];
		//DYN_RACE_SPECTATOR_CAM setVectorUp [0,0.99,0.01];
		DYN_RACE_SPECTATOR_CAM camCommit 0;
		}
		else
		{
			DYN_RACE_SPECTATOR_TARGET switchCamera "EXTERNAL";
		};
	};
	DYN_RACE_SWITCHINGPLAYER = false;
	DYN_RACE_SPECTATOR_CAM camCommit 0;
};