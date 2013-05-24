_object = _this select 0;
_action_id = _this select 2;
_smokeLeft = _object getVariable ["smokeAmountLeft", DYN_RACE_DEFAULT_SMOKE_SCREEN_AMOUNT]; 
_smokeLeft = _smokeLeft - 1;
_object setVariable ["smokeAmountLeft", _smokeLeft];
_object removeAction _action_id;
if(_smokeLeft > 0) then
{
	DYN_RACE_LOCAL_SMOKE_ACTION = _object addAction [format ["Deploy smokescreen (%1 left)", _smokeLeft], "dynrace\client\functions\CreateSmokeScreen.sqf",[], 0, false];
};
for [ {_i = 0}, {_i < 1}, {_i = _i + 1}] do
{
	_pos = position _object;
	//null = [_pos, random 360, "G_40mm_Smoke", east] call BIS_fnc_spawnVehicle;
	[_object] call FNC_SMOKE;
	sleep 0.3;
};

FNC_SMOKE = {
  [_this select 0,[0.192,0.192,0.192,0]] spawn {
  	_sh=_this select 0;
  	_col=_this select 1;
  	_c1=_col select 0;
  	_c2=_col select 1;
  	_c3=_col select 2;
  	
	_source = "#particlesource" createVehicle getpos player;
	_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
					[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, /*Scale*/[12, 16, 48], /*Color*/[[_c1, _c2, _c3, 0.2], [_c1, _c2, _c3, 0.05], [_c1, _c2, _c3, 0]],
					 /*Animationspeed*/[1.5,0.5], 1, 0.04, "", "", _temp];
	_source setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
	_source setDropInterval 0.50;
	_source2 = "#particlesource" createVehicle getpos player;
	_source2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 0], "", "Billboard", 1, 20, [0, 0, 0],
					[0.2, 0.1, 0.1], 0, 1.277, 1, 0.025, [12, 16, 48], [[_c1, _c2, _c3, 1], [_c1, _c2, _c3, 0.5], [_c1, _c2, _c3, 0]],
					 [0.2], 1, 0.04, "", "", _temp];
	_source2 setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.2], 0, 0, 360];
	_source2 setDropInterval 0.50;

	sleep (15);
	deletevehicle _source;
	deletevehicle _source2;
  };
};