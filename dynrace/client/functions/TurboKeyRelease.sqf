private["_handled"];

_key     = _this select 1;
_shift   = _this select 2;
_handled = false;

if(!alive player) exitWith {_handled};

//player sidechat str _key;
player setvariable ["accelerate",false];// terminate acceleration
player setvariable ["boost",false];     // terminate NOS/Boost

_handled;