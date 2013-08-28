_side = [_this, 0, "left"] call bis_fnc_param;

_currentType = typeOf DYN_RACE_CARDESIGN_CURRENTCAR;
_currentTypeId = DYN_RACE_AVAILABLE_VEHICLES_SINGLE find _currentType;

if(_side == "left") then
{
	_currentTypeId = _currentTypeId - 1;
}
else
{
	_currentTypeId = _currentTypeId + 1;
};

if(_currentTypeId < 0) then {_currentTypeId = count (DYN_RACE_AVAILABLE_VEHICLES_SINGLE)  - 1};
if(_currentTypeId > count (DYN_RACE_AVAILABLE_VEHICLES_SINGLE) - 1) then {_currentTypeId = 0};

[] call DYN_fnc_CarDesignSaveCar;

deleteVehicle DYN_RACE_CARDESIGN_CURRENTCAR;
DYN_RACE_CARDESIGN_CURRENTCAR = (DYN_RACE_AVAILABLE_VEHICLES_SINGLE select _currentTypeId) createVehicleLocal DYN_RACE_DESIGNER_DEFAULTPOS;
[] call DYN_fnc_CarDesignLoadCar;