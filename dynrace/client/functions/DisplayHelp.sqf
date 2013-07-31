if(DYN_RACE_SPEC_ENABLED && DYN_RACE_STATE != "FINISHED") then
{
	hintC "MOUSEWHEEL: Cycle between units\nLEFT MOUSE BUTTON: Freelook\nRIGHT MOUSE BUTTON: Camera follows unit\nWASD and MOUSE: Move camera\nQ: Move camera up\nY or Z: Move camera down\nSHIFT LEFT: Slow movement\nWhile the camera is following a unit, you can change between 1st/3rd person, optics and group view.\n\nPres H for this information.";
};
if(PLAYER getVariable ["isCommander", false]) then
{
	hintC "You are the commander. Open the map (M) to get an overview of the race.\n\nYou can use the dialog functions in the mapview as you wishes.\n\nMOUSEWHEEL: Cycle between units\nLEFT MOUSE BUTTON: Freelook\nRIGHT MOUSE BUTTON: Camera follows unit\nWASD and MOUSE: Move camera\nQ: Move camera up\nY or Z: Move camera down\nSHIFT LEFT: Slow movement\nWhile the camera is following a unit, you can change between 1st/3rd person, optics and group view.\n\nPres H for this information.";
};

if (!(DYN_RACE_SPEC_ENABLED) && !(PLAYER getVariable ["isCommander", false])) then
{ //Place is racer or gunner
	//TODO: Create help for driver, gunner, cops e.t.c.

};
true;