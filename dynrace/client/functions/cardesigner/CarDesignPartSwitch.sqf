_side = [_this, 0, "left"] call bis_fnc_param;
if(count DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION == 0) exitWith {};

_part = DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION select 0;
_customization = DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION select 1;
_currentType = typeOf _part;
_currentTypeId = DYN_RACE_CARDESIGN_PROTECTION find _currentType;

if(_side == "left") then
{
	_currentTypeId = _currentTypeId - 1;
}
else
{
	_currentTypeId = _currentTypeId + 1;
};

if(_currentTypeId < 0) then {_currentTypeId = count (DYN_RACE_CARDESIGN_PROTECTION) - 1};
if(_currentTypeId > count (DYN_RACE_CARDESIGN_PROTECTION) - 1) then {_currentTypeId = 0};

detach _part;
deleteVehicle _part;

_partName = DYN_RACE_CARDESIGN_PROTECTION select _currentTypeId;
_customization set [0, _partName];
_partType = _customization select 1;
_partPostion = _customization select 2;
_partDirection = _customization select 3;
_partPitch = _customization select 4;
_partBank = _customization select 5;

_part = _partName createVehicleLocal DYN_RACE_DESIGNER_DEFAULTPOS;
_part setDir _partDirection;
[_part, _partPitch, _partBank] call BIS_fnc_setPitchBank;

_part attachTo [DYN_RACE_CARDESIGN_CURRENTCAR, _partPostion];
DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION set [0, _part];
DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION set [1, _customization];