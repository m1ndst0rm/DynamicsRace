//Server init
[] call DYN_fnc_PrepareRace;

onPlayerDisconnected "[_id,_name, _uid] spawn DYN_fnc_OnPlayerDisconnect;";

DYN_RACE_LOCK_TEAMS = false;
publicVariable "DYN_RACE_STATE";
[] call DYN_fnc_OnRaceStateChanged;
publicVariable "DYN_RACE_RACERS";
[] call DYN_fnc_OnRacersChanged;

//AI / testing
_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
{
	if!(isPlayer _x) then
	{
		_x allowDamage false;
		_grp = createGroup west;
		[_x] joinSilent _grp;
	};
} forEach _units;