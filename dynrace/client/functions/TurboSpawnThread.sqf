_speedX   = 0.1; 
_defaultTurbo = 0.1; // default turbo 
_offroad  = 0.3; // Turbo Speed Off Road
_max      = 140; // Max Speed wit Turbo 
_nos      = 0; // Boost speed 
_nosmax   = 0;   // Boost off (don't change)
_nosspeed = 40;  // Max Turbo speed + nospeed = 180
_turboOff = 50;  // Speed where Turbo Kicks in  

while {DYN_RACE_STATE == "ONGOING"} do 
{
	sleep 0.001;
	if (vehicle player != player and vehicle player isKindOf "land" ) then {
		_veh = vehicle player;

        if (!isOnRoad (position player)) then {_speedX = 0.2} else {_speedX = 0.1};// increase offroad speed
        
        if (player getvariable ["boost",false]) then {_speedX =_speedX+_nos;_nosmax = _nosspeed } else {_nosmax = 0};
        
		if ((player getvariable ["boost",false]) && speed _veh < _turboOff ) then  {
			_vel = velocity _veh;
			_dir = getdir _veh;
			
			if  (!(player getvariable "accelerate")) exitwith {}; // decelerate 
			
			if  ( speed _veh > _max+_nosmax ) exitwith  {};  // max speed  + nosmax
			
			_veh setvelocity [
				((_vel select 0) + _speedX * (sin _dir)) ,
				((_vel select 1) + _speedX * (cos _dir)) ,
				(_vel select 2)+.01 
			];
		} ;
	};
};