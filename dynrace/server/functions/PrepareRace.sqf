DYN_RACE_VOTE_TYPE = "RACETYPE";
DYN_RACE_VOTE_TYPE_CLIENT = DYN_RACE_VOTE_TYPE;
publicVariable "DYN_RACE_VOTE_TYPE_CLIENT";

DYN_RACE_VOTE_COUNTDOWN_STARTED = false;
publicVariable "DYN_RACE_VOTE_COUNTDOWN_STARTED";

DYN_RACE_EXPLOSIONS = [];
publicVariable "DYN_RACE_EXPLOSIONS";

DYN_RACE_FIRES = [];

DYN_RACE_STARTTIME = objNull;
publicVariable "DYN_RACE_STARTTIME";

DYN_RACE_FINISHTIME = -1;
publicVariable "DYN_RACE_FINISHTIME";


DYN_RACE_VOTES = [];
DYN_RACE_PROCESSING_VOTES = false;
DYN_RACE_SMOKE_GRENADES = [];
DYN_RACE_TEAMCHOOSE_COUNTDOWN_STARTED = false;
if!(isNil {DYN_RACE_MAP_VEHICLES}) then
{
	{
		_vehicles = _x select 1;
		{
			deleteVehicle _x;
		} forEach _vehicles;
	} forEach DYN_RACE_MAP_VEHICLES;
};
DYN_RACE_MAP_VEHICLES = [];