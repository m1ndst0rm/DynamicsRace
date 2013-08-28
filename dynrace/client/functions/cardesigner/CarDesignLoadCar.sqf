_saveName = format ["DYN_CUSTOMIZATION_%1", typeOf DYN_RACE_CARDESIGN_CURRENTCAR];
_customization = profileNamespace getVariable [_saveName, []];
DYN_RACE_CARDESIGN_CUSTOMIZATIONS = [];
{
	_customization = _x;
	_partName = _customization select 0;
	_partType = _customization select 1;
	_partPostion = _customization select 2;
	_partDirection = _customization select 3;
	_partPitch = _customization select 4;
	_partBank = _customization select 5;
	
	_part = _partName createVehicleLocal [0,0,0];
	_part setDirection _partDirection;
	[_part, _partPitch, _partBank] call BIS_fnc_setPitchBank;
	
	_part attachTo [DYN_RACE_CARDESIGN_CURRENTCAR, _partPostion];
	DYN_RACE_CARDESIGN_CUSTOMIZATIONS set [count DYN_RACE_CARDESIGN_CUSTOMIZATIONS, [_part, _customization]];
} forEach _customization;

if(count DYN_RACE_CARDESIGN_CUSTOMIZATIONS > 0) then
{
	DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION = DYN_RACE_CARDESIGN_CUSTOMIZATIONS select 0;
	[] call DYN_fnc_CarDesignFocusOnSelectedPart;
}
else
{
	DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION = [];
	
	DYN_RACE_CARDESIGN_CAM camSetTarget DYN_RACE_CARDESIGN_CURRENTCAR;
	//DYN_RACE_CARDESIGN_CAM camSetPos position DYN_RACE_CARDESIGN_CURRENTCAR;
	DYN_RACE_CARDESIGN_CAM camSetRelPos [0, -10, 5];
	DYN_RACE_CARDESIGN_CAM camcommit 0;
};
