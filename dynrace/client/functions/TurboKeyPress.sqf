_key     = _this select 1;
_shift   = _this select 2;
_handled = false;

if(!alive player) exitWith {_handled};

switch _key do
{
	case 17:
	{
        player setvariable ["accelerate",true];// accelerate 
	};
	case 42:
	{
		player setvariable ["boost",true];// nos/boost
	};	
	case 31:
	{
		player setvariable ["accelerate",false];// brake
	};
};
_handled;