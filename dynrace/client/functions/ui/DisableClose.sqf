private["_keypressed","_return"];
_keypressed = _this select 1;
_return = false;

#define KEYSCODE_ESC_KEY    1

// disable esc while in dialog
switch (_keypressed) do
{
    case KEYSCODE_ESC_KEY:
    {
		if! (DYN_RACE_DEBUG_ENABLED || false) then
		{
			_return = true;
		};
    };
};
_return;