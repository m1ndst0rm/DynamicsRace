//TODO: Eval
private ["_vehicle","_selectionName","_damage","_source","_returnVal","_maxDamage","_currentHitDamage","_diff","_vel","_dir"];
_vehicle = _this select 0;
_selectionName = _this select 1;
_damage = _this select 2;
_source = _this select 3;
_returnVal = 0;
if(DYN_RACE_DAMAGE_ENABLED) then
{
	_damage = _damage;
	
	_maxDamage = 0.9;
	switch (DYN_RACE_TYPE) do
	{
		case "HitLFWheel": { _maxDamage = 1};
		case "HitLF2Wheel": { _maxDamage = 1};
		case "HitRFWheel": { _maxDamage = 1};
		case "HitRF2Wheel": { _maxDamage = 1};
		
		case "HitRBWheel": { _maxDamage = 1};
		case "HitLBWheel": { _maxDamage = 1};
		
		case "HitReserveWheel": { _maxDamage = 1};

		case "HitFuel": { _maxDamage = 0.9};
		case "HitEngine": { _maxDamage = 0.9};
		case "HitEngine2": { _maxDamage = 0.9};
		case "HitEngine3": { _maxDamage = 0.9};
		case "HitBody": { _maxDamage = 0.9};
		case "HitHull": { _maxDamage = 0.9};
		 
		case "HitTransmission": { _maxDamage = 0.9}; 
		case "HitHydraulics": { _maxDamage = 0.9}; 
		case "HitTransmission": { _maxDamage = 0.9}; 
		
		case "HitLight ": { _maxDamage = 1}; 
		case "Light_R ": { _maxDamage = 1}; 
		case "Light_R2 ": { _maxDamage = 1}; 
		case "Light_L ": { _maxDamage = 1}; 
		case "Light_L2 ": { _maxDamage = 1}; 
		
		case "HitGlass1": { _maxDamage = 1};
		case "HitGlass2": { _maxDamage = 1};
		case "HitGlass3": { _maxDamage = 1};
		case "HitGlass4": { _maxDamage = 1};
		case "HitGlass5": { _maxDamage = 1};
		case "HitGlass6": { _maxDamage = 1};
		case "HitRGlass": { _maxDamage = 1};
		case "HitLGlass": { _maxDamage = 1};
	};

	if(_selectionName == "") then
	{
		if((damage _vehicle) + _damage <= 0.9) then
		{
			_returnVal = 0;
		};
	}
	else
	{
		_currentHitDamage = _vehicle getHitPointDamage _selectionName;
		if(_currentHitDamage + _damage <= _maxDamage) then
		{
			
			_vehicle setHit [_selectionName, _damage];
		};
	};
}
else
{
	_damage = 0;
	if(speed _vehicle > 50) then
	{
		_diff = _damage;
		_vel = velocity _vehicle;
		_dir = getDir _vehicle;
		_vehicle setVelocity [(_vel select 0)-(sin _dir*_diff),(_vel select 1)-(cos _dir*_diff),(_vel select 2)];
	};
};
_returnVal;