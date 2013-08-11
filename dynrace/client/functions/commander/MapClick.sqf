"DYN_RACE_MapClick" call BIS_fnc_log;
_pos = _this select 0;
_units = _this select 1;
_shift = _this select 2;
_alt = _this select 3;

openMap false;

//DYN_RACE_SPECTATOR_CAM cameraEffect ["internal","back"];
// setPos [_pos select 0 , _pos select 1, 20];
//DYN_RACE_SPECTATOR_CAM_FREELOOK = true;	
//DYN_RACE_SPECTATOR_CAM camCommit 0;