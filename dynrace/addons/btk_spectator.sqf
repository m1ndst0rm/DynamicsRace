/*
	File: btk_spectator.sqf
	Author: BTK (bufu@mail.nu)
	
	Description:
	- Simple and smooth spectator mode
	- Based on Kegetys GDT Spectator for ArmA 2
	
	Usage:
	_null = [] execVM "btk_spectator.sqf";
*/
// Variables
btk_spectator_nvg = false;
btk_spectator_cam_enabled = true;
btk_spectator_help = false;
btk_spectator_units = [];
_playableUnits = if (isMultiplayer) then { playableUnits; } else { switchableUnits; };
//_playableUnits = this select 0;


btk_spectator_target = player;

{ 
if (alive _x && _x != player) then 
	{ 
		btk_spectator_units = btk_spectator_units + [_x]
	}
} forEach _playableUnits;
btk_spectator_units_count = count btk_spectator_units - 1;
btk_spectator_units_select = 0;


// Require UI
waitUntil {!(isNull (findDisplay 46))};

if(DYN_RACE_STATE == "ONGOING") then
{
	cutText ["MOUSEWHEEL: Cycle between units\nLEFT MOUSE BUTTON: Freelook\nRIGHT MOUSE BUTTON: Camera follows unit\nWASD and MOUSE: Move camera\nQ: Move camera up\nY or Z: Move camera down\nSHIFT LEFT: Slow movement\nN: Nightvision\n\nWhile the camera is following a unit, you can change between 1st/3rd person, optics and group view.\n\nPress H to hide controls","PLAIN"];
};
// Show controls on pressing the H key
(finddisplay 46) displayAddEventHandler ["keydown", "
	if ((_this select 1) == 35) then {

		if (!btk_spectator_help && DYN_RACE_STATE == ""ONGOING"") then {
			cutText [""MOUSEWHEEL: Cycle between units\nLEFT MOUSE BUTTON: Freelook\nRIGHT MOUSE BUTTON: Camera follows unit\nWASD and MOUSE: Move camera\nQ: Move camera up\nY or Z: Move camera down\nSHIFT LEFT: Slow movement\nN: Nightvision\n\nWhile the camera is following a unit, you can change between 1st/3rd person, optics and group view.\n\nPress H to hide controls"",""PLAIN""];
			btk_spectator_help = true;
		} else {
			cutText ["""",""PLAIN""];
			btk_spectator_help = false;
		};

	};
"];


// NVG mode
(finddisplay 46) displayAddEventHandler ["keydown", "
	if (((_this select 1) == 49)) then {

		if (btk_spectator_nvg) then {
			camUseNVG false;
			btk_spectator_nvg = false;
		} else {
			camUseNVG true;
			btk_spectator_nvg = true;
		};

	};
"];


// Switch cam
(finddisplay 46) displayAddEventHandler ["MouseButtonDown", "
	if (((_this select 1) == 0) && (!btk_spectator_cam_enabled)) then {
	
		btk_spectator_cam cameraEffect [""internal"",""back""];
		btk_spectator_cam setPos [((position btk_spectator_target) select 0) + ((sin (getdir btk_spectator_target)) * ( - 10)), ((position btk_spectator_target) select 1) + ((cos (getdir btk_spectator_target)) * (- 10)), ((position btk_spectator_target) select 2) + 2];
		btk_spectator_cam setDir getDir btk_spectator_target;		
		btk_spectator_cam_enabled = true;

};
"];


// Title
(finddisplay 46) displayAddEventHandler ["MouseButtonDown", "
	if (((_this select 1) == 1) && btk_spectator_cam_enabled) then {

		if (!(alive (btk_spectator_units select btk_spectator_units_select))) then {
		
			while {!(alive (btk_spectator_units select btk_spectator_units_select))} do {
				btk_spectator_units_select = btk_spectator_units_select + 1;
				if (btk_spectator_units_select > btk_spectator_units_count) then { btk_spectator_units_select = 0; };
			};

			btk_spectator_target = vehicle (btk_spectator_units select btk_spectator_units_select);

		};
		
		btk_spectator_cam cameraeffect [""Terminate"",""back""];
		cutText [format[""%1"", (name btk_spectator_target)],""PLAIN DOWN""];
		btk_spectator_target switchCamera ""EXTERNAL"";
		btk_spectator_cam_enabled = false;
		btk_spectator_help = false;
};
"];


// Scroll through units
(findDisplay 46) displayAddEventHandler ["mousezchanged", "
	if (({alive _x} count btk_spectator_units) > 0) then {

		_z = _this select 1;
		if (_z  < 0) then {
		
			btk_spectator_units_select = btk_spectator_units_select - 1;
			
			if (btk_spectator_units_select < 0) then { btk_spectator_units_select = btk_spectator_units_count; };
			
			while {!(alive (btk_spectator_units select btk_spectator_units_select))} do {
				btk_spectator_units_select = btk_spectator_units_select - 1;
				if (btk_spectator_units_select < 0) then {btk_spectator_units_select = btk_spectator_units_count};
			};

			btk_spectator_target = vehicle (btk_spectator_units select btk_spectator_units_select);

		} else {
		
			btk_spectator_units_select = btk_spectator_units_select + 1;
			
			if (btk_spectator_units_select > btk_spectator_units_count) then { btk_spectator_units_select = 0; };
			while {!(alive (btk_spectator_units select btk_spectator_units_select))} do {
				btk_spectator_units_select = btk_spectator_units_select + 1;
				if (btk_spectator_units_select > btk_spectator_units_count) then { btk_spectator_units_select = 0; };
			};

			btk_spectator_target = vehicle (btk_spectator_units select btk_spectator_units_select);	

		};

		cutText [format[""%1"", name btk_spectator_target],""PLAIN DOWN""];

		if (btk_spectator_cam_enabled) then {

			btk_spectator_cam setpos [((position btk_spectator_target) select 0) + ((sin (getdir btk_spectator_target)) * ( - 10)), ((position btk_spectator_target) select 1) + ((cos (getdir btk_spectator_target)) * (- 10)), ((position btk_spectator_target) select 2) + 2];
			btk_spectator_cam setdir getdir btk_spectator_target;

		} else {

			btk_spectator_target switchCamera ""EXTERNAL"";

		};
		
		btk_spectator_help = false;

	};
"];


// Create the cam
btk_spectator_cam = "camconstruct" camCreate ((vehicle player) modelToWorld [0, 0, 1.75]);
btk_spectator_cam camConstuctionSetParams [(getPosATL (vehicle player)), 20000, 2000];
btk_spectator_cam cameraEffect ["internal", "back"];
btk_spectator_cam camPrepareTarget (vehicle player);