private ["_commander","_vehicle"];
_commander = (_this select 0) select 0;
_pos = (_this select 0) select 1;

_vehicle = [player,_pos] call DYN_fnc_NearestFriendlyRacer;
[[], "DYN_fnc_ResupplyVehicle", owner _vehicle] call BIS_fnc_MP;