/* DYN_RACE_Smoke: Creates smoke on given mark names
* Creates smoke on given marker(s) but limits the smoke to 1 per marker per 15 seconds (mulitple players hitting a trigger wont create multiple smoke grenades)
*
* Example: ["marker_1"] call DYN_RACE_CreateSmoke;
* Example: ["marker_1", "marker_2", ...] call DYN_RACE_CreateSmoke;
* params:
* string : _markername
*/
DYN_RACE_CreateSmoke =
{
	if (!isServer) exitWith {};
	"DYN_RACE_Smoke" call DYN_RACE_Debug;
	
	_markers = [];
	
	for [ {_i = 0}, {_i < count _this}, {_i = _i + 1} ] do
    {
		_markers set [_i, (_this select _i)];
	};
	
	{
		_marker = _x;
		if !(_marker in DYN_RACE_SMOKE_GRENADES) then
		{
			null = [getMarkerPos _marker, random 360, "G_40mm_Smoke", east] call BIS_fnc_spawnVehicle;
			DYN_RACE_SMOKE_GRENADES set [count DYN_RACE_SMOKE_GRENADES, _marker];
		}
	} forEach _markers;
	
	sleep 30;
	DYN_RACE_SMOKE_GRENADES = DYN_RACE_SMOKE_GRENADES - _markers;
};