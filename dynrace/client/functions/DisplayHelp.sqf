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
}
else
{
	if(PLAYER getVariable ["isCommander", false]) then
	{
		_helpText =  "You are the commander.<br/>Press spacebar to get an overview of your availabe actions.<br/>Left mousebutton activates an action<br/>MOUSEWHEEL: Cycle between units<br/>V: Switch view<br/>WASD and MOUSE: Move camera<br/>Q: Move camera up<br/>Y or Z: Move camera down<br/>SHIFT LEFT: Slow movement<br/>Pres H for this information.";
	};

	if (!(DYN_RACE_SPEC_ENABLED) && !(PLAYER getVariable ["isCommander", false])) then
	{ //Place is racer or gunner
		//TODO: Create help for driver, gunner, cops e.t.c?
		_helpText =  "Welcome.<br/>This server runs the Dynamics Race Script.<br/>If a race is currently not in progress you can start a vote by pressing V.";
	};

	if(PLAYER getVariable ["isCat", false]) then
	{
		_helpText =  "You are a cat, defend your s mouse and obstruct the<br/>mouses of other teams.<br/>Pres R to reset.<br/>Pres H for this information.";
	};

	if(PLAYER getVariable ["isMouse", false]) then
	{
		_helpText =  "You are a mouse, try to<br/>the first to get to the finish.<br/>Pres H for this information.";
	};

	if(PLAYER getVariable ["isRobber", false]) then
	{
		_helpText =  "You are a robber, get to the finish line to be safe.<br/>If a cop kills you or makes you halt you lose.<br/>Pres R to reset.<br/>Pres H for this information.";
	};

	if(PLAYER getVariable ["isCop", false]) then
	{
		_helpText =  "You are a cop. Either kill or stop the robbers.<br/>Stop them by making them stand still for more then<br/>5 seconds.Pres R to reset.<br/><br/>Pres H for this information.";
	};
};
(uiNamespace getVariable 'DYN_HELPDIAG') closeDisplay 0;
createDialog "DYN_HELP";
_uiObj = (uiNamespace getVariable 'DYN_HELPDIAG');
_helpTextObj = _uiObj displayCtrl 4061;
_helpTextObj ctrlSetStructuredText parseText _helpText;

true;