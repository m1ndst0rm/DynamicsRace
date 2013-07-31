//TODO: Friendly check
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;

_vehicle = [player,_pos] call DYN_RACE_NearestFriendlyRacer;
[[], "DYN_RACE_ResupplyVehicle", owner _vehicle] spawn BIS_fnc_MP;