_object = _this select 0;
_action_id = _this select 2;
_smokeLeft = _object getVariable ["smokeAmountLeft", DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT]; 
_smokeLeft = _smokeLeft - 1;
_object setVariable ["smokeAmountLeft", _smokeLeft];
_object removeAction _action_id;
if(_smokeLeft > 0) then
{
	DYN_RACE_LOCAL_SMOKE_ACTION = _object addAction [format ["Deploy smokescreen (%1 left)", _smokeLeft], "dynrace\client\actions\SmokeScreen.sqf",[], 0, false];
};
for [ {_i = 0}, {_i < 1}, {_i = _i + 1}] do
{
	_pos = position _object;
	//null = [_pos, random 360, "G_40mm_Smoke", east] call BIS_fnc_spawnVehicle;
	[_object] call FNC_SMOKE;
	sleep 0.3;
};