/* DYN_RACE_Debug: Display debug when debug mode is enabled
* Displays debug when DYN_RACE_DEBUG_ENABLED = true;
*
* Example: ["Test"] call DYN_RACE_Debug;
*/
if(DYN_RACE_DEBUG_ENABLED) then
{
	diag_log _this select 0;
};