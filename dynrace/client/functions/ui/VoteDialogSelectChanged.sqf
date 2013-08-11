private ["_dialog","_list","_item","_textControl","_raceType","_text","_picture","_maxSpeed","_armor","_gears"];
disableSerialization;
_dialog = findDisplay 4000;

_list = _dialog displayctrl 4001;
_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[4001,_item];
_textControl = _dialog displayctrl 4003;
if !(isNil {_item}) then 
{
	switch (DYN_RACE_VOTE_TYPE_CLIENT) do
	{
		case "RACETYPE":
		{
			{
				_raceType = _x select 0;
				if (_raceType == _item) then
				{
					//ctrlSetText [4003, _x select 2];
					_textControl ctrlSetStructuredText parseText (_x select 2);
				};
			} foreach DYN_RACE_TYPES;
		};
		case "DAMAGETYPE":
		{
			_text = "";
			if(_item == "enabled") then
			{
				_text = "Enable damage. Vehicles can be damaged but not destroyed. More damaged vehicles drive slower. Resetting (R) will repair a vehicle but it has a 5 second delay.";
			}
			else
			{
				_text = "Damage disabled. When damaging a enemy you will slow down their vehicle.";
			};
			//ctrlSetText [4003, _text];
			_textControl ctrlSetStructuredText parseText _text;
		};
		case "VEHICLETYPE":
		{
			_picture = getText(configFile >> "CfgVehicles" >> _item >> "picture");
			_maxSpeed = getNumber(configFile >> "CfgVehicles" >> _item >> "maxSpeed");
			_armor = getNumber(configFile >> "CfgVehicles" >> _item >> "armor");
			_gears = count (getArray(configFile >> "CfgVehicles" >> _item >> "gearBox")) - 2;
			
			_text = format["<img size='3' image='%1' /><br/>Maximum speed: %2<br/>Armor: %3<br/>Gears: %4", _picture, _maxSpeed, _armor, _gears];
			
			_textControl ctrlSetStructuredText parseText _text;
		};
	};
};