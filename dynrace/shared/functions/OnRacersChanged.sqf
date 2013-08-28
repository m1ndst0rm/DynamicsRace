/* DYN_fnc_OnRacersChanged: Function called when var DYN_RACE_RACERS is changed.
* Will:
* Update vehicle damageEnabled, player damageEnabled 
* Enable or disable simulation on a vehicle (preventing it from moving)
* Change vehicle textures & others
*/
private ["_local_racers","_racer","_player","_vehicle","_playerAllowDamage","_vehicleAllowDamage","_vehicleEnableSimulation","_vehicle_netId","_texture1","_texture2","_fuel"];
"DYN_fnc_OnRacersChanged" call BIS_fnc_log;
//Update local racer settings. 
_local_racers = DYN_RACE_RACERS;

OffRoadTextures = ["\A3\soft_F\Offroad_01\Data\Offroad_01_ext_co.paa",  //red 
"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE01_CO.paa", //yellow  
"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE02_CO.paa",  //white 
"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE03_CO.paa",  //blue 
"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE04_CO.paa",  //darkred 
"\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE05_CO.paa"]; //darkblue 

{
	_racer = _x;
	_player = _racer select 1;
	_vehicle = _racer select 2;
	_playerAllowDamage = _racer select 3;
	_vehicleAllowDamage = _racer select 4;
	_vehicleEnableSimulation = _racer select 5;
	
	if(DYN_RACE_TYPE == "CAT&MOUSE") then
	{
		_teamNo = _player getVariable "teamNumber";
		_color = DYN_RACE_CATROBBERSCOLORCODES select _teamNo;
		_texture = format ["#(argb,8,8,3)color(%1,%2,%3,%4,CA)", _color select 0, _color select 1, _color select 2, _color select 3];
		diag_log _texture;
		_vehicle setObjectTexture [0, _texture];
	}
	else
	{
		if(typeOf _vehicle == DYN_RACE_OFFROAD_CLASS) then
		{
			//format ["Setting anim of vehicle: %1. ", _vehicle_netId] call BIS_fnc_log;
			_vehicle animate ["HidePolice", _vehicle getVariable ["HidePolice", 1]];  
			_vehicle animate ["HideServices", _vehicle getVariable ["HideServices", 1]];  
			_vehicle animate ["HideBackpacks", _vehicle getVariable ["HideBackpacks", 1]];  
			_vehicle animate ["HideBumper1", _vehicle getVariable ["HideBumper1", 0]];  
			_vehicle animate ["HideBumper2", _vehicle getVariable ["HideBumper2", 0]];  
			_vehicle animate ["HideConstruction", _vehicle getVariable ["HideConstruction", 0]];  
			_vehicle animate ["HideDoor1", _vehicle getVariable ["HideDoor1", 0]];   
			_vehicle animate ["HideDoor2", _vehicle getVariable ["HideDoor2", 0]];  
			_vehicle animate ["HideDoor3", _vehicle getVariable ["HideDoor3", 0]];  
			_vehicle animate ["HideGlass2", _vehicle getVariable ["HideGlass2", 0]];  
			
			_texture1 = _vehicle getVariable ["Texture1", floor(random 6)];
			_texture2 = _vehicle getVariable ["Texture2", floor(random 6)];
			_vehicle setVariable ["Texture1",_texture1]; 
			_vehicle setVariable ["Texture2",_texture2];
			
			_vehicle setObjectTexture [0, OffRoadTextures select (_texture1)];
			_vehicle setObjectTexture [1, OffRoadTextures select (_texture2)];
		}
	};

	//_vehicle allowDamage _vehicleAllowDamage;

	_fuel = (if (_vehicleEnableSimulation) then {1} else {0});
	_vehicle setFuel _fuel;

} forEach _local_racers;