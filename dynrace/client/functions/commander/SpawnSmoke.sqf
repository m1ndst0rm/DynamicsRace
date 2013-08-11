private ["_commander"];

//TODO: Fix some real smoke not this bs.
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;
null = [_pos, random 360, "G_40mm_Smoke", east] call BIS_fnc_spawnVehicle;