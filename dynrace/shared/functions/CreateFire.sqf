//TODO: Fix
/* DYN_RACE_CreateFire: Creates fire on given mark names
* Creates fire on given marker(s) but limits the fire to 1 per marker per 15 seconds (mulitple players hitting a trigger wont create multiple fires)
*
* Example: [10, 3, "marker_1"] call DYN_RACE_CreateFire;
* Example: [30, 10, "marker_1", "marker_2", ...] call DYN_RACE_CreateFire;
* params:
* int : _duration
* int: _intensity (0.8 >= x <= 10)
* string : _markername
*/
if (!isServer) exitWith {};
"DYN_RACE_Fire" call DYN_RACE_Debug;

_markers = [];
_duraction = _this select 0;
_intensity = _this select 1;
for [ {_i = 2}, {_i < count _this}, {_i = _i + 1} ] do
{
	_markers set [_i, (_this select _i)];
};

_fires = [];
{
	_marker = _x;
	if !(_marker in DYN_RACE_FIRES) then
	{
		_dummy = "RoadCone" createVehicle _marker;
		_dummy setPos _marker;
		_fires set [count _fires, _dummy];
		DYN_RACE_FIRES set [count DYN_RACE_FIRES, _marker];
	}
} forEach _markers;

sleep _duraction;

{
	deleteVehicle _x;
} forEach _fires;

DYN_RACE_FIRES = DYN_RACE_FIRES - _markers;