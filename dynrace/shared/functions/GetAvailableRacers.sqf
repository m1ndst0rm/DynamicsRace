/* Return array of all units to use for racing.

*/
private ["_units"];
_units = [];
_unitsToItterate = switchableUnits + playableUnits;
_unitsToItterateCount = count _unitsToItterate;

_i= 0; for "_i" from 0 to (_unitsToItterateCount - 1) do
{
	_unit = _unitsToItterate select _i;
	if(isPlayer _unit || (!(isPlayer _unit) && DYN_ENABLE_AI)) then
	{
		if!(_unit getVariable ["isSpectator", false]) then
		{
			_units set [count _units, _unit];
		};
	};
};
_units;