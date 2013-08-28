_partName = DYN_RACE_CARDESIGN_PROTECTION select 0;
_partType = "defensive";

_BBR = boundingBoxReal DYN_RACE_CARDESIGN_CURRENTCAR;
_Dim1 = _BBR select 0;
_Dim2 = _BBR select 1;
_maxHeight = abs ((_Dim2 select 2) - (_Dim1 select 2));

_partPostion = [0,0,_maxHeight];
_partDirection = 0;
_partPitch = 0;
_partBank = 0;

_customization = [_partName, _partType, _partPostion, _partDirection, _partPitch, _partBank];

_part = _partName createVehicleLocal [0,0,0];

DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION = [_part, _customization];
DYN_RACE_SELECTED_CUSTOMIZATIONID = count DYN_RACE_CARDESIGN_CUSTOMIZATIONS;
DYN_RACE_CARDESIGN_CUSTOMIZATIONS set [count DYN_RACE_CARDESIGN_CUSTOMIZATIONS, DYN_RACE_CARDESIGN_SELECTED_CUSTOMIZATION];
_part attachTo [DYN_RACE_CARDESIGN_CURRENTCAR, _partPostion];