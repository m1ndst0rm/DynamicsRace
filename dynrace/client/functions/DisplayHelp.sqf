/*
	Author: M1nd0

	Description:
	Displays a dialog with information depening on player role.

	Parameter(s):

	Returns:
*/
disableSerialization;
_helpText = "";
if(DYN_RACE_SPEC_ENABLED && DYN_RACE_STATE != "FINISHED" && !(PLAYER getVariable ["isCommander", false])) then
{
	_helpText = "MOUSEWHEEL: Cycle between units<br/>V: Switch view<br/>WASD and MOUSE: Move camera<br/>Q: Move camera up<br/>Y or Z: Move camera down<br/>SHIFT LEFT: Slow movement<br/>While the camera is following a unit, you can change between 1st/3rd person, optics and group view.<br/><br/>Pres H for this information.";
};
if(PLAYER getVariable ["isCommander", false]) then
{
	_helpText =  "You are the commander.<br/>Press spacebar to get an overview of your availabe actions.<br/>Left mousebutton activates an action<br/>MOUSEWHEEL: Cycle between units<br/>V: Switch view<br/>WASD and MOUSE: Move camera<br/>Q: Move camera up<br/>Y or Z: Move camera down<br/>SHIFT LEFT: Slow movement<br/>Pres H for this information.";
};

if (!(DYN_RACE_SPEC_ENABLED) && !(PLAYER getVariable ["isCommander", false])) then
{ //Place is racer or gunner
	//TODO: Create help for driver, gunner, cops e.t.c?
	_helpText =  "Welcome.<br/>This server runs the Dynamics Race Script.<br/>If a race is currently not in progress you can start a vote by pressing V.";
};

(uiNamespace getVariable 'DYN_HELPDIAG') closeDisplay 0;
createDialog "DYN_HELP";
_uiObj = (uiNamespace getVariable 'DYN_HELPDIAG');
_helpTextObj = _uiObj displayCtrl 4061;
_helpTextObj ctrlSetStructuredText parseText _helpText;

true;