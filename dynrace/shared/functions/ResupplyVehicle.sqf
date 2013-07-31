_magNames = _vehicle getVariable "defaultMagNames";
_magNamesCount = count _magNames;
for [ {_i = 0}, {_i < (_magNamesCount)}, {_i = _i + 1}] do
{
	_vehicle addMagazineTurret [_magNames select _i, [0]];
};