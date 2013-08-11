private ["_sh","_col","_c1","_c2","_c3","_source","_temp","_source2"];
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