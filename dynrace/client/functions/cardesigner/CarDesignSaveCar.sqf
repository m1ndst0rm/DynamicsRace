_saveName = format ["DYN_CUSTOMIZATION_%1", typeOf DYN_RACE_CARDESIGN_CURRENTCAR];
_saveArray = [];
{
	_customizationArray = _x;
	_part = _customizationArray select 0;
	_customization = _customizationArray select 1;
	
	_partName = typeOf _part;
	_partType = "defensive";
	_partPostion = position _part;
	_partDirection = ((direction DYN_RACE_CARDESIGN_CURRENTCAR) - (direction _part) + 360) % 360;
	
	_pb = _part call BIS_fnc_setPitchBank;
	_partPitch = _pb select 0;
	_partBank = _pb select 1;
	
	_customization = [_partName, _partType, _partPostion, _partDirection, _partPitch, _partBank];
	
	_saveArray set [count _saveArray, _customization];
} forEach DYN_RACE_CARDESIGN_CUSTOMIZATION;

if(count _saveArray > 0) then
{
	profileNamespace setVariable [_saveName, _saveArray];
};
saveProfileNamespace;