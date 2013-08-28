_key     = _this select 1;
_shift   = _this select 2;
_handled = false;

switch _key do
{
	case 203:
	{//left: Car
        ["left"] call DYN_fnc_CarDesignSwitchCar;
	};
	case 205:
	{//right: Car
        ["right"] call DYN_fnc_CarDesignSwitchCar;
	};
	case 200:
	{//up: Side
		["left"] call DYN_fnc_CarDesignSwitchSelectedPart;
	};
	case 208:
	{//down: Side
		["right"] call DYN_fnc_CarDesignSwitchSelectedPart;
	};
	case 30:
	{ //A
		["left",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 32:
	{ //D
		["right",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 17:
	{ //W
		["forward",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 31:
	{ //S
		["backward",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 16:
	{ //Q
		["left"] call DYN_fnc_CarDesignPartSwitch;
	};
	case 18:
	{ //E
		["right"] call DYN_fnc_CarDesignPartSwitch;
	};
	case 19:
	{ //R
		["up",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 33:
	{
		["down",_shift] call DYN_fnc_CarDesignPartMove;
	};
	case 57:
	{ //Space: Add new part
		[] call DYN_fnc_CarDesignNewPart;
	};
	case 14:
	{//backspace: Delete part
		[] call DYN_fnc_CarDesignPartRemove;
	};
	case 28:
	{//enter
		[] call DYN_fnc_CarDesignPick;
	};
};
_handled;