disableSerialization;
_dialog = findDisplay 4000;

_list = _dialog displayctrl 4001;
_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[4001,_item];

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
					ctrlSetText [4003, _x select 2];
				};
			} foreach DYN_RACE_TYPES;
		};
		case "DAMAGETYPE":
		{
			_text = "";
			if(_item == "enabled") then
			{
				switch (DYN_RACE_TYPE) do
				{
					case "SINGLE":
					{
						_text = "Normal race with damage enabled. Being destroyed means losing. When resetting the vehicle only damage to tires will be restored.";
					};
					case "DUAL":
					{
						_text = "Driver/Gunner race with damage enabled, but reduced. Being destroyed means losing. When resetting the vehicle only damage to tires will be restored.";
					};
					case "CAT&MOUSE":
					{
						_text = "Cat & Mouse race with damage enabled. Being destroyed means losing. When resetting the vehicle only damage to tires will be restored.";
					};
				};
			}
			else
			{
				switch (DYN_RACE_TYPE) do
				{
					case "SINGLE":
					{
						_text = "Normal race with damage disabled.";
					};
					case "DUAL":
					{
						_text = "Driver/Gunner race with damage disabled. Hitting an oponent will slow them down.";
					};
					case "CAT&MOUSE":
					{
						_text = "Cat & Mouse race with damage disabled.";
					};
				};
			};
			ctrlSetText [4003, _text];
		};
		case "VEHICLETYPE":
		{
			_picture = getText(configFile >> "CfgVehicles" >> _item >> "picture");
			ctrlSetText [4003, _picture];
		};
	};
};