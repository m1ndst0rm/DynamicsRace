if!(isDedicated) then
{
	_text = format["<t align='center' valign='middle' size='1.8'>%1</t>", DYN_RACE_DISPLAYMESSAGE];
	[_text, -1, 0.05, 2, 0, 0, 11112] spawn BIS_fnc_dynamicText;
};