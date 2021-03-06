/* DYN_fnc_InitRace: Initializes the race. Spawns vehicles e.t.c.
* This function should NOT be called directly. Internal function.
*
*/
if (!isServer) exitWith {};
private ["_onlinePlayers","_racers","_player","_assigned","_teamId","_team","_spotTypes","_teamPlayers","_i","_spot","_spots","_players","_global_changed","_teamsCount","_startPos","_drivers","_gunners","_robbers","_cops","_mice","_cats","_helies","_teamSpots","_tempDrivers","_teamSpot","_spotType","_gunnerCount","_j","_gunner","_driver","_first","_second","_playerToCreateVehiclesFor","_start_pos","_vehicleClass","_vehicle","_magNames","_teamNumber","_colorNumber","_extras","_tempGunner","_driverForGunner","_racer","_unit","_checkpoint","_wp"];
"DYN_fnc_InitRace" call BIS_fnc_log;

DYN_RACE_RACERS = []; //[[name,player,vehicle,playerdamage,vehicledamage,canMove]]
DYN_RACE_DRIVERCOUNT = 0;
DYN_RACE_ROBBERCOUNT = 0;

//Randomize player whom have not selected a team  & spot
{
	_player = _x;
	if(_player getVariable ["teamNumber", -1] == -1) then
	{
		//Default true because jip is set as soon as player object is created on client, if sync errors it will auto-asume client isn't initialized yet.
		if (!(_player getVariable ["JIPPLAYER", true]) || !(isPlayer  _player)) then
		{
			_assigned = false;
			_teamId = 0;
			{
				_team = _x;
				if!(_assigned) then
				{
					_spotTypes = _team select 1;
					_teamPlayers = _team select 2;
					_i = 0;
					{
						_spot = _x;
						_spots = _spot select 1;
						_players = _spot select 2;
						
						if(count _players < _spots && !(_assigned)) then
						{
							_players set [count _players, _player];
							_teamPlayers set [count _teamPlayers, _player];
							_player setVariable ["teamNumber", _teamId, true];
							_spot set [2, _players];
							_assigned = true;
						};
						_spotTypes set[_i, _spot];
						_i = _i + 1;
					} foreach _spotTypes;
					
					_team set [1, _spotTypes];
					_team set [2, _teamPlayers];
					DYN_RACE_TEAMS set [_teamId, _team];
				};
				_teamId = _teamId + 1;
			} foreach DYN_RACE_TEAMS;
		};
	};
} foreach DYN_RACE_AVAILABLERACERS;

if(DYN_RACE_TYPE == "SINGLE") then
{ //Set teamNames to player names.
	{
		_x set [0, name ((_x select 2) select 0)];
	} foreach DYN_RACE_TEAMS;
};

if(DYN_RACE_TYPE != "SINGLE") then
{
	//Publish new teams
	publicVariable "DYN_RACE_TEAMS";
	//Remove "join team" button.
	[[],"DYN_fnc_TeamSelectionDialogRemoveJoinButton", true] call BIS_fnc_MP;
	if!(isDedicated) then
	{
		[] call DYN_fnc_OnTeamsChanged;
	};
};
_teamsCount = count DYN_RACE_TEAMS;

_drivers = [];
_gunners = [];
_robbers = [];
_cops = [];
_mice = [];
_cats = [];
_helies = [];

_i= 0; for "_i" from 0 to (_teamsCount - 1) do
{
	_team = DYN_RACE_TEAMS select _i;
	_teamSpots = _team select 1;
	_tempDrivers = [];
	{
		_teamSpot = _x;
		
		_spotType = _teamSpot select 0;
		_players = _teamSpot select 2;
		if(_spotType == "DRIVER") then
		{
			{
				_x setVariable ["isDriver",true,true];
			} forEach _players;
			_drivers = _drivers + _players;
			_tempDrivers = _tempDrivers + _players;
		};
		if(_spotType == "GUNNER") then
		{
			_gunnerCount = count _players;
			
			_j= 0; for "_j" from 0 to (_gunnerCount - 1) do
			{
				_gunner = _players select _j;
				_gunners set [count _gunners, _gunner];
				_gunner setVariable ["isGunner",true,true];
				_driver = _tempDrivers select _j;
				_gunner setVariable ["driver", _driver, true];
			};
		};
		if(_spotType == "ROBBER") then
		{
			{
				_x setVariable ["isDriver",true,true];
				_x setVariable ["isRobber",true,true];
			} forEach _players;
			_robbers = _robbers + _players;
			_tempDrivers = _tempDrivers + _players;
		};
		if(_spotType == "COP") then
		{
			{
				_x setVariable ["isDriver",true,true];
				_x setVariable ["isCop",true,true];
			} forEach _players;
			_cops = _cops + _players;
		};
		if(_spotType == "MOUSE") then
		{
			{
				_x setVariable ["isDriver",true,true];
				_x setVariable ["isMouse",true,true];
			} forEach _players;
			_mice = _mice + _players;
		};
		if(_spotType == "CAT") then
		{
			{
				_x setVariable ["isDriver",true,true];
				_x setVariable ["isCat",true,true];
			} forEach _players;
			_cats = _cats + _players;
		};
		if(_spotType == "HELI") then
		{
			{
				_x setVariable ["isHeliPilot",true,true];
			} forEach _players;
			_helies = _helies + _players;
		};
		if(_spotType == "COMMANDER") then
		{
			{
				_x setVariable ["isCommander",true,true];
			} forEach _players;
		};
		if(_spotType == "SPECTATOR") then
		{
			{
				_x setVariable ["isSpectator",true,true];
			} forEach _players;
		};
		_players = _teamSpot select 2;
	} foreach _teamSpots;
};

//Robbers, Mice & Racers can be placed "first"


_drivers = _drivers call BIS_fnc_arrayShuffle;
_robbers = _robbers call BIS_fnc_arrayShuffle;
_mice = _mice call BIS_fnc_arrayShuffle;
_cats = _cats call BIS_fnc_arrayShuffle;
_cops = _cops call BIS_fnc_arrayShuffle;
_helies = _helies call BIS_fnc_arrayShuffle;

_first = _drivers + _robbers + _mice;

DYN_RACE_DRIVERCOUNT = count _first;
DYN_RACE_ROBBERCOUNT = count _robbers;
_second = _cats + _cops + _helies;

//Give players some time to watch at the teams.
if(DYN_RACE_TYPE != "SINGLE") then
{
	sleep 5;
};

_startPos = 0;
_playerToCreateVehiclesFor = _first + _second;
{
	_player = _x;
	
	_start_pos = getMarkerPos (DYN_RACE_START_POSITIONS select _startPos);
	
	_vehicleClass = "";
	if(!isNil{DYN_RACE_VEHICLE}) then
	{
		_vehicleClass = DYN_RACE_VEHICLE;
	};
	if(_player getVariable ["isRobber", false]) then
	{
		_vehicleClass = DYN_RACE_ROBBER_CLASS;
	};
	if(_player getVariable ["isMouse", false]) then
	{
		_vehicleClass = DYN_RACE_MOUSE_CLASS;
	};
	if(_player getVariable ["isCop", false] || _player getVariable ["isCat", false]) then
	{
		_vehicleClass = DYN_RACE_OFFROAD_CLASS;
	};
	if(_player getVariable ["isHeliPilot", false]) then
	{
		_vehicleClass = "GETTOTHATCHOPPAlol";
		_start_pos = 0; //TODO: Get some nice random start position
	};
	
	_vehicle = createVehicle [_vehicleClass, _start_pos, [], 0, "NONE"];
	
	_magazineInfo = magazinesAmmoFull _vehicle;
	_vehicle setVariable ["defaultMagazineInfo", _magazineInfo, true];
	_vehicle call DYN_fnc_GunLock;
	
	_vehicle lock 2;
	_vehicle setFuel 0;
	
	_start_pos = [_start_pos select 0, _start_pos select 1, (_start_pos select 2) + 1];
	_vehicle setPos (_start_pos);
	_vehicle setDir (markerDir (DYN_RACE_START_POSITIONS select _startPos));
	
	if(_player getVariable ["isRobber", false]) then
	{
		//_vehicle setVariable ["HideServices",floor(random 2),true];
		_vehicle setVariable ["HideBackpacks",0,true];
		_vehicle setVariable ["HideBumper1",floor(random 2),true];
		_vehicle setVariable ["HideBumper2",floor(random 2),true];
		_vehicle setVariable ["HideConstruction",floor(random 2),true];
		_vehicle setVariable ["HideDoor3",floor(random 2),true];
		_vehicle setVariable ["Texture1",6,true];
		_vehicle setVariable ["Texture2",6,true];
	};
	if(_player getVariable ["isCop", false]) then
	{
		_vehicle setVariable ["HidePolice",0,true];
		_vehicle setVariable ["Texture1",2,true];
		_vehicle setVariable ["Texture2",3,true];
	};
	
	if(DYN_RACE_TYPE == "CAT&MOUSE") then
	{
		_teamNumber = _player getVariable "teamNumber";
		_colorNumber = _teamNumber;
		_extras = 0;
		while {_colorNumber > 5 } do
		{
			_colorNumber = _colorNumber - 6;
			_extras = _extras + 1;
		};
		
		_vehicle setVariable ["Texture1",_colorNumber,true];
		_vehicle setVariable ["Texture2",_colorNumber,true];
		if(_extras == 1) then
		{
			_vehicle setVariable ["HideConstruction",0,true];
			_vehicle setVariable ["HideDoor3",0,true];
		};
		if(_extras == 2) then
		{
			_vehicle setVariable ["HideServices",0,true];
			_vehicle setVariable ["HideBumper1",0,true];
			_vehicle setVariable ["HideBumper2",0,true];
		};
		if(_extras == 3) then
		{
			
			_vehicle setVariable ["HideBackpacks",0,true];
		};
	};
	
	_player setVariable ["lapTimes", [], true];

	if!(isPlayer _player) then
	{
		_player moveInDriver _vehicle;
		_player disableAI "TARGET";
		_player disableAI "AUTOTARGET";
		[_vehicle, DYN_RACE_DAMAGE_MULTIPLIER] call  DYN_fnc_SetVehicleDamageHandler;
	};
	
	DYN_RACE_RACERS set [count DYN_RACE_RACERS, [name _player, _player, _vehicle, false, DYN_RACE_DAMAGE_ENABLED, false]];
	
	
	if(DYN_RACE_TYPE == "DUAL" || DYN_RACE_TYPE == "TEAM3" || (DYN_RACE_TYPE == "COPS&ROBBERS" && _player getVariable ["isRobber", false])) then
	{
		_gunner = objNull;
		{
			_tempGunner = _x;
			if(isNull _gunner) then
			{
				_driverForGunner = _tempGunner getVariable ["driver", objNull];
				if(_driverForGunner == _player) then
				{
					_gunner = _tempGunner;
				};
			};
		} foreach _gunners;
		_gunner setVariable ["lapTimes", [], true];
		if!(isPlayer  _gunner) then
		{
			_gunner moveInGunner _vehicle;
		};
		DYN_RACE_RACERS set [count DYN_RACE_RACERS, [name _gunner, _gunner, _vehicle, false, DYN_RACE_DAMAGE_ENABLED, false]];
	};
	_startPos = _startPos + 1;
} forEach _playerToCreateVehiclesFor;

publicVariable "DYN_RACE_RACERS";

[] call DYN_fnc_OnRacersChanged;
{
	_racer = _x;
	_player = _racer select 1;
	_vehicle = _racer select 2;
	_player setVariable ["vehicle", _vehicle, true];
} foreach DYN_RACE_RACERS;

//Add waypoints for AI units. Just for testing purpose
if ({ !(isPlayer _x)} count DYN_RACE_AVAILABLERACERS > 0) then
{
	{
		_unit = _x;
		if !(isPlayer _unit) then
		{
			_unit allowFleeing 0;
			
			_checkPointCout = count DYN_RACE_CHECKPOINTS;
			_firstWaypointId = 0;
			if(DYN_RACE_LAPS == 1) then
			{
				_firstWaypointId = 1;
			};
			
			_i = 0; for "_i" from 0 to (_checkPointCout - 1) do
			{
				_checkpoint = DYN_RACE_CHECKPOINTS select _i;
				_wp = (group _unit) addWaypoint [getMarkerPos _checkpoint, 0]; 
				_wp setWaypointType "MOVE"; 
				_wp setWaypointSpeed "FULL"; 
				_wp setWaypointBehaviour "AWARE";
			};
			
			_unit setVariable ["currentWaypointId", _firstWaypointId, true];
			(group _unit) setCurrentWaypoint [(group _unit), _firstWaypointId + 1]; //First waypoint is 1 instead of 0. seriously bis...
			_currentWayPointId = (currentWaypoint (group _unit));
		};
	} foreach DYN_RACE_AVAILABLERACERS;
};

DYN_RACE_INITPREPDONE = true;
publicVariable "DYN_RACE_INITPREPDONE";

//Give clients time to prepare
sleep 5;
DYN_RACE_STATE = "STARTING";
publicVariable "DYN_RACE_STATE";
[] call DYN_fnc_OnRaceStateChanged;