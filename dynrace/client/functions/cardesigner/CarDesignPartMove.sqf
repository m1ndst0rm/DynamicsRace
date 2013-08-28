_side = [_this, 0, "left"] call bis_fnc_param;
_shift = [_this, 1, false] call bis_fnc_param;

if(count DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION == 0) exitWith {};
_part = DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION select 0;
_customization = DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION select 1;

_partPos = position _part;
if(_shift) then
{
	_pb = _part call BIS_fnc_getPitchBank;
	_pitch = _pb select 0;
	_bank = _pb select 1;
	_direction = direction _part;
	switch _side do
	{
		case "left":
		{
			_pitch = _pitch - 1;
		};
		case "right":
		{
			_pitch = _pitch + 1;
		};
		case "up":
		{
			_bank = _bank - 1;
		};
		case "down":
		{
			_bank = _bank + 1;
		};
		case "forward":
		{
			_direction = _direction - 1;
		};
		case "backward":
		{
			_direction = _direction + 1;
		};
	};
	if(_direction != direction _part) then
	{
		_part setDir _direction;
		_customization set [3, _direction];
	};
	if(_pb select 0 != _pitch || _pb select 1 != _bank) then
	{
		[_part, _pitch, _bank] call BIS_fnc_setPitchBank;
		_customization set [4, _pitch];
		_customization set [5, _bank];
	};
}
else
{
	_carDirection = direction DYN_RACE_CARDESIGN_CURRENTCAR;
	_pos = _customization select 2;
	switch _side do
	{
		case "left":
		{
			_pos set [0, (_pos select 0) - 0.1];
		};
		case "right":
		{
			_pos set [0, (_pos select 0) + 0.1];
		};
		case "up":
		{
			_pos set [2, (_pos select 2) + 0.1];
		};
		case "down":
		{
			_pos set [2, (_pos select 2) - 0.1];
		};
		case "forward":
		{
			_pos set [1, (_pos select 1) + 0.1];
		};
		case "backward":
		{
			_pos set [1, (_pos select 1) - 0.1];
		};
	};
	detach _part;
	_customization set [2, _pos];
	_partName = _customization select 0;
	_part = _partName createVehicleLocal [0,0,0];
	_part setDirection _partDirection;
	[_part, _partPitch, _partBank] call BIS_fnc_setPitchBank;
	
	_part attachTo [DYN_RACE_CARDESIGN_CURRENTCAR, _partPostion];
	
	_part attachTo [DYN_RACE_CARDESIGN_CURRENTCAR, _pos];
	_part setDir _partDirection;
	_partDirection = _customization select 3;
	_partPitch = _customization select 4;
	_partBank = _customization select 5;
	[_part, _partPitch, _partBank] call BIS_fnc_setPitchBank;
};
DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION set[1, _customization];